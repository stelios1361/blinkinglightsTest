module tt_um_blink(
    input clk,rst,
    output [7:0] q
    );
     
    // counter register
    reg [7:0] rCounter;
//a register for the delay counter 
reg [24:0] delay_counter;
     
//the delay  counter 
assign enable = (delay_counter == 25'd24999999) ? 1'b1 : 1'b0;
    // increment or reset the counter
    always @(negedge clk or posedge rst1 or posedge rst2 or posedge rst3 or posedge rst4 or negedge rst5)
    if (rst)
    begin
    delay_counter <= 25'd0;
    rCounter <= 8'b0;
    end
	else
	begin
	if(enable)
		begin
		delay_counter <= 25'd0;
            rCounter <= rCounter + 1;
		end
	else delay_counter <= delay_counter + 1'b1;
	end
 
    // connect counter register to the output wires
    assign q = rCounter;

endmodule