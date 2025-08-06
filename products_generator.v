module products_generator #(parameter N = 4) (
    input [N-1:0] g, p,
    input carry_in,
    input clk, reset,
    output cout
);

    wire [N:0] products;
    wire [N:0] products_wireOut;

    genvar i;


    assign products[0] = g[N-1];

    generate
        for (i = N-1; i > 0; i = i - 1) begin
            assign products[N-i] = g[i-1] & (&p[N-1:i]);   // Two levels of AND gated won't synthesised, single AND gate!
        end
    endgenerate

    assign products[N] = carry_in & (&p);

    stage_register #(.N(N+1)) s1(
        .data_in(products),
        .clk(clk), .reset(reset),
        .data_out(products_wireOut)
    );

    //assign cout = |products_wireOut;

    wire temp = |products_wireOut;

    stage_register #(.N(1)) s3(
        .data_in(temp),
        .clk(clk), .reset(reset),
        .data_out(cout)
    );
    
endmodule