module flopenr(input logic clk, reset, en, d,
    output logic q);

    always_ff @(posedge clk)
        if (reset)
            q <= 1'b0;
        else if (en)
            q <= d;
endmodule