module flopr(input logic clk, reset, d,
    output logic q);
    // synchronous reset
    always_ff @(posedge clk)
        if (reset)
            q <= 1'b0;
        else
            q <= d;
endmodule