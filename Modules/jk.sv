module jk(input clk, reset, j, k, output qout);

   reg q;

   always @(posedge clk) begin
	  if ( (j == 1) & (k == 1) ) begin
		 q <= ~q;
	  end else if ( (j == 1) & (k == 0) ) begin
		 q <= 1;
	  end else if ( ((j == 0) & (k == 1)) | (reset == 1) ) begin
		 q <= 0;
	  end else begin
		 q <= q;
	  end
   end

   assign qout = q;

endmodule

module test;
   reg clk, reset, j, k;
   wire	q;


   jk jkFF(clk, reset, j, k, q);

   initial begin
	  clk = 0;
	  reset = 1;
	  j = 0;
	  k = 0;
	  $monitor("%b %b, j=%b k=%b", clk, reset, j, k);
   end

   initial begin
	  forever #1 clk = ~clk;
   end

   initial fork
	  #
   join




endmodule // test
