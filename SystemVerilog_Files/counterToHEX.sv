module counterToHEX(Reset, clk, out, HEX);
	input Reset, clk;
	input [2:0] out;
	
	output [6:0] HEX;
	
	logic [6:0] zero, one, two, three, four, five, six, seven, ps, ns;
	
	
	assign zero = 7'b1000000;
	assign one = 7'b1111001;
	assign two = 7'b0100100;
	assign three = 7'b0110000;
	assign four = 7'b0011001;
	assign five = 7'b0010010;
	assign six = 7'b0000010;
	assign seven = 7'b1111000;
	
	always_comb begin
		case (out)
			3'b000: ns = zero;
			3'b001: ns = one;
			3'b010: ns = two;
			3'b011: ns = three;
			3'b100: ns = four;
			3'b101: ns = five;
			3'b110: ns = six;
			3'b111: ns = seven;
			default: ns = 7'bx;
		endcase
	end
	
//	always_comb begin
//		case (outRight)
//			3'b000: ns2 = zero;
//			3'b001: ns2 = one;
//			3'b010: ns2 = two;
//			3'b011: ns2 = three;
//			3'b100: ns2 = four;
//			3'b101: ns2 = five;
//			3'b110: ns2 = six;
//			3'b111: ns2 = seven;
//			default: ns2 = 7'bx;
//		endcase
//	end
//	
	assign HEX = ps;
	
//	assign rightHEX = ps2;

	always_ff @(posedge clk) begin
		if (Reset)
			ps <= zero;
		else
			ps <= ns;
	end
	
//	always_ff @(posedge clk) begin
//		if (Reset)
//			ps2 <= zero;
//		else if (ps == seven || ps2 == seven)
//			ps2 <= zero;
//		else
//			ps2 <= ns2;
//	end
	
endmodule

//module counterToHEX_testbench();
//	logic Reset, clk; 
//	logic [2:0] outLeft, outRight;
//	logic [6:0] leftHEX, lHex;
//	
//	
//	counterToHEX dut (Reset, clk, outLeft, outRight, leftHEX, rightHEX);
//
//	// Set up the clock.
//	parameter CLOCK_PERIOD=100;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	
//		initial begin
//														@(posedge clk);
//													  @(posedge clk);
//		Reset <= 1; out <= 3'b000; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//		Reset <= 0; out <= 3'b000; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				  out <= 3'b001; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				  out <= 3'b010; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				  out <= 3'b100; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);	
//													  @(posedge clk);		
//				 out <= 3'b111; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);	
//													  @(posedge clk);			  
//				 out <= 3'b001; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);
//				 out <= 3'b100; @(posedge clk);
//													  @(posedge clk);
//													  @(posedge clk);	
//													  @(posedge clk);		
//
//		$stop;
//	end
//	
//endmodule 




			
			