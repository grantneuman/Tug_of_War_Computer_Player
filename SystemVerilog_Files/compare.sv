module compare (Reset, clk, A, B, computerPress);

	//computerPress = 1 if A > B
	//computerPress = 0 if A < B
	//computerPress = 0 if A = B

	input logic Reset, clk;
	
	input logic [9:0] A, B;
	
	output logic computerPress;
	
	always_comb begin
		if (Reset) begin
			computerPress = 0;
		end else if (A < B || A == B) begin
			computerPress = 0;
		end else begin
			computerPress = 1;
		end	

	end
endmodule

module compare_testbench();
	logic Reset, clk, computerPress;
	logic [9:0] A, B;
	integer i;
	integer j;
	
	compare dut (Reset, clk, A, B, computerPress);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	
		initial begin
														@(posedge clk);
													  @(posedge clk);
		Reset <= 1; A <= 0; B <=0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
		Reset <= 0; A <= 0; B <=0; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				  A <= 10'b1000000000; B <=10'b0100000000; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				  A <= 10'b1000000000; B <=10'b0010000000; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				  A <= 10'b0000010000; B <=10'b0100000000; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);		
				 A <= 10'b1000000000; B <=10'b0001000000; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);			  
				 A <= 10'b1000000100; B <=10'b0100000100; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);
				 A <= 10'b0000000000; B <=10'b0100000000; @(posedge clk);
													  @(posedge clk);
													  @(posedge clk);	
													  @(posedge clk);		

		$stop;
	end
	
endmodule 



