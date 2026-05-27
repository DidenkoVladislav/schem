module counter (input logic clk,
    input logic reset,
    input logic count,
    input logic load,
    input logic [3:0] load_data,
    output logic [3:0] q,
    output logic ol);

    always_ff @(posedge clk)
        if (reset)
            q <= 0;
        else if (load)
            q <= load_data;
        else if (count)
            q <= q + 1;

    assign ol = count && (q==4'b1111);
endmodule

module flopenr(input logic clk, reset, en, d,
    output logic q);

    always_ff @(posedge clk)
        if (reset)
            q <= 1'b0;
        else if (en)
            q <= d;
endmodule

module counter_double(input logic clk,
    input logic reset,
    input logic load,
    input logic [8:0] start,
    input logic [8:0] stop,
    output logic [8:0] q,
    output logic max_reached
    );

    logic ol, ol2, ol3;

    counter c1(clk && !max_reached, reset, clk, load, start[3:0], q[3:0], ol);

    counter c2(clk && !max_reached, reset, ol, load, start[7:4], q[7:4], ol2);

    flopenr flop(clk && !max_reached, reset, ol2, 1'b1, q[8]);

    assign max_reached = (q===stop);

endmodule