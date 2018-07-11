// VGA Controller Registers
// A memory mapped Avalon Bus Slave with following regiters 
// Offset:     Register:
// -----------------------------------
// 0x0         Command / Control Register
// 0x4         Base Reading Address of the frame buffer
// 0x8			Memory Latency
// 0xc
// 
module vga_registers (
                        // inputs:
                         clk,
                         reset_n,
                         slave_address,
                         slave_chipselect,
                         slave_write,
                         slave_writedata,

                        // outputs:
                         slave_readdata,
                         vga_start,
                         frame_buffer_base_address,
								 memory_latency
                      );

output vga_start;  
  output  [ 31: 0] slave_readdata;
  input            clk;
  input            reset_n;
  input   [  1: 0] slave_address;
  input            slave_chipselect;
  input            slave_write;
  input   [ 31: 0] slave_writedata;

  
  wire    [ 31: 0] address_counter;
  wire             address_counter_incr;
  wire             address_counter_sload;
  wire    [ 29: 0] address_counter_temp;
  wire    [ 10: 0] column_counter;
  wire    [  2: 0] config_counter;
  wire             ctrl_reg_go_bit;
  reg     [ 31: 0] current_dma;
  wire             display_active;
  output  [7:0]	 memory_latency;
  reg     [7: 0]   memory_latency;
  output  [31: 0]  frame_buffer_base_address;
  reg     [31: 0]  frame_buffer_base_address;
  reg              go_bit;
  reg              go_bit_vga;
  reg              go_bit_vga_reg1;
  wire    [  9: 0] row_counter;
  reg     [ 31: 0] slave_control_reg;
  wire    [ 31: 0] slave_readdata;
  wire             stop_config_counter;
  reg              vga_start;

  assign slave_readdata = ((slave_address == 0))? slave_control_reg :
    ((slave_address == 1))? frame_buffer_base_address :
    ((slave_address == 2))? memory_latency :
    ((slave_address == 3))? current_dma :
    slave_control_reg;


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          slave_control_reg <= 0;
      else if (slave_write && slave_chipselect && (slave_address == 0))
          slave_control_reg <= slave_writedata;
    end

  assign ctrl_reg_go_bit = slave_control_reg[0];
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          frame_buffer_base_address <= 0;
      else if (slave_write && slave_chipselect && (slave_address == 1))
          frame_buffer_base_address <= slave_writedata;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          memory_latency <= 0;
      else if (slave_write && slave_chipselect && (slave_address == 2))
          memory_latency <= slave_writedata[7:0];
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          current_dma <= 0;
      else if (address_counter_sload)
          current_dma <= slave_writedata;
    end

  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          go_bit_vga_reg1 <= 0;
      else 
        go_bit_vga_reg1 <= go_bit;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          go_bit_vga <= 0;
      else 
        go_bit_vga <= go_bit_vga_reg1;
    end

  always    @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          vga_start <= 0;
      else 
        vga_start <= go_bit_vga; //  | (fifo_has_data & go_bit_vga);
    end

  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          go_bit <= 0;
      else 
        go_bit <= ctrl_reg_go_bit & stop_config_counter; //  & fifo_emptied;
    end


  assign stop_config_counter = config_counter == 3'b101;
  lpm_counter vga_config_counter
    (
      .aclr (!reset_n),
      .clock (clk),
      .cnt_en (!stop_config_counter),
      .q (config_counter)
    );

  defparam vga_config_counter.LPM_WIDTH = 3;

endmodule

