module up_count_tb;
reg clk,rst;
wire [3:0] count;
up_count up_dut(.clk(clk),.rst(rst),.q(count));
always #5 clk = ~clk;
initial begin
	clk = 0;
	rst = 1;
	$monitor("time = %0t|clk = %b|rst = %b|count = %b|",$time,clk,rst,count);
	#10 rst = 0;
	#155;
	$finish;
end
initial begin
	$dumpfile("up_count.vcd");
	$dumpvars(0,up_count_tb);
end

endmodule
