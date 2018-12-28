module userInput (Reset, clk, key, awardPoint);
	input logic Reset;
	input logic key;
	input logic clk;
	output logic awardPoint; 

	logic ps, ns;
	
	parameter on = 1'b1;
	
	parameter off = 1'b0;
	
	always_comb begin
		case(ps)
			on: if (key) ns = on;
				 else ns = off;
			
			off: if (key) ns = on;
				  else ns = off;
			default: ns = 1'bx;
		endcase
	end
	
	assign awardPoint = (ps == off & ns == on); 
	
	always_ff @(posedge clk)
		if (Reset)
			ps <= off;
		else 
			ps <= ns;
endmodule
		
module userInput_testbench();
	logic clk;
	logic Reset;
	logic key, awardPoint;
	integer i;


	userInput dut (Reset, clk, key, awardPoint);

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
		   Reset <= 1;key <= 0; 			@(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
			Reset <= 0;key <= 0; 				@(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
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
			key <= 1;							  @(posedge clk);
			key <= 0;							@(posedge clk);
			key <= 1;								@(posedge clk);
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


			
	
	
	
	