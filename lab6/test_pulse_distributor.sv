module test_pulse_distributor();
    logic clk, reset;

    logic _clk, _reset;
    logic [3:0] q, qexpected;

    logic [31:0] vectornum, errors;
    logic [5:0] testvectors [100:0];

    pulse_distributor pulse_distributor_inst(_clk, _reset, q);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_pulse_distributor.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, _reset, qexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if (q!==qexpected)
                begin
                    $display("Error (%d): inputs = %b %b", vectornum, _clk, _reset);
                    $display(" outputs = %b (%b expected)", q,
                    qexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===6'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule