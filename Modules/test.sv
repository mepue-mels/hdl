module dFF(input d, clk, reset, output q); //always hold output as wire
   reg Q; // create an intermediate register for output

   initial begin
      Q = 0;
   end

   always @ (posedge clk or negedge clk) begin //start behavior modeling
      if (reset) begin
         Q <= 0;
      end else begin
         Q <= d;
      end
   end //end behavior modeling

   assign q = Q; //bind intermediate variable to actual output
endmodule; // dFF

module cnt(input clk, reset, output da, db, dc);
   wire ta,tb,tc;

   // assign the necessary next-state equations using the wires
   assign ta = db;
   assign tb = dc + ~da; //these are derived from the kmap simplfications for the cntr
   assign tc = ~dc;


   dFF df2(ta, clk, reset, da); // feed the next-state outputs into the inputs of the ff
   dFF df1(tb, clk, reset, db); // next-state outputs will be feedbacked to the ff
   dFF df0(tc, clk, reset, dc);

endmodule // cnt



module tb;
   reg clk, reset;
   wire da,db,dc;

   cnt c(clk, reset, da,db,dc);


   initial begin
      clk = 0;
      reset = 1;
      $monitor("clk=%b %b%b%b", clk, da,db,dc);
   end

   initial begin
      forever #1 clk = ~clk; //model oscillation of clock for each elapsed time
   end

   initial fork //simulateneously provide all the possible combinations from t=0 to t=15
      #1 reset = 0;
      #16 $finish;
   join

endmodule; // tb
