class Generator;
  randc bit[1:0]tt;
  rand bit in;
  constraint in_c{
    in dist {1:=50,0:=50};}
endclass

module tb;
  reg clk,in;
  reg [1:0]tt;
  wire [1:0]temp,temp_time;
  wire out;
  oven DUT(clk,in,temp,temp_time,tt, out);
  Generator g;
  initial 
    begin
      g=new();
      for(int i=0;i<50;i++)
        begin
          assert(g.randomize())
            else
              $display("Randomization Failed");
          #5 clk=~clk;
          in=g.in;
          #2 tt=g.tt;
          $display("Value of in:%0b | tt:%0b| trmp_time:%0d | temp:%0d | out:%0b", in, tt, temp_time, temp, out);
        end
    end
  initial begin
    clk=0;
    $dumpfile("dump.vcd");
    $dumpvars;
    #200 $finish;
  end
endmodule
