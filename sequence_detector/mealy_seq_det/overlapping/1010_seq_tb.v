module seq_1010_tb;
reg clk,rst,x;
wire z;
seq_1010 dut(
	.clk(clk),
	.rst(rst),
	.x(x),
	.z(z)
);
initial clk = 0;
always #10 clk = ~clk;
initial begin
	$monitor("clk = %0b | x = %0b | z = %0b",clk,x,z);
	rst = 1;
	x  = 0;
	#25 rst = 0;
	#15 x = 1;
	#20 x = 0;
	#20 x = 1;
	#20 x = 0;
	#20 x = 1;
	#20 x = 0;
	#20 x = 0;
	#20 x = 1;
	#20 x = 1;
	#40;
	$finish;
end

endmodule
