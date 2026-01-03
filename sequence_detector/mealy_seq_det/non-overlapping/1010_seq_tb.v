module seq_1010_tb;
reg clk,rst,x;
wire z;
seq_1010 dut(
        .clk(clk),
        .rst(rst),
        .x(x),
        .z(z)
);
initial clk = 0;
always #5 clk = ~clk;
initial begin
        $monitor("rst = %b| x = %0b | z = %0b",rst,x,z);
        rst = 1;
        x  = 0;
        #12 rst = 0;
        #7 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
	#10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
	#10 x = 1;
	#10 x = 0;
	#10 x = 1;
	#10 x = 0;
        #10;
        $finish;
end
initial begin 
	$dumpfile("seq_1010.vcd");
	$dumpvars(0,seq_1010_tb);
end

endmodule
