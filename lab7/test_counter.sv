module test_counter();
    logic clk, reset;

    logic _clk, _reset, step=1;
    logic [3:0] q, qexpected;
    logic ol, olexpected;

    logic [31:0] vectornum, errors;
    logic [6:0] testvectors [100:0];

    counter counter_inst(_clk, _reset, step, q, ol);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_counter.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, _reset, qexpected, olexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if ((q!==qexpected) || (ol!==olexpected))
                begin
                    $display("Error (%d): inputs = %b %b %d", vectornum + 1, _clk, _reset, step);
                    $display(" outputs = %b %b (%b %b expected)", q, ol,
                    qexpected, olexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===7'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule