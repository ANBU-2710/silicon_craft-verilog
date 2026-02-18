module fifo_mem #(parameter DEPTH = 8, DATA_WIDTH = 8, PTR_WIDTH = 3) (
    input wclk, w_en, full,
    input [PTR_WIDTH:0] b_wptr, b_rptr,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);
  reg [DATA_WIDTH-1:0] fifo [0:DEPTH-1];
  
  // Write operation (synchronous)
  always @(posedge wclk) begin
    if (w_en & !full)
      fifo[b_wptr[PTR_WIDTH-1:0]] <= data_in;
  end
  
  // Read operation (asynchronous/combinatorial for standard FIFO behavior)
  assign data_out = fifo[b_rptr[PTR_WIDTH-1:0]];
  
endmodule
