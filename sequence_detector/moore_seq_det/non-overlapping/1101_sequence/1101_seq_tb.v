module seq_1101_tb;
reg clk,rst,x;
wire z;
seq_1101 dut(
	.clk(clk),
	.rst(rst),
	.x(x),
	.z(z)
);
initial clk = 0;
always #5 clk = ~clk;
initial begin
	$monitor("rst = %0b | x = %0b | z = %0b",rst,x,z);
	rst = 1;
	x  = 0;
	#12 rst = 0;
	#7 x = 1;
	#10 x = 1;
	#10 x = 0;
	#10 x = 1;
	#10 x = 0;
	#10 x = 1;
	#10 x = 0;
	#10 x = 0;
	#10 x = 1;
	#10 x = 1;
	#10 x = 0;
	#10 x = 1;
	#10 x = 0;
	#10 x = 0;
	#20;
	$finish;
end
initial begin
	$dumpfile("seq_1101.vcd");
	$dumpvars(0,seq_1101_tb);
end

endmodule
