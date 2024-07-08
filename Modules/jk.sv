module jk(input clk, reset, j, k, output qout);

   reg q;

   always @(negedge clk) begin // negedge so that input values update at posedge (no r.c.)
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
   reg [1:0] cnt;
   wire	q;


   jk jkFF(clk, reset, cnt[1], cnt[0], q);

   initial begin
      cnt = 2'b00;
      clk = 0;
      reset = 1;
      j = cnt[1];
      k = cnt[0];
      $monitor("clk=%b reset=%b, j=%b k=%b, q=%b", clk, reset, cnt[1], cnt[0], q);
   end

   always @(posedge clk) begin // automatic input generator from 00 to 11
      cnt <= cnt + 2'b01;
   end


   initial begin
      forever #1 clk = ~clk;
   end

   initial fork
      #1 reset = 0;
	   #16 $finish;
   join




endmodule // test
