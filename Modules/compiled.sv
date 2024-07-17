module tmr(input clk, set,
           input [3:0] i5,
           input [3:0] i4,
           input [3:0] i3,
           input [3:0] i2,
           input [3:0] i1,
           input [3:0] i0,
           output [3:0] x5,
           output [3:0] x4,
           output [3:0] x3,
           output [3:0] x2,
           output [3:0] x1,
           output [3:0] x0,
           output N); //4 digit timer behavioral

   reg [3:0] ht;
   reg [3:0] ho;
   reg [3:0] mt;
   reg [3:0] mo;
   reg [3:0] st;
   reg [3:0] so;

   reg       nullity;

   initial begin
      ht = 4'b0000;
      ho = 4'b0000;
      mt = 4'b0000;
      mo = 4'b0000;
      st = 4'b0000;
      so = 4'b0000;
   end


   always @ (posedge clk) begin
      if (set) begin
         ht = i5;
         ho = i4;
         mt = i3;
         mo = i2;
         st = i1;
         so = i0;
      end else begin
         nullity = 1'b0;
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
         end
      end // else: !if(set | ~nullity)

      if ( (ht == 4'b0000) & (ho == 4'b0000) & (mt == 4'b0000) & (mo == 4'b0000) & (st == 4'b0000) & (so == 4'b0000) ) begin
         nullity = 4'b1;
      end
   end // always @ (posedge clk)

   assign x5 = ht;
   assign x4 = ho;
   assign x3 = mt;
   assign x2 = mo;
   assign x1 = st;
   assign x0 = so;
   assign N = nullity;
endmodule // timer


module sensor_value (input clk, output [3:0] sv);
   reg [3:0] s;

   integer seed = 69; //adjust seed every run to make it random every run

   always @(posedge clk) begin
      s <= $dist_normal(seed, 4'b0111, 1);
   end

   assign sv = s;
endmodule


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

module light(input l, output o);
   assign o = l;
endmodule // light

module fan(input f1,f0, output s1,s0);
   assign s1 = f1;
   assign s0 = f0;
endmodule // fan


module tb;
   reg [3:0] i5,i4,i3,i2,i1,i0;
   reg       set;
   reg       clk;

   wire [3:0] x5,x4,x3,x2,x1,x0;
   wire [3:0] sv;
   wire       f1in,f0in;
   wire       f1out, f0out;
   wire       lin;
   wire       lout;
   wire       N;

   initial begin
      set = 0;
      clk = 0;
      i5 = 4'b0000;
      i4 = 4'b0001;
      i3 = 4'b0000;
      i2 = 4'b0000;
      i1 = 4'b0000;
      i0 = 4'b0000;
      $monitor("clk=%b set=%b sv=%b light=%b nullity=%b fan=%b%b %d%d:%d%d:%d%d", clk, set, sv, lout, N, f1out, f0out, x5,x4,x3,x2,x1,x0);
   end

   initial begin
      forever #1 clk = ~clk;
   end

   tmr t(clk, set, i5,i4,i3,i2,i1,i0, x5,x4,x3,x2,x1,x0, N);
   process_module pm(N, sv[3],sv[2],sv[1],sv[0], f1in,f0in,lin);
   sensor_value s(clk, sv);
   light li(lin, lout);
   fan f(f1in,f0in, f1out, f0out);

   initial fork
      #1 set = 1;
      #3 set = 0;
      #10000 $finish;
   join




endmodule; // tb
