module seriesFlipFlop (clk, Reset, key, out);
	input logic clk;
	input logic key;
	input logic Reset;
	output logic out;
	
	logic temp1;
	logic temp2;
	
	parameter off = 1'b0;
	
	parameter on = 1'b1;
	
	always_ff @(posedge clk) begin
		if (Reset)
			temp1 <= off;
		else 
			temp1 <= key;
	end
	
	always_ff @(posedge clk) begin
		if (Reset)
			temp2 <= off;
		else
			temp2 <= temp1;
	end
	
	assign out = temp2;
endmodule

module seriesFlipFlop_testbench();
	logic clk;
	logic Reset;
	logic key;
	logic out;


	seriesFlipFlop dut (clk, Reset, key, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end


		
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
													  @(posedge clk);
													  @(posedge clk);
		   Reset <= 1; key <=0;  			  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			Reset <= 0; key <=0;				  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			key <= 1;							  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			key <= 0;							  @(posedge clk);
													  @(posedge clk);
			key <= 1;							  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			key <= 0;							  @(posedge clk);
													  @(posedge clk);
			key <= 1;							  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			key <= 0;							  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			$stop; // End the simulation.
	end
endmodule 


