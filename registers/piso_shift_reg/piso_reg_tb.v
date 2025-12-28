module piso_tb;
reg clk,rst,shift,load;
reg [3:0]parallel_in;
wire serial_out;
piso #(.width(4)) piso_dut(.clk(clk),.rst(rst),.shift(shift),.load(load),.parallel_in(parallel_in),.serial_out(serial_out));
always #5 clk = ~clk;
initial begin
	$monitor("time = %0t|rst = %b|parallel_in = %b|serial_out = %b|",$time,rst,parallel_in,serial_out); 
	clk = 0;
	rst = 1;
	shift = 0;
	load = 1;
	parallel_in = 4'b0000;
	#10;
       	rst = 0;
	#10; 
	load = 1;
	parallel_in = 4'b1001;
	#10;
       	load = 0;
	shift = 1;
	#40;
       	shift = 0;
       #20 $finish;
end
initial begin 
	$dumpfile("piso.vcd");
	$dumpvars(0,piso_tb);
end
endmodule
