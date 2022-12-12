module comparator
(
input [36*10-1:0] layer_out,
input rst,
input clk,
input valid,
output  reg ready,
output reg [31:0] predict
);
parameter DATA_WIDTH=36;
reg [DATA_WIDTH-1: 0] result [0:9];
wire [4+DATA_WIDTH-1:0] com_re01,com_re23,com_re45,com_re67,com_re89;
reg ready_temp;
always@(posedge clk)
    begin
        if(rst)
            begin
                ready<=1'b0;
                ready_temp<=1'b0;
            end
        else
            begin
                ready_temp<=valid;
                ready<=ready_temp;
            end
    end
 
assign com_re01=(result[0][DATA_WIDTH-1]^result[1][DATA_WIDTH-1]) ? 
                                                        ((result[0][DATA_WIDTH-1]==1'b0)   ?   {4'd0,result[0]}:{4'd1,result[1]}):
                                                        ((result[0]>result[1]) ? {4'd0,result[0]}:{4'd1,result[1]});
assign com_re23=(result[2][DATA_WIDTH-1]^result[3][DATA_WIDTH-1]) ? 
                                                        ((result[2][DATA_WIDTH-1]==1'b0)   ?   {4'd2,result[2]}:{4'd3,result[3]}):
                                                        ((result[2]>result[3]) ? {4'd2,result[2]}:{4'd3,result[3]});
assign com_re45=(result[4][DATA_WIDTH-1]^result[5][DATA_WIDTH-1]) ? 
                                                        ((result[4][DATA_WIDTH-1]==1'b0)   ?   {4'd4,result[4]}:{4'd5,result[5]}):
                                                        ((result[4]>result[5]) ? {4'd4,result[4]}:{4'd5,result[5]});

assign com_re67=(result[6][DATA_WIDTH-1]^result[7][DATA_WIDTH-1]) ? 
                                                        ((result[6][DATA_WIDTH-1]==1'b0)   ?   {4'd6,result[6]}:{4'd7,result[7]}):
                                                        ((result[6]>result[7]) ? {4'd6,result[6]}:{4'd7,result[7]});
assign com_re89=(result[8][DATA_WIDTH-1]^result[9][DATA_WIDTH-1]) ? 
                                                        ((result[8][DATA_WIDTH-1]==1'b0)   ?   {4'd8,result[8]}:{4'd9,result[9]}):
                                                        ((result[8]>result[9]) ? {4'd8,result[8]}:{4'd9,result[9]});
wire [4+DATA_WIDTH-1:0] com_re01_23,com_re45_67,com_re0123_4567,com_re01234567_89;
assign com_re01_23=(com_re01[DATA_WIDTH-1]^com_re23[DATA_WIDTH-1])   ?
                                                        ((com_re01[DATA_WIDTH-1]==1'b0)  ?   com_re01:com_re23):
                                                        ((com_re01[DATA_WIDTH-1:0]>com_re23[DATA_WIDTH-1:0]) ?   com_re01:com_re23);
assign com_re45_67=(com_re45[DATA_WIDTH-1]^com_re67[DATA_WIDTH-1])   ?
                                                        ((com_re45[DATA_WIDTH-1]==1'b0)  ?   com_re45:com_re67):
                                                        ((com_re45[DATA_WIDTH-1:0]>com_re67[DATA_WIDTH-1:0]) ?   com_re45:com_re67);
assign com_re0123_4567=(com_re01_23[DATA_WIDTH-1]^com_re45_67[DATA_WIDTH-1])   ?
                                                        ((com_re01_23[DATA_WIDTH-1]==1'b0)  ?   com_re01_23:com_re45_67):
                                                        ((com_re01_23[DATA_WIDTH-1:0]>com_re45_67[DATA_WIDTH-1:0]) ?   com_re01_23:com_re45_67);
assign com_re01234567_89=(com_re0123_4567[DATA_WIDTH-1]^com_re89[DATA_WIDTH-1])   ?
                                                        ((com_re0123_4567[DATA_WIDTH-1]==1'b0)  ?   com_re0123_4567:com_re89):
                                                        ((com_re0123_4567[DATA_WIDTH-1:0]>com_re89[DATA_WIDTH-1:0]) ?   com_re0123_4567:com_re89);
genvar i;
    generate
    for(i=0;i<10;i=i+1)
        begin:init_block
            always@(posedge clk )
            begin
                if(rst)
                    begin
                        result[i]<={DATA_WIDTH{1'b0}};
                end
                else
                    begin
                   result[i]<=layer_out[DATA_WIDTH-1+DATA_WIDTH*i:0+DATA_WIDTH*i];
                    end
            end//end always
        end//end for
    endgenerate
    
    always@(posedge clk)
        begin
            if(rst)
                begin
                    predict<=0;
                end
            else
                begin
                    predict <={{(32-4){1'b0}},com_re01234567_89[4+DATA_WIDTH-1:4+DATA_WIDTH-1-3]};
                end
        end
    
    
    endmodule
    
    