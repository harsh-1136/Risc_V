module reg_file_32_optimized(
    input clk,
    input write_enable,
    input [4:0] read_addr_1,  // For Operand A
    input [4:0] read_addr_2,  // For Operand B
    input [4:0] write_addr,   // For Destination
    input [31:0] data_write,
    output [31:0] data_read_1,
    output [31:0] data_read_2
    );

    reg [31:0] r [31:0];

    // Synchronous Write
    always @(posedge clk) begin
        if (write_enable && write_addr != 5'd0) begin // Protect r[0]
            r[write_addr] <= data_write;
        end
    end

    // Combinational Read (Bypasses case statements entirely)
    assign data_read_1 = (read_addr_1 == 5'd0) ? 32'd0 : r[read_addr_1];
    assign data_read_2 = (read_addr_2 == 5'd0) ? 32'd0 : r[read_addr_2];

endmodule