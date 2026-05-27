module test_counter_double();
    logic clk, reset;

    logic _clk, _reset, load;
    logic [8:0] start = 9'd45, stop = 9'd275;
    logic [8:0] q, qexpected;
    logic max_reached, max_reachedexpected;

    logic [31:0] vectornum, errors;
    logic [12:0] testvectors [500:0];

    counter_double counter_double_inst(_clk, _reset, load, start, stop, q, max_reached);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_counter_double.txt", testvectors);
        vectornum=0;
        errors=0;
        reset=1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {_clk, _reset, load, qexpected, max_reachedexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if ((q!==qexpected) || (max_reached!==max_reachedexpected))
                begin
                    $display("Error (%d): inputs = %b %b %b %b %b", vectornum + 1, _clk, _reset, load, start, stop);
                    $display(" outputs = %b %b (%b %b expected)", q, max_reached,
                    qexpected, max_reachedexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===13'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule