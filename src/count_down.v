/*======================================================
 * Modified: 5/18/26
 * Description: Count-down counter for 5 second delay and 1 second 
 *     delay (Debouncing) at 50MHz clock (250,000,000 cycles).
=====================================================*/
module count_down(	clk,
							rst_n,
							ticks,
							);

	input clk, rst_n;
	output ticks;
	
	localparam CLK_5_DELAY = (50_000_000 * 5);
	localparam CLK_1_DELAY = 50_000_000;
	
	reg [27:0] 	count;
	reg 			ticks;
	
	always @(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			count <= 28'b0;
			ticks	<= 1'b0;
		end else if (count >= CLK_5_DELAY -1)begin
			count <= 28'b0;
			ticks	<= 1'b1;
		end else begin
			count <= count + 1'b1;
			ticks  <= 1'b0;
		end
	end
endmodule
