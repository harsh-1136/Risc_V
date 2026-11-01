`timescale 1ns / 1ps

module logical_left_shift(
    input [31:0] a,
    input [31:0] shift_by,
    output [31:0] result
    );
    
    // Using '<<' performs a logical left shift, padding with zeros on the right
    assign result = a << shift_by[4:0];

endmodule