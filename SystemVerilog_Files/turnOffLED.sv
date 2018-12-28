module turnOffLED (Reset, clk, leftLED, rightLED, outLeft, outRight);
	input logic Reset, leftLED, rightLED, clk;

	output logic outLeft, outRight;
	
	parameter on = 1'b1;
	parameter off = 1'b0;
	
	always_ff @(posedge clk) begin
		if (Reset)
			outLeft <= off;
			//outRight <= off;
		else 
			outLeft <= leftLED;
			outRight <= rightLED;
	end
	

endmodule

		
