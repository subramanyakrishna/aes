`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:20:19 06/28/2018
// Design Name:   AES_Encryption
// Module Name:   E:/IITB_Project/AES_Pipe/AES_test.v
// Project Name:  AES_Pipe
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AES_Encryption
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//`include "AES_Decryption.v"
module AES_test;

	// Inputs
	reg clk;
	//reg SEL1;
	//reg SEL2;
	reg [127:0] Data_in;
	reg [127:0] key_in;
	reg [127:0] Cypher_in;

	// Outputs
	wire [127:0]cipher_out;
	wire [127:0]data_out;
	
	wire [127:0] a;
	assign a = cipher_out;
	// Instantiate the Unit Under Test (UUT)
	AES_Encryption uut (
		.clk(clk), 
	 //.SEL1(SEL1), 
	 //.SEL2(SEL2), 
		.Data_in(Data_in), 
		.key_in(key_in), 
		.cipher_out(cipher_out)
	);
	AES_Decryption dyt(
         //.SEL1(SEL1), 
         //.SEL2(SEL2), 
            clk,Cypher_in,key_in,data_out);
            
    
	initial 
	   begin
		// Initialize Inputs
		clk = 0;
		Data_in = 128'h00112233445566778899aabbccddeeff;
		key_in =  128'h000102030405060708090a0b0c0d0e0f;
		// Wait 100 ns for global reset to finish
        #100 Cypher_in = a;
		// Add stimulus here
        //#100 $finish;
	end
always #2 clk=~clk;
endmodule

