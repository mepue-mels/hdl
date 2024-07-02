module time_register(input clk, reset, ht_in, ho_in , mt_in, mo_in, st_in, so_in, output ht_out, ho_out, mt_out, mo_out, st_out, so_out);

	reg ht,ho,mt,mo,st,so;
	
	always @(posedge clk) begin
		if (reset == 1) begin
			ht <= 0;
			ho <= 0;
			mt <= 0;
			mo <= 0;
			st <= 0;
			so <= 0;
		end else begin
			ht <= ht_in;
			ho <= ho_in;
			mt <= mt_in;
			mo <= mo_in;
			st <= st_in;
			so <= so_in;
		end
	end 


	assign ht_out = ht;
	assign ho_out = ho;
	assign mt_out = mt;
	assign mo_out = mo;
	assign st_out = st;
	assign so_out = so;
endmodule


module test;
	reg ht_in,ho_in,mt_in,mo_in,st_in,so_in;
	wire ht_out, ho_out, mt_out, mo_out, st_out, so_out;

	reg clk, reset;

	time_register tr(clk, reset, ht_in,ho_in,mt_in,mo_in,st_in,so_in, ht_out, ho_out, mt_out, mo_out, st_out, so_out);


	initial begin 
		clk = 0;
		reset = 0;
	end

	initial begin
		forever #1 clk=~clk;
	end


	initial fork
		#5 $finish;
	join
endmodule

