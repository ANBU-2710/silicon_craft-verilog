module pipo_tb;
reg clk,rst,load;
reg [3:0] parallel_in;
wire [3:0] parallel_out;
pipo pipo_dut(.clk(clk),.rst(rst),.load(load),.parallel_in(parallel_in),.parallel_out(parallel_out));
always #5 clk = ~clk;
initial begin
	$monitor("time = %0t | rst = %b | parallel_in = %b | parallel_out = %b",$time,rst,parallel_in,parallel_out);
	clk = 0;
	rst = 1;
	load = 0;
	parallel_in = 4'b0000;
	#10;
	rst = 0;
	#10;
	load = 1;
	parallel_in = 4'b1001;
	#10;
	load = 0;
	#10;
	load = 1;
	parallel_in = 4'b1101;
	#10;
	load = 0;
	#20 $finish;
end
initial begin
	$dumpfile("pipo.vcd");
	$dumpvars(0,pipo_tb);
end
endmodule
