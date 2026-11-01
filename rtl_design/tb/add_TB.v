`timescale 1ns / 1ps

module add_TB();
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] sum;
    wire c_flag;
    // Loop variable for testbench must be an integer, not a genvar
    integer i;

    // Instantiate the device Under Test (UUT)
    add_32 uut (
        .a(a),
        .b(b),
        .c(sum) ,
        .c_flag(c_flag)
    );

    initial begin
        // 1. Directed Edge Cases
        a = 32'd0; b = 32'd0; #10;
        a = 32'd25; b = 32'd15; #10;
        
        // Test overflow condition (Max 32-bit value + 1)
        a = 32'hFFFFFFFF; b = 32'd1; #10; 

        // 2. Automated Randomized Testing
        for (i = 0; i < 10; i = i + 1) begin
            a = $random;
            b = $random;
            #10; // Wait 10 time units to observe the output
        end
        
        $finish; // End the simulation
    end
endmodule