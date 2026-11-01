`timescale 1ns / 1ps

module mux(
    input [4:0] sel,
    input [31:0] ins,
    output out 
    );  
    assign out = ins[sel];
endmodule

module right_shift(
    input [31:0] a,
    input [31:0] shift_by,
    output [31:0] result
    );
    
    genvar i, j;
    generate
        // We need 32 MUXes. Each MUX determines exactly one bit of the output.
        for (i = 0; i < 32; i = i + 1) begin : gen_muxes
            
            // This wire array holds the 32 inputs for this specific MUX
            wire [31:0] mux_inputs;
            
            // Hardwire the staggered bit-shifts for MUX 'i'
            for (j = 0; j < 32; j = j + 1) begin : gen_wiring
                if (i + j < 32) begin
                    assign mux_inputs[j] = a[i + j]; // Connect to the original bit
                end else begin
                    assign mux_inputs[j] = 1'b0;     // Shifted past MSB, hardwire to Ground
                end
            end
            
            // Instantiate the 32-to-1 MUX for output bit 'i'
            mux m_inst (
                .sel(shift_by[4:0]),
                .ins(mux_inputs),
                .out(result[i])
            );
            
        end
    endgenerate

endmodule