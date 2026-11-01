`timescale 1ns / 1ps

module sub_32(
    input [31:0] a,
    input [31:0] b,
    output [31:0] result,
    output borrow
    );
    
    wire [31:0] bn = ~b + 32'd1;
    wire carry_out; 
    add_32 ins1 (
        .a(a),
        .b(bn),
        .c(result),
        .c_flag(carry_out)
    );
    assign borrow = ~carry_out;
    
endmodule