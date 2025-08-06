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

        #40;
        a = 7'b0110011; b = 7'b0011110;

        #40;
        a = 7'b1010101; b = 7'b0110010;


    end

    always @(posedge clk) begin
        if (!reset) begin
            $display("Time: %0t, Input A: %b, Input B: %b, Output Product: %b", $time, a, b, out);
        end
    end    
    

endmodule
