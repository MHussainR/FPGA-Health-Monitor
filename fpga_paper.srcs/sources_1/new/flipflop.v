`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2022 01:43:00 PM
// Design Name: 
// Module Name: flipflop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flipflop(q, clk, rst, d); 
    input clk; 
    input rst; 
    input d; 
    output q; 
    reg q; 
    
    always @(posedge clk or posedge rst)  
        begin 
        if (rst) 
            q = 0; 
        else 
            q = d; 
        end 
endmodule
