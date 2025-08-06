module stage_register #(parameter N = 64) (
    input [N-1:0] data_in,
    input clk, reset,
    output reg [N-1:0] data_out
);

    always @(posedge clk, posedge reset) begin
        if (reset) data_out <= {N{1'b0}};
        else begin
            data_out <= data_in;
            //$display("From stage reg: %d , %d", data_in, data_out);
        end
    end
    
endmodule