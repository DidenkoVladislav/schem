module floppc(input logic clk, load,
    input logic [3:0] d,
    output logic out);

    logic [3:0] q;

    always_ff @(posedge clk)
        if (load)
            q <= d;
        else
            q <= {1'b0, q[3:1]};
    
    assign out = q[0];
endmodule