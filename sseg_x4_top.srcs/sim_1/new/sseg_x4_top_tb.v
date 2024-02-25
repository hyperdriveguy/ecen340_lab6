`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 05:21:32 PM
// Design Name: 
// Module Name: sseg_x4_top_tb
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


module sseg_x4_top_tb();

    reg clk;
    reg btnC;
    reg [15:0] sw;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    wire [4:0] JA;
    
    // Intantiation of sseg_x4_top module
    sseg_x4_top U1 (clk, btnC, sw, seg, an, dp, JA);
    
    // Test conditions
    initial
    begin
        sw = 16'h0;
        #100
        sw = 16'hdead;
        #100
        sw = 16'hbeef;
        #100
        sw = 16'h2a5f;
        #100
        sw = 16'hffff;
        #100
        sw = 16'hd0d0;
        #100
        sw = 16'habcd;
        #100
        // Let's do that again but with reset pressed
        sw = 16'h0;
        #100
        sw = 16'hdead;
        #100
        sw = 16'hbeef;
        #100
        sw = 16'h2a5f;
        #100
        sw = 16'hffff;
        #100
        sw = 16'hd0d0;
        #100
        sw = 16'habcd;
        #100
        $finish;
    end
    
    initial
    begin
        btnC = 0; // Reset not pressed
        #700
        btnC = 1; //Reset pressed
        #700
        $finish;
    end
    
    initial
    begin
        forever begin
            clk = 0;
            #10 clk = ~clk;
        end
    end
    
endmodule
