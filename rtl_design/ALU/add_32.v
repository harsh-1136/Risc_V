`timescale 1ns / 1ps

module add_32(
    input [31:0] a,
    input [31:0] b,
    output [31:0] c,
    output c_flag
    );
    wire [31:0] w_carry;
    ha HA1 (
        .a(a[0]),
        .b(b[0]),
        .sum(c[0]),
        .carry(w_carry[0])
    );
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : gen_adders
            fa FA1 (
                .a(a[i]),
                .b(b[i]),
                .cin(w_carry[i-1]),
                .sum(c[i]),
                .cout(w_carry[i])
            );
        end
    endgenerate
    assign c_flag=w_carry[31];
endmodule
module ha(
    input a,
    input b,
    output sum,
    output carry
    );
    
    assign sum = a ^ b;
    assign carry = a & b;
endmodule
module fa(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule