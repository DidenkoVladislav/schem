module test_aluv3();
    logic clk,reset;

    logic [3:0] operandA, operandB;
    logic [2:0] funcsel;
    logic [3:0] result, resultexpected;
    logic zero, zeroexpected, Negative, Negativeexpected;

    logic [31:0] vectornum, errors;
    logic [16:0] testvectors [100:0];

    aluv3 aluv3_inst(operandA, operandB, funcsel, result, zero, Negative);

    always
    begin
        clk=1; #5; clk=0; #5;
    end

    initial
    begin
        $readmemb ("test_aluv3.txt", testvectors);
        vectornum =0;
        errors=0;
        reset =1; #27; reset=0;
    end

    always @ (posedge clk)
    begin
        #1; {operandA, operandB, funcsel, resultexpected, zeroexpected, Negativeexpected} = testvectors [vectornum];
    end

    always @(negedge clk)
    begin
        if (~reset)
        begin
            if ((result!==resultexpected) || (zero!==zeroexpected) || (Negative!==Negativeexpected))
                begin
                    $display("Error: inputs = %b %b %b %b %b", operandA, operandB, funcsel, resultexpected, zeroexpected);
                    $display(" outputs = %b %b %b (%b %b %b expected)", result, zero, Negative,
                    resultexpected, zeroexpected, Negativeexpected);
                    errors = errors+1;
                end
                vectornum = vectornum+1;
            if (testvectors[vectornum]===17'bx)
                begin
                    $display("%d tests completed with %d errors",
                    vectornum, errors);
                    $stop;
                end
        end
    end
endmodule