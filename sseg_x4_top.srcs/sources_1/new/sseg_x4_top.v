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
    
    clk_gen clocky (clk, btnC, disp_clk);
    
    assign JA = {an, disp_clk};
    
    assign cur_an = an;
    
    always @(posedge clk)
    begin
        case (an)
            4'b1110: switch_cycle <= sw[7:4];
            4'b1101: switch_cycle <= sw[11:8];
            4'b1011: switch_cycle <= sw[15:12];
            4'b0111: switch_cycle <= sw[3:0];
        endcase
    end
    
    always @(posedge disp_clk or posedge btnC)
    begin
        if (btnC) begin
            an <= 4'b1110;
        end
        else begin
            case (an)
                4'b1110:
                    begin
                        an <= 4'b1101;
                    end
                4'b1101:
                    begin
                        an <= 4'b1011;
                    end
                4'b1011:
                    begin
                        an <= 4'b0111;
                    end
                4'b0111:
                    begin
                        an <= 4'b1110;
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
