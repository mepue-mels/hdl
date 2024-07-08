module bcd(input [3:0] num, output [3:0] bcd); //literal na data FLOW
   reg [3:0] x;
	always @ (num) begin
	   if (num >= 4'b1010) begin
		  x = 4'bxxxx;
	   end else begin
		  x = num;
	   end
	end

   assign bcd = x;
endmodule

module testbench;
   reg [3:0] val;
   wire [3:0] out;

   bcd b(val, out);

   initial fork
	  #1 val = 4'b0001;
	  #2 $monitor("%b", out); //important to note that monitor keeps showing per elapse
	  #3 val = 4'b1010;
	  #5 $finish;
   join



endmodule // testbench
