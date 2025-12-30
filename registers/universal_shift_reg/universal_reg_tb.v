module uni_reg_tb;
reg clk,rst,shift_r_in,shift_l_in;
reg [1:0] sel;
reg [3:0] parallel_in;
wire [3:0] parallel_out;
uni_reg uni_reg_dut(.clk(clk),.rst(rst),.shift_r_in(shift_r_in),.shift_l_in(shift_l_in),.sel(sel),.parallel_in(parallel_in),.parallel_out(parallel_out));
always #5 clk = ~clk;
initial begin
	clk = 0;
	rst = 1;
	shift_r_in = 0;
	shift_l_in = 0;
	parallel_in = 4'b0000;
	sel = 2'b00;
	$monitor("time = %0t|rst = %b|shift_r_in = %b|shift_l_in = %b|parallel_in = %b|parallel_out = %b",$time,rst,shift_r_in,shift_l_in,parallel_in,parallel_out);
	#10;
	rst = 0;
	#10;
	sel = 2'b11;
	parallel_in = 4'b1001;
	#10;
	sel = 2'b00;
	#10;
	sel = 2'b01;
	shift_r_in = 1;
	#10;
	shift_r_in = 0;
	#10;
	sel = 2'b10;
	shift_l_in = 1;
	#10;
	shift_l_in = 0;
	#10;
	sel = 2'b00;
	#20 $finish;
end
initial begin
	$dumpfile("uni_reg.vcd");
	$dumpvars(0,uni_reg_tb);
end



endmodule
