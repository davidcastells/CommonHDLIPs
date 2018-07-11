// VGA Controller
// VGA Controller that reads pixels from a given location on a external memory
// Assuming read latency is 1 
// The vga_sync module computes the hsync, vsync, and the coordinates of the 
// addressed pixel, the memory address where the pixel is stored is computed
// taking into account the base address, the width of the frame, and the color format
// (RGB8) in our case
//
// sync_n and blank_n must come one clock before, together with row and col info
`default_nettype none 

module vga_controller (
    // Clock And Reset Interface:
    clk,
    reset_n,

    // Frame Reader Interface
    master_data_valid,
    master_readdata,
    master_waitrequest,
    master_address,
    master_read,

    // Control Slave Device
    slave_address,
    slave_chipselect,
    slave_write,
    slave_writedata,
    slave_readdata,

    // VGA Interface
    vga_clk,
    blank_n,
    hsync,
    sync_n,
    sync_t,
    R,
    B,
    G,
    vsync);

// VGA Interface
  output             vsync;
  output             hsync;
  reg              hsync;
wire              pre0_hsync;
reg					pre1_hsync;

  output    [7:0] R; // Output Color Channels
  output    [7:0] B;
  output    [7:0] G;
  
  output           blank_n;
  output  [ 31: 0] master_address;
  output           master_read;
  output  [ 31: 0] slave_readdata;
  output           sync_n;
  output           sync_t;
  input            clk;
  input            master_data_valid;
  input   [ 31: 0] master_readdata;
  input            master_waitrequest;
  input            reset_n;
  input   [  1: 0] slave_address;
  input            slave_chipselect;
  input            slave_write;
  input   [ 31: 0] slave_writedata;
  input            vga_clk;

  
  wire             display_active /* synthesis keep */;
  wire     [ 31: 0] frame_buffer_base_address;
  wire 		[7:0]		memory_latency;

  reg              hblank;


// Slave Interface
  wire    [ 31: 0] slave_readdata;      

// Master Interface
  wire    [ 31: 0] master_address;
  wire             master_read;

// Internal 
  wire vga_start;   // signal to enable the ouput of video
  wire    [  9: 0] row_counter;
  wire    [ 10: 0] column_counter;

   vga_sync the_sync(
                        // inputs:
                         .vga_clk(vga_clk),
                         .reset_n(reset_n),
                         .vga_start(vga_start),
								 .memory_latency(memory_latency),

                        // outputs:
                         .blank_n(blank_n),
                         .hsync(pre0_hsync),
                         .sync_n(sync_n),
                         .sync_t(sync_t),
                         .vsync(vsync),
                         .column_counter(column_counter),
                         .row_counter(row_counter),
								 .display_active(display_active)
                      );  



  vga_registers regs(.clk(clk),
                    .reset_n(reset_n),
                    .slave_address(slave_address),
                    .slave_chipselect(slave_chipselect),
                    .slave_write(slave_write),
                    .slave_writedata(slave_writedata),
                    // outputs
                    .slave_readdata(slave_readdata),
                    .vga_start(vga_start),
                    .frame_buffer_base_address(frame_buffer_base_address),
						  .memory_latency(memory_latency),
);

parameter frame_width = 320;
parameter frame_width_4 = (320/4);

wire [31:0] pixel_index /* synthesis keep */;
wire [1:0] pixel_byte_index /* synthesis keep */;

wire [  8: 0] downsampled_row /* synthesis keep */;
wire [ 9: 0] downsampled_column /* synthesis keep */;

assign downsampled_row = row_counter[9:1];
assign downsampled_column = column_counter[10:1];

assign pixel_index = (downsampled_row*frame_width+downsampled_column);
assign pixel_byte_index = downsampled_column[1:0];
assign master_address = frame_buffer_base_address + pixel_index;
assign master_read = vga_start;

reg [7:0] pixel_value;
reg [1:0] last_pixel_byte_index;
reg [1:0] last_pixel_byte_index1;
reg [1:0] last_pixel_byte_index2;
reg [1:0] last_pixel_byte_index3;
reg [1:0] last_pixel_byte_index4;

  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
         begin
           pixel_value <= 0;
           last_pixel_byte_index <= 0;
           last_pixel_byte_index1 <= 0;
           last_pixel_byte_index2 <= 0;
			  last_pixel_byte_index3 <= 0;
			  last_pixel_byte_index4 <= 0;

         end
      else 
         begin
			  last_pixel_byte_index4 <= pixel_byte_index;
			  last_pixel_byte_index3 <= last_pixel_byte_index4;
			  last_pixel_byte_index2 <= last_pixel_byte_index3;
			  last_pixel_byte_index1 <= last_pixel_byte_index2;
           last_pixel_byte_index <= last_pixel_byte_index1;

           if (blank_n == 0)
              pixel_value <= 0;
           else if (last_pixel_byte_index== 0)   
               pixel_value <= master_readdata[31:24];
           else if (last_pixel_byte_index == 1)
               pixel_value <= master_readdata[23:16];
           else if (last_pixel_byte_index == 2)
               pixel_value <= master_readdata[15:8];
           else
               pixel_value <= master_readdata[7:0];
         end
    end

// 2+3+3 = 
assign R = { pixel_value[7:6], pixel_value[6], pixel_value[6], pixel_value[6], pixel_value[6], pixel_value[6], pixel_value[6]};
assign G = { pixel_value[5:3], pixel_value[3], pixel_value[3], pixel_value[3], pixel_value[3], pixel_value[3]};
assign B = { pixel_value[2:0], pixel_value[0], pixel_value[0], pixel_value[0], pixel_value[0], pixel_value[0]};


// hsync is delayed 1 clock to match the latency of the frame buffer memory
// ready operation
  always @(posedge vga_clk or negedge reset_n)
    begin
      if (reset_n == 0)
		begin
          hsync <= 0;
          pre1_hsync <= 0;
		end
      else 
          pre1_hsync <= pre0_hsync;
          hsync <= pre1_hsync;
    end


endmodule

