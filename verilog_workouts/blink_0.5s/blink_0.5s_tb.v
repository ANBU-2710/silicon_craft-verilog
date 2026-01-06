module led_blink_tb;
reg clk,rst;
wire led;
led_blink led_dut(.clk(clk),.rst(rst),.led(led));
always #5 clk = ~clk;
initial begin
	clk = 0;
	rst = 1;
	$monitor("time = %0t |rst =%b|led = %b",$time,rst,led);
	#10 rst = 0;
	#500;
	$finish;
end
endmodule
