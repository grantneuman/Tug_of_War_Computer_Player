module bitUpCounter (Reset, clk, incr, out);
	input logic Reset, clk, incr;
	output logic [2:0] out;
	
	always_ff @(posedge clk) begin
		if (Reset)
			out <= 0;
		else if (incr)
			out <= out + 1;
	end 
endmodule

module bitUpCounter_testbench();
	logic Reset, clk, incr;
	logic [2:0] out;
	
	bitUpCounter dut (.Reset(Reset), .clk(clk), .incr(incr));
	
	// Set up the clock.   
	parameter CLOCK_PERIOD = 100;   
	initial begin 
		clk <= '0;  
		forever #( CLOCK_PERIOD / 2 ) clk <= ~clk;   
	end      
	
	// Set up the inputs to the design.  Each line is a clock cycle.   
initial begin                        
				   @(posedge clk);    
	Reset <= 1; incr <= 0; @(posedge clk);    
	Reset <= 0; incr <= 0; @(posedge clk);                        
           incr <= 1;    @(posedge clk);                        
								@(posedge clk);                        
               @(posedge clk);                
               @(posedge clk);                
               @(posedge clk);                
               @(posedge clk);                        
               @(posedge clk);                        
               @(posedge clk);                        
               @(posedge clk);               
               @(posedge clk);                        
               @(posedge clk);   
               @(posedge clk); 
               @(posedge clk); 	
               @(posedge clk); 
               @(posedge clk); 	
               @(posedge clk); 
              incr <= 0; @(posedge clk);
               @(posedge clk); 
               @(posedge clk);					
	$stop; // End the simulation.   
end  
endmodule
