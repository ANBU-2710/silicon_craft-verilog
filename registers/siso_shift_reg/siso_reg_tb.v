module siso_tb;
reg clk,rst,serial_in;
wire serial_out;
siso #(.width(4)) siso_dut(.clk(clk),.rst(rst),.serial_in(serial_in),.serial_out(serial_out));
always #5 clk = ~clk;
initial begin
	$monitor("time = %0t | rst = %b | serial_in = %b | serial_out = %b",$time,rst,serial_in,serial_out);
	clk = 0;
	rst = 1;
	serial_in = 0;
	#10 rst = 0;
	#10 serial_in = 1;
	#10 serial_in = 0;
	#10 serial_in = 0;
	#10 serial_in = 1;
	#30 $finish;
end
initial begin
	$dumpfile("siso.vcd");
	$dumpvars(0,siso_tb);
end
endmodule
