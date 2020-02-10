
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Madras
// Engineer: Sundar Raman P
// Design Name: Sequential_Multiplier
// Module Name: sequential_multiplier
// Project Name: Assignment_1-EE5332
// Target Devices: Basys-3: xc7a35tcpg236
// Tool Versions: Vivado v2018.2
// Description: A serial multiplier which multiplies two signed numbers of 8 bits each to output product result.
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////
// This implementation corresponds to a sequential multiplier, but
// most of the functionality is missing.  Complete the code so that
// the resulting module implements multiplication of two numbers in
// twos complement format.

`define width 8
`define ctrwidth 4

module seq_mult (
    output reg rdy,
    output reg [2*`width-1:0] p,
	input clk, reset,
	input [`width-1:0] a, b
 ) ;
    reg [`ctrwidth:0] 	ctr;
    reg [2*`width-1:0] multiplier, multiplicand;

always @(posedge clk or posedge reset) begin
if (reset) begin
	rdy 			<= 0;
 	p 		   		<= 0;
 	ctr 			<= 0;
 	multiplier 		<= {{`width{a[`width-1]}}, a}; // sign-extend
 	multiplicand 	<= {{`width{b[`width-1]}}, b}; // sign-extend
end
else begin 
	if (ctr < 4'hf) 
    begin
        p = p + ((multiplicand & {16{multiplier[ctr]}}) << ctr);
        ctr = ctr + 1;
	end
 	else
 	begin
 		rdy <= 1; 		// Assert 'rdy' signal to indicate end of multiplication
 	end
end
end 

endmodule //seqmult
