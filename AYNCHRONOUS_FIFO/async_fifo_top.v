module async_fifo #(parameter DEPTH = 8, DATA_WIDTH = 8) (
    input  wclk, rclk, wrst_n, rrst_n, w_en, r_en,
    input  [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out,
    output full, empty
);
  
  parameter PTR_WIDTH = $clog2(DEPTH);
  
  wire [PTR_WIDTH:0] b_wptr, b_rptr;
  wire [PTR_WIDTH:0] g_wptr, g_rptr;
  wire [PTR_WIDTH:0] g_wptr_sync, g_rptr_sync;
  
  sync #(PTR_WIDTH) sync_w2r (
    .clk(rclk),
    .rst_n(rrst_n),
    .d_in(g_wptr),
    .q_out(g_wptr_sync)
  );
  
  sync #(PTR_WIDTH) sync_r2w (
    .clk(wclk),
    .rst_n(wrst_n),
    .d_in(g_rptr),
    .q_out(g_rptr_sync)
  );
  
  wptr_handler #(PTR_WIDTH) h_wptr (
    .wclk(wclk),
    .wrst_n(wrst_n),
    .w_en(w_en),
    .g_rptr_sync(g_rptr_sync),
    .b_wptr(b_wptr),
    .g_wptr(g_wptr),
    .full(full)
  );
  
  rptr_handler #(PTR_WIDTH) h_rptr (
    .rclk(rclk),
    .rrst_n(rrst_n),
    .r_en(r_en),
    .g_wptr_sync(g_wptr_sync),
    .b_rptr(b_rptr),
    .g_rptr(g_rptr),
    .empty(empty)
  );
  
  fifo_mem #(DEPTH, DATA_WIDTH, PTR_WIDTH) fifo_mem_top (
    .wclk(wclk), 
    .w_en(w_en), 
    .full(full),
    .b_wptr(b_wptr),
    .b_rptr(b_rptr),
    .data_in(data_in),
    .data_out(data_out)
  );
  
endmodule