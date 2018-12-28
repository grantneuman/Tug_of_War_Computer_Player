module bothSeg7(HEX0, HEX1, LEDR, SW);
	input logic [9:0] SW;
	output logic [6:0] HEX0;
	output logic[6:0] HEX1;
	output logic [9:0] LEDR;
	
	assign LEDR = 0;

	seg7 firstCall(.bcd(SW[3:0]), .leds(HEX0));
	seg7 secondCall(.bcd(SW[7:4]), .leds(HEX1));
	
endmodule

module bothSeg7_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [6:0] LEDR;
 logic [3:0] KEY;
 logic [9:0] SW;

 bothSeg7 call(.HEX0(HEX0), .HEX1(HEX1), .LEDR(LEDR), .SW(SW));
  // Try all combinations of inputs.
 integer i;
 initial begin
	 SW[9] = 1'b0;
	 SW[8] = 1'b0;
	 for(i = 0; i < 256; i++) begin
		{SW[7:0]} = i; #10;
	 end
 end
endmodule 
	
	
