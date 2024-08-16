`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2024 19:11:09
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb();


reg clk = 0;
reg rst;
reg newd;
reg [7:0] din;
wire [7:0] dout;
wire last;


top_module dut(clk,rst, newd, din, dout, last);


 always #10 clk = ~clk;
 
 initial 
    begin
        // Initialize inputs
        rst = 1'b0;
        repeat(10) @(posedge clk);
        rst = 1'b1;
        for(int i = 0; i <10; i++)
        begin
        @(posedge clk);
        newd = 1;
        din = $urandom_range(0,15);
        @(negedge last);
        end
        $finish;
    end

endmodule

