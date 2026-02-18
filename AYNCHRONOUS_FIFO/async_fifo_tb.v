`timescale 1ns/1ps

module async_fifo_tb;

  parameter DEPTH = 16;
  parameter DATA_WIDTH = 8;
  parameter PTR_WIDTH = $clog2(DEPTH);

  reg wclk, rclk;
  reg wrst_n, rrst_n;
  reg w_en, r_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire full, empty;

  // Instantiate the Async FIFO
  async_fifo #(
    .DEPTH(DEPTH),
    .DATA_WIDTH(DATA_WIDTH)
  ) dut (
    .wclk(wclk),
    .rclk(rclk),
    .wrst_n(wrst_n),
    .rrst_n(rrst_n),
    .w_en(w_en),
    .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock Generation
  initial wclk = 0;
  always #5 wclk = ~wclk; // 100MHz

  initial rclk = 0;
  always #12.5 rclk = ~rclk; // 40MHz

  // Reset Logic
  initial begin
    wrst_n = 0;
    rrst_n = 0;
    w_en = 0;
    r_en = 0;
    data_in = 0;

    #50;
    wrst_n = 1;
    rrst_n = 1;
    
    #100; // Wait longer for synchronization to clear
    
    // Test Case 1: Sequential Write and Read
    $display("--- Test Case 1: Write 5 elements then Read 5 elements ---");
    repeat (5) @(posedge wclk) write_data($random % 256);
    @(posedge wclk) w_en = 0;
    
    #100; // Delay to allow sync

    repeat (5) @(posedge rclk) read_data();
    @(posedge rclk) r_en = 0;

    #200;

    // Test Case 2: Fill until Full
    $display("--- Test Case 2: Fill until Full ---");
    while (!full) @(posedge wclk) write_data($random % 256);
    @(posedge wclk) w_en = 0;
    $display("FIFO is Full!");

    #200;

    // Test Case 3: Empty until Empty
    $display("--- Test Case 3: Empty until Empty ---");
    while (!empty) @(posedge rclk) read_data();
    @(posedge rclk) r_en = 0;
    $display("FIFO is Empty!");

    #200;
    
    // Test Case 4: Simultaneous Write and Read
    $display("--- Test Case 4: Simultaneous Write and Read ---");
    fork
      begin
        repeat (30) begin
           @(posedge wclk);
           if (!full) write_data($random % 256);
           else w_en = 0;
        end
        @(posedge wclk) w_en = 0;
      end
      begin
        #100;
        repeat (30) begin
           @(posedge rclk);
           if (!empty) read_data();
           else r_en = 0;
        end
        @(posedge rclk) r_en = 0;
      end
    join

    $display("Simulation Finished!");
    #100;
    $finish;
  end

  // Tasks for easier stimulation
  task write_data(input [DATA_WIDTH-1:0] val);
    begin
      w_en = 1;
      data_in = val;
      $display("[TIME: %0t] WRITE: data=%h", $time, val);
    end
  endtask

  task read_data();
    begin
      r_en = 1;
      // Since memory is now asynchronous, data_out is valid as soon as b_rptr is updated.
      // We sample after a small delta.
      #1; 
      $display("[TIME: %0t] READ: data=%h", $time, data_out);
    end
  endtask

  // Monitor
  initial begin
    $monitor("At time %0t: Full=%b, Empty=%b", $time, full, empty);
  end

  initial begin
    $dumpfile("async_fifo_tb.vcd");
    $dumpvars(0, async_fifo_tb);
  end

endmodule
