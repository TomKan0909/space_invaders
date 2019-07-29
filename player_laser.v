module player_laser(
    input clk,
    input reset_n,
    input shoot, // signal to shoot the laser
    input [7:0] x_pos, // x_position of player, need to add 1 to center it
    input [6:0] y_pos, // y_position of player
    input hit, // signal to determine if laser hits alien
    output reg [7:0] x_laser, // current x - position of laser
    output reg [6:0] y_laser, // current y - position of laser 
    output reg [2:0] colour 
);
  
  
    // 1X1 laser for now, if player already shoots laser, they can only shoot
    // after it hits someone or the laser goes out of map boundary

    reg shot; // register player shoot at least once
    wire [22:0] q; // output of rate divider
    ratedivider r0(clk, reset_n, q);

    always @(posedge clk)
    begin
        if(reset_n) // sets laser intial point to player
        begin
            x_laser <= x_pos;   
            y_laser <= y_pos;
            colour <= 3'b111;
        end
        else if (shoot) // set shot to 1; intial shot starting position
            shot <= 1'b1;
            x_laser <= x_pos;
            y_laser <= y_pos;
    end

    always @(*)
    begin
        if(shot == 1'b1 && q == 1'b0)
        begin 
            if(y_laser == 1'b0 || hit == 1'b1) // if it reached end of map or hits an
            begin
                x_laser <= x_pos;   //return back to player position
                y_laser <= y_pos;   //
                colour <= 3'b111;
                shot <= 1'b0;       // won't draw another laser
            end
            else 
            begin
                x_laser <= x_laser;
                y_laser <= y_laser - 1'b1; // laser travels upwards 
            end
        end
    end


endmodule

// Use for speed of laser 
module ratedivider(clock, reset_n, q)
    input clk, reset_n;
    output reg [22:0] q;

    always @(posedge clk)
    begin
        if(reset_n)
        begin 
            q <= 23'd5_000_000; // 1/10 of a second
        end
        else 
        begin
            if(q == 1'b0)
                q <= 23'd5_000_000;
            else
                q <= q - 1;
        end
    end

endmodule