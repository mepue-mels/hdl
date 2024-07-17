module process_module(input N, r1, r0, b1, b0, output f1, f0, l);
   reg n;
   reg light;

   always @(N) begin
      n = N;
      if (n == 1'b1) begin
         light <= 1'b0;
      end else begin
         light <= 1'b1;
      end
   end


   assign f0 = ( (r0 & ~b1) | (r1 & r0) | (~r0 & b1 & b0) | (~r1 & b1 & ~b0) );
   assign f1 = (r1 | (r0 & b1 & b0));

   assign l = light;

endmodule // process_module

module tb;
   reg N, r1, r0, b1, b0;
   reg clk;
   wire f1, f0, l;



   process_module pm(N, r1, r0, b1, b0, f1, f0, l);

   initial begin
      N = 1'b0;
      r1 = 1'b0;
      r0 = 1'b0;
      b1 = 1'b0;
      b0 = 1'b0;
      clk = 0;
      $monitor("clk=%b f1=%b f0=%b l=%b", clk, f1, f0, l);
   end

   initial begin
      forever #1 clk = ~clk;
   end

   initial fork
      #1 r1 = 1'b1;
      #10 r0 = 1'b1;
      #20 N = 1'b1;
      #30 $finish;
   join



 


endmodule // tb
