// Code your testbench here
// or browse Examples

module tpg (ctr_interf.TEST intrf);

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, tb);
    intrf.clk = 0;
    intrf.up_down = 0;
    repeat (48) begin
      #5 intrf.clk = ~intrf.clk;
    end
  end
  
  initial begin
    @(posedge intrf.clk);
    intrf.rst = 1'b1;
    @(posedge intrf.clk);
    intrf.rst <= 1'b0;
    intrf.up_down <= 1'b1;
    repeat(8) begin
      @(posedge intrf.clk);
    end
    intrf.up_down <= 1'b0;
    repeat(8) begin
      @(posedge intrf.clk);
    end
    @(posedge intrf.clk);
    intrf.load = 1'b1;
    intrf.seed = 3'h4;
    @(posedge intrf.clk);
    intrf.load = 1'b0;
  end
endmodule

module monitor (ctr_interf.MONITOR intrf);
  initial begin
    $monitor("@%d ticks, direction switch ", $time, intrf.up_down); 
  end
  always@(posedge intrf.clk) begin
    $display("counter: %d", intrf.count);
  end
    
endmodule

module tb;
  
  ctr_interf i1();
  tpg TPG1 (i1);
  ctr CTR1 (i1);
  monitor MTR1 (i1);
endmodule