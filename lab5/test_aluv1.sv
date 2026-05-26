module test_aluv1();
    logic clk,reset;

    logic [3:0] operandA, operandB;
    logic [2:0] funcsel;
    logic [3:0] result, resultexpected;

    logic [31:0] vectornum, errors;
    logic [14:0] testvectors [100:0];

    aluv1 aluv1_inst(operandA, operandB, funcsel, result);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_aluv1.txt", testvectors);
        vectornum =0;
        errors=0;
        reset =1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {operandA, operandB, funcsel, resultexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if (result!==resultexpected)
                begin
                    $display("Error: inputs = %b %b %b %b", operandA, operandB, funcsel, resultexpected);
                    $display(" outputs = %b (%b expected)", result,
                    resultexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===15'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule