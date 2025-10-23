// core.v — simple state generator
module core(
  input clk,
  input rst,
  input [7:0] inj_data,    // injected data from testbench (optional)
  input inj_en,
  output reg [7:0] counter,
  output reg [7:0] status
);

always @(posedge clk or posedge rst) begin
  if (rst) begin
    counter <= 8'd0;
    status <= 8'd0;
  end else begin
    counter <= counter + 1;
    if (inj_en)
      status <= inj_data;   // allow testbench injection path
    else
      status <= counter;
  end
end

endmodule
