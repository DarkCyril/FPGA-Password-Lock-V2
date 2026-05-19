/*=======================================
* Author: Fcyril
* Date Created: 5/18/26
* Modified: 5/18/26
* 
* Description: Top File 
*
* Board: Intel MAX10 DE10-Lite
=======================================*/
module password_lock_top( MAX10_CLK1_50,
								  SW,
								  KEY,
								  LEDR);
								  
	input 			MAX10_CLK1_50;
	input		[9:0]	SW;
	input		[1:0]	KEY;
	output	[9:0] LEDR;
	
	//----Reset----
	wire rst_n;
	assign rst_n = KEY[0];
	
	//----Enter----
	wire enter;
	
	//----Ticks----
	wire ticks;
	
	//----Mode----
	wire mode;
	assign mode = SW[9];
	
	//----Pin_In----
	wire [3:0] pin_in;
	assign pin_in = SW[3:0];
	
	
	//Debouncing 
	reg preKey;
	reg curKey;
	
	
	always@(posedge MAX10_CLK1_50)begin
		curKey <= KEY[1];
		preKey <= curKey;
	end
	
	assign enter = (curKey == 1'b0) & (preKey == 1'b1);
	
	count_down U0(	.clk(MAX10_CLK1_50),
						.rst_n(rst_n),
						.ticks(ticks),
						);
						
						
	password_fsm U1(	.clk(MAX10_CLK1_50),
							.rst_n(rst_n),
							.mode(mode),
							.enter(enter),
							.ticks(ticks),
							.pin_in(pin_in),
							.led(LEDR));
	
endmodule
