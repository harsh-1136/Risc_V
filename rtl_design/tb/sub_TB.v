`timescale 1ns / 1ps

module sub_TB();
    
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] diff;
    wire borrow;
    integer i;
    sub_32 uut (
        .a(a),
        .b(b),
        .result(diff) ,
        .borrow(borrow)
    );

    initial begin
        // 1. Directed Edge Cases
        a = 32'd0;  b = 32'd0;  #10;
        
        // Standard subtraction
        a = 32'd25; b = 32'd15; #10; 
        
        // Negative result (Expected output is 2's complement of 10: 0xFFFFFFF6)
        a = 32'd15; b = 32'd25; #10; 
        
        // Test underflow condition (0 - 1 = 0xFFFFFFFF)
        a = 32'd0;  b = 32'd1;  #10; 

        // 2. Automated Randomized Testing
        for (i = 0; i < 10; i = i + 1) begin
            a = $random;
            b = $random;
            #10; 
        end
        
        $finish; 
    end
endmodule