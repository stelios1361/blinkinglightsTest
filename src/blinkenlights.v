`default_nettype none

module tt_um_blink(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
     
    // counter register
    reg [7:0] rCounter;
//a register for the delay counter 
reg [24:0] delay_counter;

	
wire enable;
     
//the delay  counter 
assign enable = (delay_counter == 25'd24999999) ? 1'b1 : 1'b0;
    // increment or reset the counter
    always @(posedge clk or negedge rst_n)
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
 
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = rCounter; 
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
