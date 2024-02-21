`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2024 03:16:30 PM
// Design Name: 
// Module Name: clk_gen
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


module clk_gen(
    input clk,
    input rst,
    output clk_div
    );
    
    // Use a counter to implement clock division
    reg [25:0] counter;
    always @(posedge clk)
    begin
        if (rst)
            counter <= 0;
        counter <= counter + 1;
    end
    
    // 20 divisions, ~90 Hz
    assign clk_div = counter[19];
    
endmodule
