module seq_1010(input wire clk,rst,x,output reg z);
parameter s0 = 3'd0,
	s1 = 3'd1,
	s2 = 3'd2,
	s3 = 3'd3,
	s4 = 3'd4;
reg[2:0] present_state,  next_state;
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
		s3 : next_state  = (x)? s1 : s4;
		s4 : next_state  = (x)? s1 : s0;
		default:next_state = s0;
	endcase
end
always@(*)begin
	z = (present_state == s4);
end
endmodule
