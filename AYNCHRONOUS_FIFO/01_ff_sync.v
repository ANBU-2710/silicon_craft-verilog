module sync #(parameter WIDTH = 3) (
    input clk, rst_n,
    input [WIDTH:0] d_in,
    output reg [WIDTH:0] q_out
);
  
  reg [WIDTH:0] q1;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q1    <= 0;
      q_out <= 0;
    end else begin
      q1    <= d_in;
      q_out <= q1;
    end
  end
  
endmodule
