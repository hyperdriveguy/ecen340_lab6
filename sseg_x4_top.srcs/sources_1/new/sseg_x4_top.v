//module sseg_decoder(
//    input enable,
//    input [3:0] in_digit,
//    output reg [6:0] seg
//    );
    
//    always @(negedge enable)
//    begin
//        case (in_digit)
//            4'h0: seg = 7'b1000000;
//            4'h1: seg = 7'b1111001;
//            4'h2: seg = 7'b0100100;
//            4'h3: seg = 7'b0110000;
//            4'h4: seg = 7'b0011001;
//            4'h5: seg = 7'b0010010;
//            4'h6: seg = 7'b0000010;
//            4'h7: seg = 7'b1111000;
//            4'h8: seg = 7'b0000000;
//            4'h9: seg = 7'b0010000;
//            4'ha: seg = 7'b0010000;
//            4'hb: seg = 7'b1100000;
//            4'hc: seg = 7'b1000110;
//            4'hd: seg = 7'b1000001;
//            4'he: seg = 7'b0000110;
//            4'hf: seg = 7'b0001110;
//        endcase
//    end
//endmodule

module sseg_x4_top(
    input clk,
    input btnC, // reset button
    input [15:0] sw,
    output reg [6:0] seg,
    output reg [3:0] an,
    output dp,
    output [4:0] JA
    );
    
    // force decimal point off
    assign dp = 1'b1;
    
    wire disp_clk;
    reg [3:0] switch_cycle;
    
    clk_gen(clk, btnC, disp_clk);
    
    assign JA = {an, disp_clk};
    
    // Decoders for each set of switch inputs
//    sseg_decoder disp_0(clk, sw[3:0], seg);
//    sseg_decoder disp_1(clk, sw[7:4], seg);
//    sseg_decoder disp_2(clk, sw[11:8], seg);
//    sseg_decoder disp_3(clk, sw[15:12], seg);
    
    always @(posedge disp_clk or posedge btnC)
    begin
        if (btnC) begin
            an <= 4'b1110;
            switch_cycle <= sw[3:0];
        end
        else begin
            case (an)
                4'b1110:
                    begin
                        an <= 4'b1101;
                        switch_cycle <= sw[7:4];
                    end
                4'b1101:
                    begin
                        an <= 4'b1011;
                        switch_cycle <= sw[11:8];
                    end
                4'b1011:
                    begin
                        an <= 4'b0111;
                        switch_cycle <= sw[15:12];
                    end
                4'b0111:
                    begin
                        an <= 4'b1110;
                        switch_cycle <= sw[3:0];
                    end
            endcase
            case (switch_cycle)
                4'h0: seg <= 7'b1000000;
                4'h1: seg <= 7'b1111001;
                4'h2: seg <= 7'b0100100;
                4'h3: seg <= 7'b0110000;
                4'h4: seg <= 7'b0011001;
                4'h5: seg <= 7'b0010010;
                4'h6: seg <= 7'b0000010;
                4'h7: seg <= 7'b1111000;
                4'h8: seg <= 7'b0000000;
                4'h9: seg <= 7'b0010000;
                4'ha: seg <= 7'b0001000;
                4'hb: seg <= 7'b0000011;
                4'hc: seg <= 7'b1000110;
                4'hd: seg <= 7'b0100001;
                4'he: seg <= 7'b0000110;
                4'hf: seg <= 7'b0001110;
            endcase
        end
    end
endmodule
