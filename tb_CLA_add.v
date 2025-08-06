module tb_CLA_add;
    reg [7:0] a, b;

    reg clk, reset;
    wire [8:0] out;

    CLA_add #(.N(8)) DUT (
        .A(a), .B(b),
        .clk(clk), .reset(reset),
        .sum(out)
    );

    always #5 clk = ~clk;

    initial begin
        
        a = 0; b = 0;
        clk = 0; reset = 1;

        #15;
        reset = 0;

        #10;
        a = 7'd25; b = 7'd35;

        #10;
        a = 7'd43; b = 7'd52;

        #10;
        a = 7'd29; b = 7'd0;

        #10;
        a = 7'd78; b = 7'd90;        

    end

    always @(posedge clk) begin
        if (!reset) begin // Only display meaningful data when not in reset
            $display("Time: %0t, Input A: %d, Input B: %d, Output Product: %d", $time, a, b, out);
        end
    end    
    
endmodule