`timescale 1ns / 1ps

module logical_left_shift_TB();
    reg [31:0] a;
    reg [31:0] shift_by;
    wire [31:0] result;
    integer i;

    logical_left_shift uut (
        .a(a),
        .shift_by(shift_by),
        .result(result)
    );

    initial begin
        $monitor("Time=%0t | a=%h | shift=%0d | result=%h", 
                 $time, a, shift_by, result);

        // Test basic left shift
        a = 32'h00000001; shift_by = 4; #10;
        a = 32'h000000FF; shift_by = 8; #10;
        
        // Test shifting bits out past the MSB
        a = 32'h80000000; shift_by = 1; #10;

        // Automated tests
        for (i = 0; i < 5; i = i + 1) begin
            a = $random;
            shift_by = $random % 32;
            #10;
        end
        
        $finish;
    end
endmodule