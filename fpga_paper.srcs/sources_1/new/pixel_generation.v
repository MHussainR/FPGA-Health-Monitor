`timescale 1ns / 1ps

module pixel_generation(
    input clk,  
    input clk_slow,
    input [2:0] sel,
    input up,
    input down,
    input left,
    input right,                            
    input reset,
    input reset1,                            
    input video_on,                         
    input [9:0] x, y,  
    output [3:0] digit,
    output [6:0] Y,                     
    output reg [11:0] rgb                   
    );
    
//    parameter X_MAX = 639;                  // right border of display area
//    parameter Y_MAX = 479;                  // bottom border of display area
//    parameter SQ_RGB = 12'h0FF;             // red & green = yellow for square
//    parameter BG_RGB = 12'hF00;             // blue background
//    parameter SQUARE_SIZE = 64;             // width of square sides in pixels
//    parameter SQUARE_VELOCITY_POS = 2;      // set position change value for positive direction
//    parameter SQUARE_VELOCITY_NEG = -2;     // set position change value for negative direction  
    
//    // create a 60Hz refresh tick at the start of vsync 
//    wire refresh_tick;
//    assign refresh_tick = ((y == 481) && (x == 0)) ? 1 : 0;
    
    // square boundaries and position
//    wire [9:0] sq_x_l, sq_x_r;              // square left and right boundary
//    wire [9:0] sq_y_t, sq_y_b;              // square top and bottom boundary
    
//    reg [9:0] sq_x_reg, sq_y_reg;           // regs to track left, top position
//    wire [9:0] sq_x_next, sq_y_next;        // buffer wires
    
//    reg [9:0] x_delta_reg, y_delta_reg;     // track square speed
//    reg [9:0] x_delta_next, y_delta_next;   // buffer regs    
    
    // register control
//    always @(posedge clk or posedge reset)
//        if(reset) begin
//            sq_x_reg <= 0;
//            sq_y_reg <= 0;
//            x_delta_reg <= 10'h002;
//            y_delta_reg <= 10'h002;
//        end
//        else begin
//            sq_x_reg <= sq_x_next;
//            sq_y_reg <= sq_y_next;
//            x_delta_reg <= x_delta_next;
//            y_delta_reg <= y_delta_next;
//        end
    
    // square boundaries
//    assign sq_x_l = sq_x_reg;                   // left boundary
//    assign sq_y_t = sq_y_reg;                   // top boundary
//    assign sq_x_r = sq_x_l + SQUARE_SIZE - 1;   // right boundary
//    assign sq_y_b = sq_y_t + SQUARE_SIZE - 1;   // bottom boundary
    
    // square status signal
//    wire sq_on;
//    assign sq_on = (sq_x_l <= x) && (x <= sq_x_r) &&
//                   (sq_y_t <= y) && (y <= sq_y_b);
    reg [9:0] time1 = 10'd0;
    reg sq1 = 0;
    reg sq2 = 0;
    reg sq3 = 0;
    reg sq4 = 0;
    reg sq5 = 0;
    reg sq6 = 0;
    reg sq7 = 0;
    reg sq8 = 0;
    reg load;
    reg [3:0] seed1 = 4'd4;
    reg [3:0] seed2 = 4'd9;
    reg [3:0] seed3 = 4'd12;
    reg [3:0] seed4 = 4'd3;
    reg [9:0] count = 0;
    reg check = 0;
    reg ply = 0;
    reg [1:0] co = 0;
    reg [4:0] clock = 0;
    reg check2 = 0;
    reg [9:0] time2 = 0;
    reg [9:0] sec = 0;
    reg [5:0] cal = 0;
//    reg [5:0] min = 0;
                   
    // new square position
//    assign sq_x_next = (refresh_tick) ? sq_x_reg + x_delta_reg : sq_x_reg;
//    assign sq_y_next = (refresh_tick) ? sq_y_reg + y_delta_reg : sq_y_reg;
    wire sq1_on; 
    assign sq1_on = (x >= 270) && (x <= 370) && (y >= 90) && (y <= 190);
    
    wire sq2_on;
    assign sq2_on = (x >= 170) && (x <= 270) && (y >= 190) && (y <= 290);
    
    wire sq3_on;
    assign sq3_on = (x >= 270) && (x <= 370) && (y >= 290) && (y <= 390);
    
    wire sq4_on;
    assign sq4_on = (x >= 370) && (x <= 470) && (y >= 190) && (y <= 290);
    
    wire sq5_on;
    assign sq5_on = (x >= 170) && (x <= 270) && (y >= 90) && (y <= 190);
    
    wire sq6_on;
    assign sq6_on = (x >= 170) && (x <= 270) && (y >= 290) && (y <= 390);
    
    wire sq7_on;
    assign sq7_on = (x >= 370) && (x <= 470) && (y >= 290) && (y <= 390);
    
    wire sq8_on;
    assign sq8_on = (x >= 370) && (x <= 470) && (y >= 90) && (y <= 190);
    
    wire black_on1;
    assign black_on1 = ((x >= 169) && (x <= 171) && (y >= 89) && (y <= 391)); 
    wire black_on2;
    assign black_on2 = ((x >= 269) && (x <= 271) && (y >= 89) && (y <= 391)); 
    wire black_on3;
    assign black_on3 = ((x >= 369) && (x <= 371) && (y >= 89) && (y <= 391)); 
    wire black_on4;
    assign black_on4 = ((x >= 469) && (x <= 471) && (y >= 89) && (y <= 391)); 
    wire black_on5;
    assign black_on5 = ((x >= 169) && (x <= 471) && (y >= 89) && (y <= 91)); 
    wire black_on6;
    assign black_on6 = ((x >= 169) && (x <= 471) && (y >= 189) && (y <= 191)); 
    wire black_on7;
    assign black_on7 = ((x >= 169) && (x <= 471) && (y >= 289) && (y <= 291)); 
    wire black_on8;
    assign black_on8 = ((x >= 169) && (x <= 471) && (y >= 389) && (y <= 391)); 
    
     
    
    
    wire [3:0] q;
    
    
//    lfsr l1 (.q(q[0]), .clk(clk), .rst(reset), .seed(4'b1001), .load(1'b1)); 
//    lfsr l2 (.q(q[1]), .clk(clk), .rst(reset), .seed(4'b1100), .load(1'b0));
//    lfsr l3 (.q(q[2]), .clk(clk), .rst(reset), .seed(4'b0101), .load(1'b1));
//    lfsr l4 (.q(q[3]), .clk(clk), .rst(reset), .seed(4'b0000), .load(1'b0));
    
    // new square velocity 
    always @(posedge clk_slow) 
    
    begin
    
    if (ply == 0)
    begin
        if (sel == 3'b001)
        begin
            ply = 1;
            co = 2'd1; 
        end
        else if (sel == 3'b010)
        begin
            ply = 1;
            co = 2'd2;   
        end
        else if (sel == 3'b100)
        begin
            ply = 1;
            co = 2'd3;      
        end   
    end
    else
    begin
    
    if (co == 2'd1)
    begin
        if (time1 == 10'd99)
        begin
            time1 = 10'd0;
            sec = sec + 1;
        end
        else
            time1 = time1 + 1;
            
        if (time1 == 10'd99)
        begin
            if (check)
            begin
                count = count + 1;
                check = 0;
            end
        
            sq1 = 0;
            sq2 = 0;
            sq3 = 0;
            sq4 = 0;
            sq5 = 0;
            sq6 = 0;
            sq7 = 0;
            sq8 = 0;
            
        end
        
        if (time1 == 10'd49)
        begin
            if (load == 0)
                load = 1;
            else
                load = 0;
        
             
            if (seed1 == 4'd15)
                seed1 = 4'd0;
            else
                seed1 = seed1 + 1;
            
            if (seed2 == 4'd15)
                seed2 = 4'd0;
            else
                seed2 = seed2 + 1;
        
            if (seed3 == 4'd15)
                seed3 = 4'd0;
            else
                seed3 = seed3 + 1;
                
            if (seed4 == 4'd15)
                seed4 = 4'd0;
            else
                seed4 = seed4 + 1;
                
          end
    end
    
    
    
    if (co == 2'd2)
    begin
        if (time1 == 10'd49)
        begin
            time1 = 10'd0;
            sec = sec + 1;
        end
        else
            time1 = time1 + 1;
            
        if (time1 == 10'd49)
        begin
            if (check)
            begin
                count = count + 1;
                cal = cal + 4;
                check = 0;
            end
        
            sq1 = 0;
            sq2 = 0;
            sq3 = 0;
            sq4 = 0;
            sq5 = 0;
            sq6 = 0;
            sq7 = 0;
            sq8 = 0;
        end
        
        if (time1 == 10'd24)
        begin
            if (load == 0)
                load = 1;
            else
                load = 0;
        
             
            if (seed1 == 4'd15)
                seed1 = 4'd0;
            else
                seed1 = seed1 + 1;
            
            if (seed2 == 4'd15)
                seed2 = 4'd0;
            else
                seed2 = seed2 + 1;
        
            if (seed3 == 4'd15)
                seed3 = 4'd0;
            else
                seed3 = seed3 + 1;
                
            if (seed4 == 4'd15)
                seed4 = 4'd0;
            else
                seed4 = seed4 + 1;
                
          end
    end
    
    
    
    if (co == 2'd3)
    begin
        if (time1 == 10'd99)
        begin
            time1 = 10'd0;
            if (clock == 5'd20)
                clock = 5'd0;
            else
                clock = clock + 1;
        end
        else
            time1 = time1 + 1;
            
        if (clock == 5'd0)
        begin
            if (check2 == 0)
                check2 = 1;
            else
                check2 = 0;
        end
            
            
        if (check2 == 1)
        begin
            if (time2 == 10'd99)
                time2 = 10'd0;
            else
                time2 = time2 + 1;
                
            if (time2 == 10'd99)
            begin
                if (check)
                begin
                    count = count + 1;
                    check = 0;
                end
            
                sq1 = 0;
                sq2 = 0;
                sq3 = 0;
                sq4 = 0;
                sq5 = 0;
                sq6 = 0;
                sq7 = 0;
                sq8 = 0;
                
            end
            
            if (time2 == 10'd49)
            begin
                if (load == 0)
                    load = 1;
                else
                    load = 0;
            
                 
                if (seed1 == 4'd15)
                    seed1 = 4'd0;
                else
                    seed1 = seed1 + 1;
                
                if (seed2 == 4'd15)
                    seed2 = 4'd0;
                else
                    seed2 = seed2 + 1;
            
                if (seed3 == 4'd15)
                    seed3 = 4'd0;
                else
                    seed3 = seed3 + 1;
                    
                if (seed4 == 4'd15)
                    seed4 = 4'd0;
                else
                    seed4 = seed4 + 1;
                    
              end
        end 
        
        if (check2 == 0)
        begin
            if (time2 == 10'd49)
                time2 = 10'd0;
            else
                time2 = time2 + 1;
                
            if (time2 == 10'd49)
            begin
                if (check)
                begin
                    count = count + 1;
                    check = 0;
                end
            
                sq1 = 0;
                sq2 = 0;
                sq3 = 0;
                sq4 = 0;
                sq5 = 0;
                sq6 = 0;
                sq7 = 0;
                sq8 = 0;
                
            end
            
            if (time2 == 10'd24)
            begin
                if (load == 0)
                    load = 1;
                else
                    load = 0;
            
                 
                if (seed1 == 4'd15)
                    seed1 = 4'd0;
                else
                    seed1 = seed1 + 1;
                
                if (seed2 == 4'd15)
                    seed2 = 4'd0;
                else
                    seed2 = seed2 + 1;
            
                if (seed3 == 4'd15)
                    seed3 = 4'd0;
                else
                    seed3 = seed3 + 1;
                    
                if (seed4 == 4'd15)
                    seed4 = 4'd0;
                else
                    seed4 = seed4 + 1;
                    
              end
        end 
//        if (time1 == 10'd99)
//        begin
//            if (check)
//            begin
//                count = count + 1;
//                check = 0;
//            end
        
//            sq1 = 0;
//            sq2 = 0;
//            sq3 = 0;
//            sq4 = 0;
//            sq5 = 0;
//            sq6 = 0;
//            sq7 = 0;
//            sq8 = 0;
//        end
        
//        if (time1 == 10'd49)
//        begin
//            if (load == 0)
//                load = 1;
//            else
//                load = 0;
        
             
//            if (seed1 == 4'd15)
//                seed1 = 4'd0;
//            else
//                seed1 = seed1 + 1;
            
//            if (seed2 == 4'd15)
//                seed2 = 4'd0;
//            else
//                seed2 = seed2 + 1;
        
//            if (seed3 == 4'd15)
//                seed3 = 4'd0;
//            else
//                seed3 = seed3 + 1;
                
//            if (seed4 == 4'd15)
//                seed4 = 4'd0;
//            else
//                seed4 = seed4 + 1;
                
//          end
    end

    
        
    if (sq1)
        if (up)
            check = 1;
    if (sq2)
        if (left)
            check = 1;
    if (sq3)
        if (down)
            check = 1;
    if (sq4)
        if (right)
            check = 1; 


    if (time1 == 10'd0 && load == 1) // 
    begin
        if (q >= 4'd14)
            sq1 = 1;
        else if (q >= 4'd12)
            sq2 = 1;
        else if (q >= 4'd10)
            sq3 = 1;
        else if (q >= 4'd8)
            sq4 = 1;
        else if (q >= 4'd6)
            sq5 = 1;
        else if (q >= 4'd4)
            sq6 = 1;
        else if (q >= 4'd2)
            sq7 = 1;
        else if (q >= 4'd0)
            sq8 = 1;
    end
    
    if (reset1)
    begin
        sq1 = 0;
        sq2 = 0;
        sq3 = 0;
        sq4 = 0;
        sq5 = 0;
        sq6 = 0;
        sq7 = 0;
        sq8 = 0;
        count = 0;
        ply = 0;
        co = 0;
        sec = 0;
        cal = 0;
    end

    end
    
    end
    
    lfsr l1 (.q(q[0]), .clk(clk), .rst(reset), .seed(seed1), .load(load)); 
    lfsr l2 (.q(q[1]), .clk(clk), .rst(reset), .seed(seed2), .load(load));
    lfsr l3 (.q(q[2]), .clk(clk), .rst(reset), .seed(seed3), .load(~load));
    lfsr l4 (.q(q[3]), .clk(clk), .rst(reset), .seed(seed4), .load(~load));
    
    
    wire [3:0] num0;
    wire [3:0] num1;
    wire [3:0] num2;
    wire [3:0] num3;
    
    
    binary_2_bcd b2b (.clk(clk), .num(sec), .num0(num0), .num1(num1), .num2(num2), .num3(num3));
    
    score_count sc (.clk_100MHz(clk), .reset(reset), .ones(num0), .tens(num1), .hundreds(num2), .thousands(num3), .seg(Y), .digit(digit));
    
wire [3:0] numb0;
wire [3:0] numb1;
wire [3:0] numb2;
wire [3:0] numb3;  
wire [6:0] asciib_char0;
wire [6:0] asciib_char1;
wire [6:0] asciib_char2; 
binary_2_bcd b2b1 (.clk(clk), .num(count), .num0(numb0), .num1(numb1), .num2(numb2), .num3(numb3));
bcd_2_hex b2h1 (.clk(clk), .bcd(numb0), .hex(asciib_char0));
bcd_2_hex b2h2 (.clk(clk), .bcd(numb1), .hex(asciib_char1));
bcd_2_hex b2h3 (.clk(clk), .bcd(numb2), .hex(asciib_char2));

wire [11:0] ascii_rgb;

wire asciib_on0;
wire asciib_on1;
wire asciib_on2;

ascii_test_1 test1(.ascii_char(asciib_char2),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd311),.y_loc(10'd66), .on(asciib_on3),.rgb(ascii_rgb));    
ascii_test_1 test2(.ascii_char(asciib_char1),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd319),.y_loc(10'd66), .on(asciib_on2),.rgb(ascii_rgb));    
ascii_test_1 test3(.ascii_char(asciib_char0),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd327),.y_loc(10'd66), .on(asciib_on1),.rgb(ascii_rgb));    


wire [3:0] numr0;
wire [3:0] numr1;
wire [3:0] numr2;
wire [3:0] numr3;  
wire [6:0] asciir_char0;
wire [6:0] asciir_char1;
wire [6:0] asciir_char2; 
wire [6:0] asciir_char3; 
binary_2_bcd b2b2 (.clk(clk), .num(cal), .num0(numr0), .num1(numr1), .num2(numr2), .num3(numr3));
bcd_2_hex b2h4 (.clk(clk), .bcd(numr0), .hex(asciir_char0));
bcd_2_hex b2h5 (.clk(clk), .bcd(numr1), .hex(asciir_char1));
bcd_2_hex b2h6 (.clk(clk), .bcd(numr2), .hex(asciir_char2));
bcd_2_hex b2h7 (.clk(clk), .bcd(numr3), .hex(asciir_char3));

wire asciir_on0;
wire asciir_on1;
wire asciir_on2;
wire asciir_on3;
wire asciir_on4;

ascii_test_1 test4(.ascii_char(asciir_char3),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd303),.y_loc(10'd226), .on(asciir_on3),.rgb(ascii_rgb));    
ascii_test_1 test5(.ascii_char(asciir_char2),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd311),.y_loc(10'd226), .on(asciir_on2),.rgb(ascii_rgb));
ascii_test_1 test8(.ascii_char(7'h2e),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd319),.y_loc(10'd226), .on(asciir_on4),.rgb(ascii_rgb));    
ascii_test_1 test6(.ascii_char(asciir_char1),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd327),.y_loc(10'd226), .on(asciir_on1),.rgb(ascii_rgb));    
ascii_test_1 test7(.ascii_char(asciir_char0),.clk(clk),.video_on(video_on),.x(x),.y(y),.x_loc(10'd335),.y_loc(10'd226), .on(asciir_on0),.rgb(ascii_rgb));     
    
    // RGB control
    always @(posedge clk)
        if(~video_on)
            rgb = 12'h000;         
        else
        begin
            if (ply == 0)
                rgb = 12'hFF0;
            else if (black_on1 | black_on2 | black_on3 | black_on4 | black_on5 | black_on6 | black_on7 | black_on8)
                rgb = 12'h000;
            else if(sq1_on)
            begin
                if (sq1 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end    
            else if (sq2_on)
            begin
                if (sq2 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end 
            else if (sq3_on)
            begin
                if (sq3 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end  
            else if (sq4_on)
            begin
                if (sq4 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end 
            else if (sq5_on)
            begin
                if (sq5 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end
            else if (sq6_on)
            begin
                if (sq6 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end
            else if (sq7_on)
            begin
                if (sq7 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end
            else if (sq8_on)
            begin
                if (sq8 == 1)
                    rgb = 12'h0F0;
                else
                    rgb = 12'hFFF; 
            end
            else if (asciib_on1 | asciib_on2 | asciib_on3)
                rgb = 12'hF00;
            else if (asciir_on1 | asciir_on2 | asciir_on3 | asciir_on0 | asciir_on4)
                rgb = 12'h0F0;
            else
                rgb = 12'h00F;
        end
              
    
endmodule