module alien(
    input clk,
    input reset_n,
    input x_start, // starting x - position; hard coded
    input y_start, // starting y - position; hard coded
    input got_hit, // signals wheter alien has been shot by player
    input right, // alien constantly moving so if not right its going left 0-
    output reg [7:0] x_pos, // current x_position - sent to vga 
    output reg [7:0] y_pos, // current y_position - sent to vga
    output reg [2:0] colour, 
);
    reg [7:0] x_pos_reg;
    reg [6:0] y_pos_reg;

    always @ (clk)
    begin
        if (reset_n) // starting positions for aliens
        begin 
            x_pos_reg <= x_start;
            y_pos_reg <= y_start;
        end
        else if (!got_hit) // still alive 
        begin
        colour <= 3'b111;
        if 
            
        end

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