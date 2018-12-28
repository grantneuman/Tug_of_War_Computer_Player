module LFSR (Reset, clk, out);
	input logic Reset;
	input logic clk;
	output logic [9:0] out;
	
	logic holder;
	
	xnor XNOR (holder, q[9], q[8]);

	always_ff @(posedge clk) begin
		if (Reset)
			out <= 10'b0000000000;
		else
			out <= {q[8], q[7], q[6], q[5], q[4], q[3], q[2], q[1], holder};
	end
endmodule


module 10_bitLFSR_testbench();
	logic clk;
	logic Reset;
	logic L, R, NL, NR;
	logic lightOn;
	integer i;
	


	LFSR dut (clk, Reset, L, R, NL, NR, lightOn);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	 SW[9] = 1'b0;
	 SW[8] = 1'b0;
	 for(i = 0; i < 256; i++) begin
		{SW[7:0]} = i; #10;
	 end
 end
	