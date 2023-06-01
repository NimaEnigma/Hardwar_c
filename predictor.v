module predictor(input wire request, result, clk, taken, output reg prediction);

    reg [1:0] state = 2'd3;
    parameter snt = 2'd0;
              wnt = 2'd1;
              wt  = 2'd2;
              st  = 2'd3;
              

    always @ (posedge clk) begin
        if (result) begin
            case (state)
                snt: 
                    if(taken)begin
                        state <= wnt;
                    end
                
                wnt:
                    if(taken)begin
                        state <= wt;
                    end
                    else begin
                        state <= snt;
                    end
                wt:
                    if(taken)begin
                        state <= st;
                    end
                    else begin
                        state <= wnt;
                    end
                st:
                    if (taken)begin
                    end
                    else begin
                        state <= wt;
                    end
            endcase
        end
        if (request) begin
            case (state)
                snt:
                    prediction = 0;
                wnt:
                    prediction = 0;
                wt:
                    prediction = 1;
                st:
                    prediction = 1;
            endcase
        end
    end

endmodule