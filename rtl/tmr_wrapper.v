// tmr_wrapper.v
module tmr_wrapper(
  input clk,
  input rst,
  input [7:0] inj_data,
  input inj_en,
  output [7:0] voted_counter,
  output [7:0] voted_status
);

wire [7:0] c0, c1, c2;
wire [7:0] s0, s1, s2;

// instantiate three cores (replicas)
core core0(.clk(clk), .rst(rst), .inj_data(inj_data), .inj_en(inj_en), .counter(c0), .status(s0));
core core1(.clk(clk), .rst(rst), .inj_data(inj_data), .inj_en(inj_en), .counter(c1), .status(s1));
core core2(.clk(clk), .rst(rst), .inj_data(inj_data), .inj_en(inj_en), .counter(c2), .status(s2));

// simple bitwise majority voter function
function [7:0] majority8;
  input [7:0] a, b, c;
  integer i;
  begin
    for (i=0; i<8; i=i+1) begin
      majority8[i] = (a[i] & b[i]) | (a[i] & c[i]) | (b[i] & c[i]);
    end
  end
endfunction

assign voted_counter = majority8(c0, c1, c2);
assign voted_status  = majority8(s0, s1, s2);

endmodule
