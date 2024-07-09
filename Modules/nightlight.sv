module tmr(input clk, set,
           output [3:0] x5,
           output [3:0] x4,
           output [3:0] x3,
           output [3:0] x2,
           output [3:0] x1,
           output [3:0] x0); //4 digit timer behavioral

   reg [3:0] ht;
   reg [3:0] ho;
   reg [3:0] mt;
   reg [3:0] mo;
   reg [3:0] st;
   reg [3:0] so;

   reg       nullity;

   always @ (posedge clk) begin
      if (set | nullity) begin
         ht = 4'b0101;
         ho = 4'b1001;
         mt = 4'b0101;
         mo = 4'b1001;
         st = 4'b0101;
         so = 4'b1001;
      end else begin
         if ( so > 4'b0000 ) begin
            so = so - 4'b0001;
         end else if (st > 4'b0000) begin
            so = 4'b1001;
            st = st - 4'b0001;
         end else if (mo > 4'b0000) begin
            so = 4'b1001;
            st = 4'b0101;
            mo = mo - 4'b0001;
         end else if (mt > 4'b0000) begin
            so = 4'b1001;
            st = 4'b0101;
            mo = 4'b1001;
            mt = mt - 4'b0001;
         end else if (ho > 4'b0000) begin
            so = 4'b1001;
            st = 4'b0101;
            mo = 4'b1001;
            mt = 4'b0101;
            ho = ho - 4'b0001;
         end else if (ht > 4'b0000) begin
            so = 4'b1001;
            st = 4'b0101;
            mo = 4'b1001;
            mt = 4'b0101;
            ho = 4'b1001;
            ht = ht - 4'b0001;
         end else begin
            nullity = 1;
         end
      end // else: !if(set | ~nullity)
   end // always @ (posedge clk)

   assign x5 = ht;
   assign x4 = ho;
   assign x3 = mt;
   assign x2 = mo;
   assign x1 = st;
   assign x0 = so;

endmodule // timer


module testbench;
   reg clk, set;
   wire [3:0] x5;
   wire [3:0] x4;
   wire [3:0] x3;
   wire [3:0] x2;
   wire [3:0] x1;
   wire [3:0] x0;


   tmr t(clk, set, x5,x4,x3,x2,x1,x0);

   initial begin
      clk = 0;
      set = 1;
      $monitor("%b %d%d:%d%d:%d%d", clk, x5,x4,x3,x2,x1,x0 );
   end

   initial begin
      forever #1 clk = ~clk;
   end

   initial fork
      #2 set = 0;
      #1000000 $finish;
   join

endmodule // testbench
