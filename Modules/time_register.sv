module tr;
	reg [3:0] ht,ho,mt,mo,st,so;
	integer ht_i, ho_i, mt_i, mo_i, st_i, so_i;

	bcd ht_bcd(ht,ht_i);
	bcd ho_bcd(ho,ho_i);
	bcd mt_bcd(mt,mt_i);
	bcd mo_bcd(mo,mo_i);
	bcd st_bcd(st,st_i);
	bcd so_bcd(so,so_i);

	initial begin 
		ht = 4'b 0000;
		ho = 4'b 0000;
		mt = 4'b 0000;
		mo = 4'b 0000;
		st = 4'b 0000;
		so = 4'b 0000;
	end

	initial fork
		$display("%d", ht_bcd);
	join
endmodule

