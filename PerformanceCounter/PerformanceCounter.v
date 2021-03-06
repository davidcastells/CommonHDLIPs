  module PerformanceCounter ( 
reset,
 chipselect,
 writedata,
 byteenable,
 address,
 read,
 write,
 readdata,
 clk);
input  reset;
input  chipselect;
input [31:0] writedata;
input [3:0] byteenable;
input [2:0] address;
input  read;
input  write;
input  clk;
output [31:0] readdata;

  wire [31:0] VerilogWire_1452;
  wire [63:0] mux_out_1528;
  wire  vcc_1534;
  wire [63:0] VerilogWire_1446;
  wire [31:0] VerilogWire_1490;
  wire [63:0] out_out_1523;
  wire [63:0] out_out_1485;
  wire  and_out_1441;
  wire  and_out_1431;
  wire  clk_1643;
  wire  or_out_1447;
  wire  inv_out_1422;
  wire  or_out_1540;
  wire  and_out_1436;
  wire  gnd_1537;
  wire  and_out_1426;


assign inv_out_1422 = ~address[0];

assign and_out_1426= chipselect&inv_out_1422;

assign and_out_1431= chipselect&address[0];

assign and_out_1436= write&and_out_1426;

assign and_out_1441= write&and_out_1431;

assign or_out_1447= and_out_1436|and_out_1441;

assign out_out_1485= {VerilogWire_1452,writedata};

assign out_out_1523= {writedata,VerilogWire_1490};

  performance_mux_2to1_w64_ws1 Muxi1529 ( out_out_1485, out_out_1523, and_out_1441, mux_out_1528);

assign vcc_1534 = 1'b1;

assign gnd_1537 = 1'b0;

assign or_out_1540= vcc_1534|gnd_1537|or_out_1447;

  performance_upDownCounter_i1546 upDownCounteri1546 ( or_out_1447, mux_out_1528, vcc_1534, or_out_1540, VerilogWire_1446, reset, clk);

  performance_mux_2to1_w32_ws1 Muxi1719 ( VerilogWire_1490, VerilogWire_1452, and_out_1431, readdata);



assign VerilogWire_1490 = {VerilogWire_1446[31],VerilogWire_1446[30],VerilogWire_1446[29],VerilogWire_1446[28],VerilogWire_1446[27],VerilogWire_1446[26],VerilogWire_1446[25],VerilogWire_1446[24],VerilogWire_1446[23],VerilogWire_1446[22],VerilogWire_1446[21],VerilogWire_1446[20],VerilogWire_1446[19],VerilogWire_1446[18],VerilogWire_1446[17],VerilogWire_1446[16],VerilogWire_1446[15],VerilogWire_1446[14],VerilogWire_1446[13],VerilogWire_1446[12],VerilogWire_1446[11],VerilogWire_1446[10],VerilogWire_1446[9],VerilogWire_1446[8],VerilogWire_1446[7],VerilogWire_1446[6],VerilogWire_1446[5],VerilogWire_1446[4],VerilogWire_1446[3],VerilogWire_1446[2],VerilogWire_1446[1],VerilogWire_1446[0]};
assign VerilogWire_1452 = {VerilogWire_1446[63],VerilogWire_1446[62],VerilogWire_1446[61],VerilogWire_1446[60],VerilogWire_1446[59],VerilogWire_1446[58],VerilogWire_1446[57],VerilogWire_1446[56],VerilogWire_1446[55],VerilogWire_1446[54],VerilogWire_1446[53],VerilogWire_1446[52],VerilogWire_1446[51],VerilogWire_1446[50],VerilogWire_1446[49],VerilogWire_1446[48],VerilogWire_1446[47],VerilogWire_1446[46],VerilogWire_1446[45],VerilogWire_1446[44],VerilogWire_1446[43],VerilogWire_1446[42],VerilogWire_1446[41],VerilogWire_1446[40],VerilogWire_1446[39],VerilogWire_1446[38],VerilogWire_1446[37],VerilogWire_1446[36],VerilogWire_1446[35],VerilogWire_1446[34],VerilogWire_1446[33],VerilogWire_1446[32]};

endmodule
