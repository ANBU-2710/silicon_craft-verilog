module down_count_tb;
reg clk,rst;
wire [3:0] count;
down_count down_dut(.clk(clk),.rst(rst),.q(count));
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
        $dumpfile("down_count.vcd");
        $dumpvars(0,down_count_tb);
end

endmodule
