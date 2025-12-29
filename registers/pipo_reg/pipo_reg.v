module pipo(input clk,rst,load,
	input [3:0] parallel_in,output [3:0]parallel_out);
reg[3:0]pipo_reg;
always@(posedge clk)begin
	if(rst)begin
		pipo_reg <= 4'b0000;
	end
	else if(load)begin
		pipo_reg <= parallel_in;
	end
end
assign parallel_out = pipo_reg;
endmodule
