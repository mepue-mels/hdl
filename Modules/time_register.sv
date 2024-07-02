module tr;
	reg [3:0] a1,a2;

	initial begin 
		a1 = 4'b0100;
		a2 = 4'b1001;

		$display("%b", a1 + a2);
	end
endmodule

