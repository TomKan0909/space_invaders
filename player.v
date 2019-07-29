module player (
    input clk, // clock
    input reset_n, // reset button
    input left,  // move to the left; will be synced to rate divider 
    input right, // move to the right; will be synced to rate divider
    input got_hit, // signals whether player has been shot by alien
    output reg [7:0] x_pos , // current x_position - sent to vga
    output reg [6:0] y_pos , // current y_position - sent to vga 
    output reg [2:0] colour // color sent to vga 
);
    ///***** Player is a 4 by 4 Square that can only move in x direction******///
    reg [7:0] x_pos_reg;
    reg [6:0] y_pos_reg;

    
    reg [3:0] counter_out;

    always @(posedge clk)
    begin
        if (reset_n)
        begin 
            x_pos_reg <= 8'd78; // roughly in the middle since 160 X 120
            y_pos_reg <= 7'd100; // roughly near the bottom of screen
        end
        else if (!got_hit) // still alive 
        begin
            y_pos_reg <= y_pos_reg; // fixed since only move in x direction
            colour <= 3'b111; // white ?
            if (left) // move left
            begin
                if (!x_pos)begin
                    x_pos_reg <= x_pos_reg;
                end
                else begin
                    x_pos_reg <= x_pos_reg - 1'b1;
                end     
            end
            
            else if (right) // move right
            begin
                if(x_pos == 8'd155)begin
                    x_pos_reg <= x_pos_reg;
                end
                else begin
                    x_pos_reg <= x_pos_reg + 1'b1;
                end    
            end
            else // not moving
            begin
               x_pos_reg <= x_pos_reg; 
            end

        end
        else if (got_hit) // dead 
        begin
            x_pos_reg <= x_pos_reg;
            y_pos_reg <= y_pos_reg;
            colour <= 3'b000; //black
        end

    end

    counter c0(clk, reset_n, counter_out);

    /// Draw player 
    always @(counter_out)
    begin
        y_pos <= y_pos_reg + counter_out[3:2];
        x_pos <= x_pos_reg + counter_out[1:0];
    end




endmodule

module counter (clk, reset_n, out);
    input clk, reset_n;
    output reg [3:0] out;

    always @(posedge clk)
    begin
        if(reset_n)
            out <= 4'b0000;
        else 
            out <= out + 1'b1;
    end
endmodule