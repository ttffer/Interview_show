module tcbcnn(
    input   clk,
    input   rst,
    output  ready,
    input   valid,
    input   [968-1:0]         input_img_source,
    output  [31:0]              predict_number
);
wire    ready_con_out;
wire    [19*100-1:0] layer_con_out;
        con_tcb DUT_con(
        .clk(clk),
        .rst(rst),
        .img(input_img_source),
        .layer_out(layer_con_out),
        .ready(ready_con_out),
        .valid(valid)
);
wire    ready_maxpool_out;
wire    [19*25-1:0] layer_maxpool_out;
        maxpool DUT_maxpool(
        .clk(clk),
        .rst(rst),
        .layer_in(layer_con_out),
        .layer_out(layer_maxpool_out),
        .ready(ready_maxpool_out),
        .valid(ready_con_out)
);
wire    ready_layer0_out;
wire    [27*64-1:0] layer_0_out;
        layer0_tcbcnn_121_25x64x10 DUT_layer0(
        .clk(clk),
        .rst(rst),
        .layer_in(layer_maxpool_out),
        .layer_out(layer_0_out),
        .ready(ready_layer0_out),
        .valid(ready_maxpool_out)
);
wire    ready_layer1_out;
wire    [36*10-1:0] layer_1_out;
        layer1_tcbcnn_121_25x64x10 DUT_layer1(
        .clk(clk),
        .rst(rst),
        .layer_in(layer_0_out),
        .layer_out(layer_1_out),
        .ready(ready_layer1_out),
        .valid(ready_layer0_out)
);
wire    ready_comparator_out;
wire    [31:0] comparator_predict;
        comparator DUT_comparator(
        .clk(clk),
        .rst(rst),
        .layer_out(layer_1_out),
        .predict(comparator_predict),
        .ready(ready_comparator_out),
        .valid(ready_layer1_out)
);
assign predict_number = comparator_predict;
assign ready = ready_comparator_out;
endmodule