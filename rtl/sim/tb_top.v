`timescale 1ns/1ps
module tb_top;
  reg clk=0;
  reg rst=1;
  reg inj_en=0;
  reg [7:0] inj_data=8'h00;
  wire [7:0] voted_counter;
  wire [7:0] voted_status;

  // instantiate wrapper
  tmr_wrapper U (.clk(clk), .rst(rst), .inj_data(inj_data), .inj_en(inj_en),
                 .voted_counter(voted_counter), .voted_status(voted_status));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_top);
    #5 rst = 0;
    #2000 $finish;
  end

  // clock
  always #5 clk = ~clk;

  // optional: small monitor
  always @(posedge clk) begin
    $display("%0t COUNTER=%0d STATUS=%0d", $time, voted_counter, voted_status);
  end

endmodule
