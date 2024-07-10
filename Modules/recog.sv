module StateMachine(input clk, input [5:0] x, output [1:0] y, output [3:0] state);
   reg [3:0] State;
   reg [5:0] inp;
   reg [1:0] flag;
   

   initial begin
      State = 3'b000;
      flag = 2'b00;
   end

   always @( posedge clk ) begin
      if (State == 3'b000) begin
         inp = x;
         if (inp[5] == 1'b1) begin
            State = 3'b001;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b001) begin
         if (inp[4] == 1'b0) begin
            State = 3'b010;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b010) begin
         if (inp[3] == 1'b1) begin
            State = 3'b011;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b011) begin
         if (inp[2] == 1'b1) begin
            State = 3'b100;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b100) begin
         if (inp[1] == 1'b0) begin
            State = 3'b101;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b101) begin
         if (inp[0] == 1'b1) begin
            State = 3'b110;
         end else begin
            State = 3'b111;
         end
      end else if (State == 3'b110) begin
         flag = 3'b01;
         State = 3'b000;
         $display("Number equal to 101101");
      end else if (State == 3'b111) begin
         flag = 3'b10;
         State = 3'b000;
         $display("Number not equal to 101101");
      end
   end // always @ ( posedge clk )

   assign y = flag;
   assign state = State;
endmodule // recognizer

module testbench; //testbench for testing 101101 = 101101
   reg clk;
   reg [5:0] num;
   wire [3:0] state;
   wire [1:0] flag;

   StateMachine sm(clk, num, flag, state);

   initial begin
      clk = 0;
      num = 6'b101101;
   end

   initial begin
      forever #1 clk = ~clk;
   end

   always @ (clk) begin
	if ( (flag == 2'b01) | (flag == 2'b10) ) begin  //stop condition
		$finish;
	end else begin
		$monitor("%b", state);
	end

   end

   initial fork 
	   #100 $finish; // emergency halt just in case
   join
endmodule // testbench
