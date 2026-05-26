module test_flop();
    logic clk, reset;

    logic _clk, d;
    logic q, qexpected;

    logic [31:0] vectornum, errors;
    logic [2:0] testvectors [100:0];

    flop flop_inst(_clk, d, q);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_flop.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, d, qexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if (q!==qexpected)
                begin
                    $display("Error: inputs = %b %b", _clk, d);
                    $display(" outputs = %b (%b expected)", q,
                    qexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===3'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule