`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2024 15:18:21
// Design Name: 
// Module Name: robin_tb
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


module robin_tb;
reg clk,rst,req1,req2;
wire gnt1,gnt2;

robin dut(.clk(clk),.rst(rst),.req1(req1),.req2(req2),.gnt1(gnt1),.gnt2(gnt2));

always #5 clk = ~clk;

initial begin
clk=0;
rst = 1'b1;
repeat(5) @(posedge clk);
rst = 1'b0;
req1=1'b1;
req2 = 1'b0;
@(posedge clk);
req1 = 1'b0;
req2 = 1'b1;
@(posedge clk);
req1=1'b1;
req2=1'b1; 
repeat (5) @(posedge clk);

end 














endmodule
