`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2024 15:04:11
// Design Name: 
// Module Name: robin
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


module robin(input clk,rst,
             input req1,req2,
             output reg gnt1,gnt2);

    typedef enum bit [1:0]{idle = 2'b00,s1= 2'b01,s2 = 2'b10} state_type ;
    state_type state ,next_state ;    
    
    always@(posedge clk) begin 
    if(rst)
    state <= idle;
    else
    state <= next_state ;
    end 
    
    always @(*) begin 
    case (state) 
    
    idle:begin 
         if(req1)
         next_state = s1;
         else if(req2)
         next_state = s2;
         else 
          next_state = idle;
       end 
     s1:begin 
        if(req2)
         next_state = s2;
        else if (req1)
         next_state = s1;
        else 
         next_state = idle;
    
     end  
     s2:begin 
        if(req1)
         next_state = s1;
        else if (req2)
         next_state = s2;
        else 
         next_state = idle;
   end 
   default: next_state = idle;    
   endcase 
    end
    always@(*) begin 
    case(state) 
    idle:begin 
      gnt1=1'b0;
      gnt2=1'b1;
    end 
    s1:begin 
       gnt1=1'b1;
      gnt2=1'b0;
    end 
    
  s2:begin 
      gnt1=1'b0;
      gnt2=1'b1;
    end 
      default:begin
      
      gnt1=1'b0;
      gnt2=1'b0;
      
      end   
   endcase     
    end  
  
endmodule
