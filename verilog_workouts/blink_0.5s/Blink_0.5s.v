//Write a Verilog module that blinks an LED at 1 Hz using a 50 MHz clock. The LED must toggle every 0.5 seconds. Inputs are clk and rst, output is led.
module led_blink(input clk,rst,output reg led);
reg [25:0] count;
always@(posedge clk or posedge rst)begin
	if(rst)begin
		count <= 0;
		led <= 0;
	end
	else if(count == 25000000 -1)begin
		count <= 0;
		led <= ~led;
	end
	else 
		count <= count + 1;
end
endmodule
