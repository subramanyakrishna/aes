`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:52 06/28/2018 
// Design Name: 
// Module Name:    AES_Encryption 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//`include "inv_Shift_rows.v"
//`include "inv_Sub_bytes.v"
//`include "inv_Sub_Key.v"
//`include "inv_Mix_Column.v"

module AES_Decryption(clk,Cypher_in,key_in,data_out
    );
	 input clk;
	 input [127:0] Cypher_in;
	 input [127:0] key_in;
	 output [127:0] data_out;
	 
	 wire [127:0] key_out[10:0];
	 wire [127:0] cypher_in;
	 wire [127:0] round_outa[10:0];
	 wire [127:0] round_outb[10:0];
	 wire [127:0] mux_out2[10:0];
	 wire [127:0] sb2[10:0];
     wire [127:0] sr2[10:0];
     wire [127:0] df2[10:0];
     wire [127:0] sr2_sb2[10:0];
     wire [127:0] mc2[9:0];
	 	 
	 //assign cypher_in=key_in^Cypher_in;
	 assign cypher_in=Cypher_in;
	 
	 Key k1 (4'b0000,key_in,key_out[0]);
	 MUX2_1 MUX1 (.A1(cypher_in),.A2(round_outa[0]),.S(1'b0),.B(mux_out2[0]));
	 inv_Shift_rows sr1 (clk,mux_out2[0],sr2[0]);
	 //inv_Sub_Bytes sb1 (.A(mux_out2[0]),.B1(sb2[0]));
	 DFF_128 dff1 (clk,sr2[0],df2[0]);
	 inv_Sub_bytes sb1 (df2[0],sb2[0]);
	 mux mux1 (.a1(sr2[0]),.a2(sb2[0]),.s(1'b1),.b(sr2_sb2[0]));
	 inv_Sub_Key ak (key_out[0],sr2_sb2[0],round_outb[0]);
	 inv_Mix_Column mc1 (clk,sr2[0],mc2[0]);
	 Round_reg r1 (clk,round_outb[0],round_outa[0]);
	 
 genvar i;
 generate
    for(i=1;i<=9;i=i+1) begin: test
      if(i<9)
     begin
          Key k1_i (i,key_out[i-1],key_out[i]);
          MUX2_1 MUX1_i (.A2(round_outa[i-1]),.S(1'b1),.B(mux_out2[i]));
          inv_Shift_rows sr1_i (clk,mux_out2[i],sr2[i]);
          //inv_Sub_Bytes sb1 (.A(mux_out2[0]),.B1(sb2[0]));
          DFF_128 dff1_i (clk,sr2[i],df2[i]);
          inv_Sub_bytes sb1_i (df2[i],sb2[i]);
          mux mux1_i (.a1(sr2[i]),.a2(sb2[i]),.s(1'b1),.b(sr2_sb2[i]));
          inv_Sub_Key ak_i (key_out[i],sr2_sb2[i],round_outb[i]);
          inv_Mix_Column mc1_i (clk,sr2[i],mc2[i]);
          Round_reg r1_i (clk,round_outb[i],round_outa[i]);
      end
      else
      begin
            Key k1__f (i,key_out[i-1],key_out[i]);
            MUX2_1 MUX1_f (.A2(round_outa[i-1]),.S(1'b1),.B(mux_out2[i]));
            inv_Shift_rows sr1_f (clk,mux_out2[i],sr2[i]);
            //inv_Sub_Bytes sb1 (.A(mux_out2[0]),.B1(sb2[0]));
            DFF_128 dff1_f (clk,sr2[i],df2[i]);
            inv_Sub_bytes sb1_f (df2[i],sb2[i]);
            mux mux1_f (.a1(sr2[i]),.a2(sb2[i]),.s(1'b1),.b(sr2_sb2[i]));
            inv_Sub_Key ak_i (key_out[i],sr2_sb2[i],round_outb[i]);
            //inv_Mix_Column mc1_i (clk,sr[i],mc2[i]);
            Round_reg r1_i (clk,round_outb[i],data_out);
       end
     end
   endgenerate
 endmodule

            
          
     
	 