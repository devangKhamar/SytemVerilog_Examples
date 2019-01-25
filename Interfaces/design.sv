// Code your design here

interface ctr_interf;
  logic [2 : 0] count;
  logic [2 : 0] seed;
  logic load;
  logic clk;
  logic rst;
  logic up_down;

  modport DUT (output count,
               input seed, load, clk, rst, up_down);

  modport TEST (input count,
               output seed, load, clk, rst, up_down);  
  modport MONITOR (input count, seed, load, clk, rst, up_down);
endinterface

module ctr (ctr_interf.DUT intrf);

  always@(posedge intrf.clk)
    begin
      if(intrf.rst)
        intrf.count <= 16'h0;
      else if(intrf.load)
        intrf.count <= intrf.seed;
      else
        begin
          if(intrf.up_down)
            intrf.count <= intrf.count + 16'h1;
          else
            intrf.count <= intrf.count - 16'h1;
        end
    end
endmodule