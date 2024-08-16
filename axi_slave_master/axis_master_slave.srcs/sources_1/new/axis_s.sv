module axis_s(
    input  wire s_axis_aclk,
    input  wire s_axis_aresetn,
    output wire s_axis_tready,
    input  wire s_axis_tvalid,
    input  wire [7:0] s_axis_tdata,
    input  wire s_axis_tlast,
    output wire [7:0] dout
    );

    typedef enum bit [1:0] {idle = 2'b00, store = 2'b01, last_byte = 2'b10} state_type;
    state_type state = idle, next_state = idle;
    
    always@(posedge s_axis_aclk)
    begin
    if(s_axis_aresetn == 1'b0)
    state  <= idle;
    else
    state <= next_state;
    end


    always@(*)
        begin
               case(state)
               idle:
                begin  
                    if(s_axis_tvalid == 1'b1)
                      next_state = store;
                    else
                      next_state = idle;
                end
               
               store:
                begin
                if(s_axis_tlast == 1'b1 && s_axis_tvalid == 1'b1 ) 
                      next_state = idle;
                 else if (s_axis_tlast == 1'b0 && s_axis_tvalid == 1'b1)
                      next_state = store;
                 else
                      next_state = idle;
               end
                
               default: next_state = idle;
               
               endcase
         end
        


assign s_axis_tready = (state == store);
assign dout          = (state == store ) ? s_axis_tdata : 8'h00;


endmodule