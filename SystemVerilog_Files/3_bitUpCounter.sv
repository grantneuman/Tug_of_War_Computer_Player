module 3_bitUpCounter (Reset, clk, incr, out);
	input logic Reset, clk, incr;
	output logic [2:0] out;
	
	always_ff(@posedge clk) begin
		if (Reset)
			out <= 0;
		else if (incr)
			out <= out + 1;
	end 
endmodule
