`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2024 19:08:11
// Design Name: 
// Module Name: axis_m
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


module axis_m(
    input  wire m_axis_aclk,
    input  wire m_axis_aresetn,
    input  wire newd,
    input  wire [7:0] din,
    input  wire m_axis_tready,
    output wire m_axis_tvalid,
    output wire [7:0] m_axis_tdata,
    output wire m_axis_tlast 
    );
    
    typedef enum bit {idle = 1'b0, tx = 1'b1} state_type;
    state_type state = idle, next_state = idle;
    
    reg [2:0] count = 0;
    
    
    always@(posedge m_axis_aclk)
    begin
    if(m_axis_aresetn == 1'b0)
        state <= idle;
    else
        state <= next_state;
    end
    
    
    always@(posedge m_axis_aclk)
    begin
    if(state == idle)
       count <= 0;       
    else if(state == tx && count != 3 && m_axis_tready == 1'b1)
        count <= count +1;
    else
        count <= count;
    end
    
    
    always@(*)
    begin
       case(state)
               idle:
               begin  
                    if(newd == 1'b1)
                      next_state = tx;
                    else
                      next_state = idle;
               end
               
               tx:
               begin
                    if(m_axis_tready == 1'b1)
                    begin                    
                        if(count != 3)
                        next_state  = tx;
                        else
                        next_state  = idle;
                    end
                    else
                    begin
                        next_state  = tx;
                    end 
                end
               
               default: next_state = idle;
               
               endcase
        
        end
        
 assign m_axis_tdata   = (m_axis_tvalid) ? din*count : 0;   
 assign m_axis_tlast   = (count == 3 && state == tx)    ? 1'b1 : 0;
 assign m_axis_tvalid  = (state == tx ) ? 1'b1 : 1'b0;
  
  
endmodule
