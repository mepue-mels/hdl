module bcd(input num, output bcd);
	always @ (num) begin
		case (num) 
			4'b0000	:	bcd = 0;
			4'b0001	:	bcd = 1;
			4'b0010	:	bcd = 2;
			4'b0011	:	bcd = 3;
			4'b0100	:	bcd = 4;
			4'b0101	:	bcd = 5;
			4'b0110	:	bcd = 6;
			4'b0111	:	bcd = 7;
			4'b1000	:	bcd = 8;
			4'b1001	:	bcd = 9;
			4'b1010	:	bcd = x;
			4'b1011	:	bcd = x;
			4'b1100	:	bcd = x;
			4'b1100	:	bcd = x;
			4'b1101	:	bcd = x;
			4'b1110	:	bcd = x;
			4'b1111	:	bcd = x;
		endcase
	end
endmodule
