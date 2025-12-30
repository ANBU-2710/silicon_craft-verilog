module mod_n_count_tb;
reg clk,rst;
wire [3:0] count;

mod_n_count #(.n(10),.width(4)) mod_n_count_dut(.clk(clk),.rst(rst),.count(count));

always #5 clk = ~clk;

initial begin
	clk = 0;
	rst = 1;
	
	$monitor("time = %0t|rst = %b|count = %b|",$time,rst,count);

	#10;
	rst = 0;
	#110;
	$finish;
end
initial begin 
	$dumpfile("mod_n_counter.vcd");
	$dumpvars(0,mod_n_count_tb);
end
endmodule
