module down_count_tb;
reg clk,rst;
wire [3:0]count;

down_count d_count_dut(.clk(clk),.rst(rst),.count(count));

always #5 clk = ~clk;

initial begin 
	clk = 0;
	rst = 1;
	
	$monitor("time = %0t | rst = %b | count = %b",$time,rst,count);
	#10;
	rst = 0;
	#200;
	$finish;
end
initial begin
	$dumpfile("down_counter.vcd");
	$dumpvars(0,down_count_tb);
end
endmodule
