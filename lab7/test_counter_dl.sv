module test_counter_dl();
    logic clk, reset;

    logic _clk, _reset, step=1, load;
    logic [3:0] q, qexpected, data_load;
    logic ol, olexpected;

    logic [31:0] vectornum, errors;
    logic [11:0] testvectors [100:0];

    counter_dl counter_dl_inst(_clk, _reset, step, load, data_load, q, ol);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_counter_dl.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, _reset, load, data_load, qexpected, olexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if ((q!==qexpected) || (ol!==olexpected))
                begin
                    $display("Error (%d): inputs = %b %b %d %b %b", vectornum + 1, _clk, _reset, step, load, data_load);
                    $display(" outputs = %b %b (%b %b expected)", q, ol,
                    qexpected, olexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===12'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule