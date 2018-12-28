module fred (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW);
	input logic [2:0] SW;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [6:0] A, B, C, D, E, H, I, L, O, P, R, S, N, nothing;
	
	assign A = 7'b0001000;
	assign B = 7'b0000011;
	assign C = 7'b1000110;
	assign D = 7'b0100001;
	assign E = 7'b0000110;
	assign H = 7'b0001001;
	assign I = 7'b1111001;
	assign L = 7'b1000111;
	assign O = 7'b0100011;
	assign P = 7'b0001100;
	assign R = 7'b0101111;
	assign S = 7'b0010010;
	assign N = 7'b0101011;
	assign nothing = 7'b1111111;
	

	always_comb begin
		case (SW)
			3'b000 : begin
										HEX5 = P;
										HEX4 = H;
										HEX3 = O;
										HEX2 = N;
										HEX1 = E;
										HEX0 = nothing;
						end
						
						
						
			3'b001 : begin
										HEX5 = D;
										HEX4 = R;
										HEX3 = E;
										HEX2 = S;
										HEX1 = S;
										HEX0 = nothing;
			end
			
			
			3'b011 : begin
										HEX5 = C;
										HEX4 = H;
										HEX3 = A;
										HEX2 = I;
										HEX1 = R;
										HEX0 = nothing;
						end
						
						
						
			3'b100 : begin
										HEX5 = B;
										HEX4 = E;
										HEX3 = D;
										HEX2 = nothing;
										HEX1 = nothing;
										HEX0 = nothing;
			end
			
			
			3'b101 : begin
										HEX5 = O;
										HEX4 = I;
										HEX3 = L;
										HEX2 = nothing;
										HEX1 = nothing;
										HEX0 = nothing;
			end
			
			3'b110 : begin
										HEX5 = B;
										HEX4 = E;
										HEX3 = A;
										HEX2 = R;
										HEX1 = nothing;
										HEX0 = nothing;
			end
			
			default : begin 
										HEX5 = 7'bx;
										HEX4 = 7'bx;
										HEX3 = 7'bx;
										HEX2 = 7'bx;
										HEX1 = 7'bx;
										HEX0 = 7'bx;
			end
						
		endcase
	end
endmodule 

module fred_testbench();
 logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 logic [9:0] SW;
 fred call(.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .SW(SW));
  // Try all combinations of inputs.
 integer i;
 initial begin

	 for(i = 0; i < 8; i++) begin
		{SW[2:0]} = i; #10;
	 end
 end
endmodule 
