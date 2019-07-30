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

	 reg can_move;
	 
	 
	 
    wire [4:0] counter_out;

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
            if (left && can_move == 1'b1) // move left
            begin
                if (!x_pos)begin
                    x_pos_reg <= x_pos_reg;
                end
                else begin
                    x_pos_reg <= x_pos_reg - 1'b1;
                end     
            end
            
            else if (right && can_move == 1'b1) // move right
            begin
                if(x_pos == 8'd153)begin
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
        end

    end
	
    counter c0(clk, reset_n, counter_out);

    /// Draw player 
    //always @(counter_out)
   // begin
		  
       // y_pos <= y_pos_reg + counter_out[3:2];
        //x_pos <= x_pos_reg + counter_out[1:0];
		//  colour <= 3'b111;
    //end
	 
	 
	 
	 
	 
	 always @(posedge clk)
	 begin
		case(counter_out)
			5'd0: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg;
						colour <= 3'b000;
						can_move <= 1'b0;
					end
			
			5'd1: begin 
						y_pos <= y_pos_reg + 1'd1;
						x_pos <= x_pos_reg;
						colour <= 3'b000;
						can_move <= 1'b0;
					end
			5'd2: begin 
						y_pos <= y_pos_reg + 2'd2;
						x_pos <= x_pos_reg;
						colour <= 3'b000;
						can_move <= 1'b0;
					end
			5'd3: begin 
						y_pos <= y_pos_reg + 2'd3;
						x_pos <= x_pos_reg;
						colour <= 3'b000;
						can_move <= 1'b0;
					end
			5'd4: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg + 1'd1;
						colour <= 3'b111;
						can_move <= 1'b0;
					end
			5'd5: begin 
						y_pos <= y_pos_reg + 1'd1;
						x_pos <= x_pos_reg + 1'd1;
						colour <= 3'b111;
						can_move <= 1'b0;
					end
			5'd6: begin 
						y_pos <= y_pos_reg + 2'd2;
						x_pos <= x_pos_reg + 1'd1;
						colour <= 3'b111;
						can_move <= 1'b0;
					end
			5'd7: begin
						y_pos <= y_pos_reg + 2'd3;
						x_pos <= x_pos_reg + 1'd1;
						colour <= 3'b111;
						can_move <= 1'b0;
					end 
			5'd8: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg + 2'd2;
						colour <= 3'b111;
						can_move <= 1'b0;
					end
			5'd9: begin 
						y_pos <= y_pos_reg + 1'd1;
						x_pos <= x_pos_reg + 2'd2;
						colour <= 3'b111;
						can_move <= 1'b0;
					end
			5'd10: begin 
					   y_pos <= y_pos_reg + 2'd2;
						x_pos <= x_pos_reg + 2'd2;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd11: begin 
						y_pos <= y_pos_reg + 2'd3;
						x_pos <= x_pos_reg + 2'd2;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd12: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg + 3'd3;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd13: begin 
						y_pos <= y_pos_reg + 1'd1;
						x_pos <= x_pos_reg + 3'd3;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd14: begin 
						y_pos <= y_pos_reg + 3'd2;
						x_pos <= x_pos_reg + 3'd3;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd15: begin 
						y_pos <= y_pos_reg + 3'd3;
						x_pos <= x_pos_reg + 3'd3;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd16: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg + 3'd4;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd17: begin 
						y_pos <= y_pos_reg + 3'd1;
						x_pos <= x_pos_reg + 3'd4;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd18: begin 
						y_pos <= y_pos_reg + 3'd2;
						x_pos <= x_pos_reg + 3'd4;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd19: begin 
						y_pos <= y_pos_reg + 3'd3;
						x_pos <= x_pos_reg + 3'd4;
						colour <= 3'b111;
						can_move <= 1'b0;
					 end
			5'd20: begin 
						y_pos <= y_pos_reg;
						x_pos <= x_pos_reg + 3'd5;
						colour <= 3'b000;
						can_move <= 1'b0;
					 end
			5'd21: begin 
						y_pos <= y_pos_reg + 3'd1;
						x_pos <= x_pos_reg + 3'd5;
						colour <= 3'b000;
						can_move <= 1'b0;
					 end
			5'd22: begin 
						y_pos <= y_pos_reg + 3'd2;
						x_pos <= x_pos_reg + 3'd5;
						colour <= 3'b000;
						can_move <= 1'b0;
					 end
			5'd23: begin 
						y_pos <= y_pos_reg + 3'd3;
						x_pos <= x_pos_reg + 3'd5;
						colour <= 3'b000;
						can_move <= 1'b1;
					 end
		
	 endcase
	 end
	 
	 
	 
	 
	 //erase 
	 //always @(counter_out)
	 //begin
	//		if (left_right) begin
				 //draw_erase <= 1b'1;
		//		 y_pos <= y_pos_reg + counter_out[3:2];
		//		 x_pos <= x_pos_reg - 4 + counter_out[1:0];
		 //      colour <= 3'b000;
		//	end
			
		//	else begin
				//draw_erase <= 1b'1;
		//		y_pos <= y_pos_reg + counter_out[3:2];
		//		x_pos <= x_pos_reg + 4 + counter_out[1:0];
		//      colour <= 3'b000;
		//	end
	 
	// end
	 
	 



endmodule

module counter (clk, reset_n, out);
    input clk, reset_n;
    output reg [4:0] out;

    always @(posedge clk)
    begin
        if(reset_n)
            out <= 5'b00000;
        else 
            if (out == 5'd23)
				begin 
					out <= 5'd0;
				end
				
				out <= out + 1'b1;
    end
endmodule