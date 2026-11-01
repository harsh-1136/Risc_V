`timescale 1ns / 1ps

module arith_right_shift_TB();
    reg signed [31:0] a;
    reg [31:0] shift_by;
    wire [31:0] result;
    integer i;

    arith_right_shift uut (
        .a(a),
        .shift_by(shift_by),
        .result(result)
    );

    initial begin
        $monitor("Time=%0t | a=%h (dec:%d) | shift=%0d | result=%h (dec:%d)", 
                 $time, a, a, shift_by, result, result);

        // Test positive number (sign bit is 0)
        a = 32'sh000000F0; shift_by = 4; #10;
        
        // Test negative number (sign bit is 1; notice 1s fill from the left)
        a = 32'shF0000000; shift_by = 4; #10;
        a = 32'sh80000000; shift_by = 1; #10;

        // Automated tests
        for (i = 0; i < 5; i = i + 1) begin
            a = $random;
            shift_by = $random % 32;
            #10;
        end
        
        $finish;
    end
endmodule