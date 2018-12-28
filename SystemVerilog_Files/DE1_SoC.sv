module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	logic keyOne;
	logic keyTwo;
	
	logic firstStableInput;
	logic secondStableInput;
	
	logic rightLED;
	logic leftLED;
	
	logic leftWon;
	logic leftPress;
	logic rightWon;
	
	logic [2:0] leftDigit;
	logic [2:0] rightDigit;
	
	logic [9:0] A, B;
	
	logic gameReset;
	
	assign A[8:0] = SW[8:0];
	
	assign A[9] = 1'b0;

	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] clk;
	// Hook up FSM inputs and outputs.
//	logic Reset, w, out;
//	assign Reset = SW[9]; // Reset when SW[9] is pressed.
	
	//turn off HEX1 through HEX5 displays
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	
	parameter whichClock = 15; 
	clock_divider divided_clock (CLOCK_50, clk);
	// left is the computer winning 
	
		
	compare (.Reset(SW[9]), .clk(clk[whichClock]), .A(A), .B(B), .computerPress(leftPress));
	
	bitUpCounter leftCounter (.Reset(SW[9]), .clk(clk[whichClock]), .incr(leftWon), .out(leftDigit));
	bitUpCounter rightCounter (.Reset(SW[9]), .clk(clk[whichClock]), .incr(rightWon), .out(rightDigit));
	
	
	counterToHEX displayLeft (.Reset(SW[9]), .clk(clk[whichClock]), .out(leftDigit), .HEX(HEX5));
	counterToHEX displayRight (.Reset(SW[9]),.clk(clk[whichClock]), .out(rightDigit), .HEX(HEX0));
	
	LFSR ranNum (.Reset(SW[9]), .clk(clk[whichClock]), .Q(B));

	
	seriesFlipFlop stableOne (.clk(clk[whichClock]), .Reset(SW[9]), .key(~KEY[0]), .out(firstStableInput));
	seriesFlipFlop stableTwo (.clk(clk[whichClock]), .Reset(SW[9]), .key(leftPress), .out(secondStableInput));


	userInput one (.Reset(SW[9]), .clk(clk[whichClock]), .key(firstStableInput), .awardPoint(keyOne));
	userInput two (.Reset(SW[9]), .clk(clk[whichClock]), .key(secondStableInput), .awardPoint(keyTwo));

	victory winner (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .lightLeft(LEDR[9]), .lightRight(LEDR[1]), .leftWon(leftWon), .rightWon(rightWon), .gameReset(gameReset));
	
	normalLight led1 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[2]), .NR(1'b0), .newGame(gameReset), .lightOn(LEDR[1]));
	normalLight led2 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[3]), .NR(LEDR[1]), .newGame(gameReset), .lightOn(LEDR[2]));
	normalLight led3 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[4]), .NR(LEDR[2]), .newGame(gameReset), .lightOn(LEDR[3]));
	normalLight led4 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[5]), .NR(LEDR[3]), .newGame(gameReset), .lightOn(LEDR[4]));
	
	centerLight led5 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[6]), .NR(LEDR[4]), .newGame(gameReset), .lightOn(LEDR[5]));
	
	normalLight led6 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[7]), .NR(LEDR[5]), .newGame(gameReset), .lightOn(LEDR[6]));
	normalLight led7 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[8]), .NR(LEDR[6]), .newGame(gameReset), .lightOn(LEDR[7]));
	normalLight led8 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(LEDR[9]), .NR(LEDR[7]), .newGame(gameReset), .lightOn(LEDR[8]));
	normalLight led9 (.clk(clk[whichClock]), .Reset(SW[9]), .L(keyTwo), .R(keyOne), .NL(1'b0), .NR(LEDR[8]), .newGame(gameReset), .lightOn(LEDR[9]));


endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
// [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks = 0;

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 
