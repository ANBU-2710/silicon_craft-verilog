module siso #(parameter width = 4)(input clk,rst,serial_in,output serial_out);
reg [width-1:0]shift_reg;
always@(posedge clk)begin
	if(rst)
		shift_reg <= {width{1'b0}};
	else
		shift_reg <= {serial_in,shift_reg[width-1:1]};
end
assign serial_out = shift_reg[0];
endmodule
