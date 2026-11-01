`timescale 1ns / 1ps

module arith_right_shift(
    input signed [31:0] a,
    input [31:0] shift_by,
    output [31:0] result
    );
    
    // Declaring 'a' as signed and using '>>>' forces arithmetic sign-extension
    assign result = a >>> shift_by[4:0];

endmodule