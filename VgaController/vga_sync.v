// Info from https://eewiki.net/pages/viewpage.action?pageId=15925278
module vga_sync (
        // inputs:
         vga_clk,
         reset_n,
        vga_start,      // Active when displaying frame

        // outputs:
         blank_n,
         hsync,
         sync_n,
         sync_t,
         vsync,
         column_counter,
         row_counter
      );  
input vga_clk;
input reset_n;
input vga_start;
output blank_n;
reg blank_n;
output 	hsync;
reg 	hsync;
output 	sync_n;
reg 		sync_n;
output 	sync_t;
output 	vsync;
reg 	vsync;
output    [ 10: 0] column_counter;      // max column = 2^10    = 1024
output    [  9: 0] row_counter;         // max row = 2^9        =  512
reg    [ 10: 0] column_counter;      // max column = 2^10    = 1024
reg    [  9: 0] row_counter;         // max row = 2^9        =  512

reg vactive;
reg hactive;

// 640x480 @60 Hz data
parameter MODE_H_DISPLAY = 640;
parameter MODE_H_FRONT_PORCH = 16;
parameter MODE_H_SYNC = 96;
parameter MODE_H_BACK_PORCH = 48;
parameter MODE_V_DISPLAY = 480;
parameter MODE_V_FRONT_PORCH = 10;
parameter MODE_V_SYNC = 2;
parameter MODE_V_BACK_PORCH = 33;
parameter MODE_H_SYNC_POLARITY = 0; // 0 means negative
parameter MODE_V_SYNC_POLARITY = 0; // 0 means negative


  wire    [  2: 0] config_counter;
  wire             display_active;
  reg              hblank;
  wire             stop_config_counter;
  reg              sync_n_init;
  reg              sync_t;
  reg              vblank;



  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0) 
         begin
            column_counter <= 0;
            row_counter <= 0;
         end
      else 
         if (vga_start == 0) 
            begin
               column_counter <= 0;
               row_counter <= 0;
               hactive <= 0; 
               vactive <= 0; 
               vsync <= 1;
               hsync <= 1;
            end
         else
            begin
                if ((column_counter >= 0) && (column_counter < MODE_H_DISPLAY))
                    hactive <= 1;
                else 
                    hactive <= 0;

                if ((row_counter >= 0) && (row_counter < MODE_V_DISPLAY))
                    vactive <= 1;
                else
                    vactive <= 0;

                if ((column_counter >= (MODE_H_DISPLAY+MODE_H_FRONT_PORCH)) 
                    && (column_counter < (MODE_H_DISPLAY+MODE_H_FRONT_PORCH+MODE_H_SYNC)))
                    hsync <= 0;
                else
                    hsync <= 1;

                if ((row_counter >= (MODE_V_DISPLAY+MODE_V_FRONT_PORCH))
                    && (row_counter < (MODE_V_DISPLAY+MODE_V_FRONT_PORCH+MODE_V_SYNC)))
                    vsync <= 0;
                else
                    vsync <= 1;

                if ((column_counter < (MODE_H_DISPLAY+MODE_H_FRONT_PORCH+MODE_H_SYNC+MODE_H_BACK_PORCH)-1))
                  column_counter <= column_counter + 1;
                else
                   begin
                      column_counter <= 0;
                     if ((row_counter < (MODE_V_DISPLAY+MODE_V_FRONT_PORCH+MODE_V_SYNC+MODE_V_BACK_PORCH)-1))
                        row_counter <= row_counter +1 ;
                     else
                        row_counter <= 0;
                   end                
            end
    end


  assign stop_config_counter = config_counter == 3'b101;
  lpm_counter vga_config_counter
    (
      .aclr (!reset_n),
      .clock (vga_clk),
      .cnt_en (!stop_config_counter),
      .q (config_counter)
    );

  defparam vga_config_counter.LPM_WIDTH = 3;

  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sync_n_init <= 0;
      else 
        sync_n_init <= config_counter[2] | (config_counter[0] & !config_counter[1]);
    end



  assign display_active = hactive & vactive;


  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sync_n <= 0;
      else 
        sync_n <= vga_start ? (vsync ~^ hsync) : sync_n_init;
    end


  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sync_t <= 0;
      else 
        sync_t <= vga_start ? 1 : 0;
    end


  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
          blank_n <= 0;
      else 
        blank_n <= display_active;
    end




endmodule

