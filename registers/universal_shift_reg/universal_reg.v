module uni_reg(input clk,rst,shift_r_in,shift_l_in,
	input [1:0]sel,input[3:0]parallel_in,output reg[3:0]parallel_out);
always@(posedge clk)begin
	if(rst)begin
		parallel_out <= 4'b0000;
	end
	else begin
		case(sel)
			2'b00 : parallel_out <= parallel_out;
			2'b01 : parallel_out <= {shift_r_in,parallel_out[3:1]};
			2'b10 : parallel_out <= {parallel_out[2:0],shift_l_in};
			2'b11 : parallel_out <= parallel_in;
		endcase
	end
end
endmodule
