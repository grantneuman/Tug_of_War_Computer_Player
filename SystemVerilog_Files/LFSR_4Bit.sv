module LFSR_4Bit( clock, reset, Q );
input  logic clock;
input  logic reset;

localparam NumOfBit = 10;
output logic [ NumOfBit : 1 ] Q;
logic D;

xnor( D, Q[ 3 ], Q[ 4 ], &Q[ NumOfBit - 1 : 1 ] );

always_ff @( posedge clock ) begin
	if ( reset ) begin
		Q <= '0;
	end else begin
		Q <= { Q[ NumOfBit - 1 : 1 ], D };
	end
end

endmodule 

module LFSR_4Bit_testbench();   
logic  clk, reset;

localparam NumOfBit = 4;
logic [ NumOfBit : 1 ] Q;

LFSR_4Bit dut( .clock( clk ), .reset, .Q );      

// Set up the clock.   
parameter CLOCK_PERIOD = 100;   
initial begin 
	clk <= '0;  
	forever #( CLOCK_PERIOD / 2 ) clk <= ~clk;   
end      

// Set up the inputs to the design.  Each line is a clock cycle.   
initial begin                        
				   @(posedge clk);    
	reset <= 1; @(posedge clk);    
	reset <= 0; @(posedge clk);                        
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
               @(posedge clk); 
               @(posedge clk);
               @(posedge clk); 
               @(posedge clk);					
	$stop; // End the simulation.   
end  
endmodule 