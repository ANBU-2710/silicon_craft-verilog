module ud_count_tb;
reg clk,rst,up_down;
wire [3:0]count;

ud_count ud_count_dut(.clk(clk),.rst(rst),.up_down(up_down),.count(count));

always #5 clk = ~clk;

initial begin 
	clk = 0;
	rst = 1;
	up_down = 0;
	
	$monitor("time = %0t|rst = %b|up_down = %b|count = %b",$time,rst,up_down,count);
	#10;
	rst = 0;
	up_down = 1;
	#155;
	up_down = 0;
	#155;
	$finish;
end
initial begin
	$dumpfile("ud_count.vcd");
	$dumpvars(0,ud_count_tb);
end

endmodule
