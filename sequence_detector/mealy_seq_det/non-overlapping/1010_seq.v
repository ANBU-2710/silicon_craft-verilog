module seq_1010(input wire clk,rst,x,output z);
parameter s0 = 2'd0,
        s1 = 2'd1,
        s2 = 2'd2,
        s3 = 2'd3;
reg[1:0] present_state,  next_state;
always@(posedge clk or posedge rst)begin
        if(rst)begin
                present_state <= s0;
        end
        else present_state <= next_state;
end
always@(*)begin
        case(present_state)

                s0 : next_state  = (x)? s1 : s0;
                s1 : next_state  = (x)? s1 : s2;
                s2 : next_state  = (x)? s3 : s0;
                s3 : next_state  = (x)? s1 : s0;
                default:next_state = s0;
        endcase
end
assign z = (present_state == s3 && x == 0)? 1:0;

endmodule
