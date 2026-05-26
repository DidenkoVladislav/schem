module test_floppc();
    logic clk, reset;

    logic _clk, load;
    logic [3:0] d;
    logic out, outexpected;

    logic [31:0] vectornum, errors;
    logic [6:0] testvectors [100:0];

    floppc floppc_inst(_clk, load, d, out);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_floppc.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, load, d, outexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if (out!==outexpected)
                begin
                    $display("Error (%d): inputs = %b %b %b", vectornum, _clk, load, d);
                    $display(" outputs = %b (%b expected)", out,
                    outexpected);
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