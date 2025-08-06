module CLA_add #(parameter N = 4) (
    input [N-1:0] A, B,
    input clk, reset,
    output [N:0] sum
);

    wire [N-1:0] p, g;

    wire [N-1:0] g_wireOut;
    wire [N:0] p_wireOut;

    assign p_wireOut[N] = 1'b0;

    wire [N:0] c;

    wire [N:0] sum_in;

    assign c[0] = 1'b0;

    wire [N-1:0] a, b;

/* Stage 0  start */
    stage_register #(.N(N)) s1_A(
        .data_in(A),
        .clk(clk), .reset(reset),
        .data_out(a)
    );
    stage_register #(.N(N)) s1_B(
        .data_in(B),
        .clk(clk), .reset(reset),
        .data_out(b)
    );
/* Stage 0 end */        

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            assign p[i] = a[i] ^ b[i];
            assign g[i] = a[i] & b[i];
        end
    endgenerate


    stage_register #(.N(N)) s1(
        .data_in(p),
        .clk(clk), .reset(reset),
        .data_out(p_wireOut[N-1:0])
    );

    stage_register #(.N(N)) s2(
        .data_in(g),
        .clk(clk), .reset(reset),
        .data_out(g_wireOut)
    );



    generate
        for (i = 1; i < N + 1; i = i + 1) begin
            products_generator #(.N(i)) PG (
                .p(p_wireOut[i-1:0]),
                .g(g_wireOut[i-1:0]),
                .carry_in(c[0]),
                .clk(clk), .reset(reset),
                .cout(c[i])
            );
        end
    endgenerate

    generate
        for (i = 0; i < N + 1; i = i + 1) begin
            assign sum_in[i] = p_wireOut[i] ^ c[i];
        end
    endgenerate

    stage_register #(.N(N+1)) s4(
        .data_in(sum_in),
        .clk(clk), .reset(reset),
        .data_out(sum)
    );


endmodule