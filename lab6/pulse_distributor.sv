module pulse_distributor (
    input  logic clk, reset,
    output logic [3:0] q
);

    always_ff @(posedge clk)
        if (reset)
            q <= 4'b0000;
        else if (q==4'b0000)
            q[3] <= 1;
        else
            q <= {q[0], q[3:1]};
endmodule