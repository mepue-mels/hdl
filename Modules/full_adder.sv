module full_adder(input x1, x2, cin, output y, cout); //dataflow model of FA
   assign y = (x1 & ~x2 & ~cin) | (~x1 & ~x2 & cin) | (x1 & x2 & cin) | (~x1 & x2 & ~cin);
   assign cout = (x2 & cin) | (x1 & cin) | (x1 & x2);
endmodule // full_adder

module testbench;
   reg [2:0] inp; //simulate truth table inputs
   wire y, cout;

   full_adder fa(inp[2],inp[1],inp[0],y,cout);

   initial begin
      inp = 3'b000; // create 3-vector representing x1, x2, and cin (inputs)
      $monitor("x1=%b x2=%b cin=%b | cout=%b y=%b", inp[2],inp[1],inp[0],cout,y);
      forever #1 inp = inp + 3'b001;
   end

   initial fork
      #1 $monitor("x1=%b x2=%b cin=%b | cout=%b y=%b", inp[2],inp[1],inp[0],cout, y);
      #7 $finish;
   join




endmodule // testbench
