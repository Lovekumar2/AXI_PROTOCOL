`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2024 17:27:10
// Design Name: 
// Module Name: axis_round_tb
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


module axis_round_tb;
 reg aclk = 0;
 reg aresetn;
 wire s_axis_tready1;
 wire s_axis_tready2;
 reg s_axis_tvalid1;
 reg s_axis_tvalid2;
 reg [7:0] s_axis_tdata1;
 reg [7:0] s_axis_tdata2;
 reg s_axis_tlast1;
 reg s_axis_tlast2;
 reg m_axis_tready;
 wire m_axis_tvalid;
 wire [7:0] m_axis_tdata;
 wire m_axis_tlast;

 // Instantiate the axis_arb module
 axi_round_arb dut (
 .aclk(aclk),
 .aresetn(aresetn),
 .s_axis_tready1(s_axis_tready1),
 .s_axis_tready2(s_axis_tready2),
 .s_axis_tvalid1(s_axis_tvalid1),
 .s_axis_tvalid2(s_axis_tvalid2),
 .s_axis_tdata1(s_axis_tdata1),
 .s_axis_tdata2(s_axis_tdata2),
 .s_axis_tlast1(s_axis_tlast1),
 .s_axis_tlast2(s_axis_tlast2),
 .m_axis_tready(m_axis_tready),
 .m_axis_tvalid(m_axis_tvalid),
 .m_axis_tdata(m_axis_tdata),
 .m_axis_tlast(m_axis_tlast)
 );

always #10 aclk = ~aclk;

initial begin
aresetn = 0;
repeat(10) @(posedge aclk);
aresetn = 1;
for(int i = 0; i < 5; i++)
begin
@(posedge aclk);
s_axis_tvalid1 = 1;
s_axis_tvalid2 = 0;
s_axis_tlast1 = 0;
s_axis_tlast2 = 0;
s_axis_tdata1 = $random();
s_axis_tdata2 = $random();
m_axis_tready = 1;
end
@(posedge aclk);
s_axis_tdata1 = $random();
s_axis_tlast1 = 1;
@(posedge aclk);
s_axis_tlast1 = 0;
s_axis_tvalid1 = 0;

for(int i = 0; i < 5; i++)
begin
@(posedge aclk);
s_axis_tvalid1 = 0;
s_axis_tvalid2 = 1;
s_axis_tdata1 = $random();
s_axis_tdata2 = $random();
m_axis_tready = 1;
s_axis_tlast2 = 0;
end
@(posedge aclk);
s_axis_tdata2 = $random();
s_axis_tlast2 = 1;
@(posedge aclk);
s_axis_tlast2 = 0;
s_axis_tvalid2 = 0;
$stop;
end
 // Testbench code here
 // You can apply stimulus to the input ports and monitor the output ports
endmodule
