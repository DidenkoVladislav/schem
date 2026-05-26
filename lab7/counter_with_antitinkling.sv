module counter (input logic clk,
    input logic reset,
    input logic step,
    output logic [3:0] q,
    output logic ol);

    always_ff @(posedge clk)
        if (reset)
            q <= 0;
        else
            q <= q + step;

    assign ol = (q==4'b1111);
endmodule

module antitinkling (
    input logic button,
    input logic clk,
    input logic reset,
    output logic out
    );

    logic c;
    logic [19:0] q;

    always_ff @(posedge c)
        out <= button;

    always_ff @(posedge clk, posedge reset)
        if (reset)
            q <= 0;
        else
            q <= q + 1;

    assign c = (q == 20'hFFFFF);
endmodule

module counter_with_antitinkling(input logic button,
    input logic clk,
    input logic reset,
    output logic [3:0] q,
    output logic ol
    );

    logic step;
    antitinkling(button, clk, reset, step);

    counter(clk, reset, step, q, ol);

endmodule