module victory (clk, Reset, L, R, lightLeft, lightRight, leftWon, rightWon, gameReset);
	input logic clk, Reset, L, R, lightLeft, lightRight;
	
	output logic leftWon, rightWon, gameReset;
	
	logic [1:0] left, right, off;
	
	assign left = 2'b00;
	assign right = 2'b01;
	assign off = 2'b10;
	
	logic [1:0] ps, ns;
	
	always_comb begin
		case(ps)
			 off: if (lightLeft & (L & ~R)) ns = left;
				  else if (lightRight  & (~L & R)) ns = right;
				  else ns = off;
			left: if (lightLeft & (L & ~R)) ns = left;
				  else if (lightRight  & (~L & R)) ns = right;
				  else ns = off;
			
			right: if (lightLeft & (L & ~R)) ns = left;
				  else if (lightRight  & (~L & R)) ns = right;
				  else ns = off;
	
			default: ns = off;
			
		endcase
	end
	
	assign leftWon = (ps == left);
	
	assign rightWon = (ps == right);

	assign gameReset = ((ps == left) || (ps == right));
	
	always_ff @(posedge clk) begin
		if (Reset)
			ps <= off;
		else if (ps == left || ps == right)
			ps <= off;
		else
			ps <= ns;
	end
	
endmodule

module victory_testbench();
	logic clk, Reset, L, R, lightLeft, lightRight, leftWon, rightWon;

	victory dut (clk, Reset, L, R, lightLeft, lightRight, leftWon, rightWon);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	// L, R, lightLeft, lightRight
	initial begin
														@(posedge clk);
													  @(posedge clk);
		Reset <= 1; L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
		Reset <= 0; L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				 L <= 0; R <=0; lightLeft <= 1; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				L <= 1; R <=0; lightLeft <= 1; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				 L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);		
				L <= 0; R <=0; lightLeft <= 0; lightRight <= 1; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);			  
				 L <= 0; R <=1; lightLeft <= 0; lightRight <= 1; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				 L <= 0; R <=0; lightLeft <= 0; lightRight <= 0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);		

		$stop;
	end
	
endmodule 


