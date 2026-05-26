module counter_dl (input logic clk,
    input logic reset,
    input logic step,
    input logic load,
    input logic [3:0] data_load,
    output logic [3:0] q,
    output logic ol);

    always_ff @(posedge clk)
        if (reset)
            q <= 0;
        else if (load)
            q <= data_load;
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
    input logic load,
    input logic [3:0] data_load,
    output logic [3:0] q,
    output logic ol
    );

    logic step;
    antitinkling(button, clk, reset, step);

    counter_dl(clk, reset, step, load, data_load, q, ol);

endmodule