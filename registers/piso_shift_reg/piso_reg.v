module piso #(parameter widht = 4)(input clk,rst,shift,load,
	input [width-1:0]parallel_in,output serial_out);
reg [width-1:0]shift_reg;
always@(posedge clk)begin
	if(rst)begin
		shift_reg <= {width{1'b0}};
		serial_out <= 1'b0;
	end
	else if(load)
		shift_reg <= parallel_in;
	else if(shift)begin
		serial_out <= shift_reg[0];
		shift_reg <= shift_reg >> 1;
	end
end	
endmodule
