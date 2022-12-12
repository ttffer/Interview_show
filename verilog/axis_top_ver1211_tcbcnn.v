`timescale 1ns / 1ps


module axis_top_ver1211 #(
    parameter DATA_WIDTH=32,
    parameter NUMBER_OF_INPUT_WORDS =32
    
    )
   (
    input    axi_clk,
    input    axi_reset_n,
    //AXI4-S slave i/f
    input    s_axis_valid, 
    input [DATA_WIDTH-1:0] s_axis_data,
    output   s_axis_ready, 
    //AXI4-S master i/f
    output  m_axis_valid, 
//    output reg [NUMBER_OF_INPUT_WORDS*DATA_WIDTH-1:0] m_axis_data,
    output reg [DATA_WIDTH-1:0] m_axis_data,
    input    m_axis_ready, 

    input s_axis_last,
    output m_axis_last
    );

    //local para
    // Total number of input data.
    localparam bit_num  = clogb2(NUMBER_OF_INPUT_WORDS-1);
    // FIFO write enable
	wire fifo_wren;
    // FIFO write pointer
	reg [bit_num-1:0] write_pointer;



	// I/O Connections assignments
    reg [1:0] mst_exec_state;   // State variable
    parameter [1:0] IDLE                = 2'b00, // This is the initial/idle state 
                    WRITE_FIFO          = 2'b01, // In this state FIFO is written with the
                                                 // input stream data S_AXIS_TDATA 
                    EXECUTION_STATE     = 2'b10,  // calculating fifo addition
                    SEND_STATE          = 2'b11;  // sending msg to DMA

    wire out_reg_wren;
    wire out_reg_send_wren;
    //last signal
    wire axis_tlast;

    reg exe_done;
    reg send_done;
    reg writes_done;
    reg axis_tlast_delay;
    reg axis_tvalid_delay;

//I/O Connctions assignments
assign m_axis_last =axis_tlast_delay;
assign m_axis_valid=axis_tvalid_delay;
// assign m_axis_valid =valid;
// assign m_axis_last =valid;
assign s_axis_ready =   ((mst_exec_state == WRITE_FIFO) && (write_pointer <= NUMBER_OF_INPUT_WORDS-1));
//write enable out reg/ reg_send
assign out_reg_wren = (mst_exec_state==EXECUTION_STATE);
//next part/output needs to be ready to receive signal
assign out_reg_send_wren =((mst_exec_state==SEND_STATE) && m_axis_ready);
//Control srate machine implementation
always@(posedge axi_clk)begin 
    if(!axi_reset_n)begin 
        mst_exec_state <= IDLE;
    end
    else begin 
        case (mst_exec_state)
        IDLE: 
	          if (s_axis_valid)
	            begin
	              mst_exec_state <= WRITE_FIFO;
	            end
	          else
	            begin
	              mst_exec_state <= IDLE;
	            end
	      WRITE_FIFO: 
	        if (writes_done)
	          begin
	            mst_exec_state <= EXECUTION_STATE;
	          end
	        else
	          begin
	            mst_exec_state <= WRITE_FIFO;
	          end
          EXECUTION_STATE:
          begin
            if(exe_done)begin
                mst_exec_state <= SEND_STATE;
            end
            else begin
                mst_exec_state <= EXECUTION_STATE;
            end
           end
           SEND_STATE:
           begin 
            if(send_done)begin   
                mst_exec_state <= IDLE;
            end
            else begin
                mst_exec_state <= SEND_STATE;
            end
           end
	    endcase
    end
end

//pointer moving
    always@(posedge axi_clk)
    begin 
        case (mst_exec_state)
        IDLE: 
        begin
            begin
                write_pointer   <={bit_num{1'b0}};
	        end  
        end
        WRITE_FIFO:
            begin 
                    if (write_pointer   <= NUMBER_OF_INPUT_WORDS-1)
                begin
                    if (fifo_wren)
                    begin
                        write_pointer   <= write_pointer + 1;
                    end
                    if ((write_pointer == (NUMBER_OF_INPUT_WORDS-1))|| s_axis_last)
                        begin
                        write_pointer   <= {bit_num{1'b0}};
                        end
                end  
            end
        endcase
    end //end always
    
    
    always@(*) // done flag
        begin
            case (mst_exec_state)
                IDLE:
                begin
                    writes_done     =1'b0;
                    exe_done        =1'b0;
                    send_done       =1'b0;
                end
                WRITE_FIFO:
                begin
                    if ((write_pointer == (NUMBER_OF_INPUT_WORDS-1))|| s_axis_last)
                    begin
                        writes_done     =   1'b1;
                    end
                end
                EXECUTION_STATE:
                begin
                    if(ready_top)
                        begin
                            exe_done    =   1'b1;
                        end
                    else
                        begin
                            exe_done    =   1'b0;
                        end
                end
                SEND_STATE:
                begin
                    send_done   =   1'b1;
                end
            endcase
        end
        
    //INPUT BUFFER PHASE
    reg  [(DATA_WIDTH)-1:0] stream_data_fifo [0 : NUMBER_OF_INPUT_WORDS-1];
    // FIFO write enable generation
	assign fifo_wren = s_axis_valid && s_axis_ready;
    // Streaming input data is stored in FIFO
    always @( posedge axi_clk )
    begin
    if (fifo_wren)
        begin
        stream_data_fifo [write_pointer] <= s_axis_data;
        end  
    end  

wire rst;
assign rst = !axi_reset_n;
reg    [DATA_WIDTH*NUMBER_OF_INPUT_WORDS-1:0] img;

wire [DATA_WIDTH-1:0] top_tcb_number;
tcbcnn DUT_tcbcnn_top
(
    .clk(axi_clk),
    .rst(rst),
    .input_img_source(img),
    .valid(mst_exec_state==EXECUTION_STATE),
    .ready(ready_top),
    .predict_number(top_tcb_number)
);

    //EXECUTION PHASE
    integer j;
    always@(posedge axi_clk)begin 
        if (out_reg_wren)
        begin
            for(j=0;j<NUMBER_OF_INPUT_WORDS;j=j+1)
                img[DATA_WIDTH*j+:DATA_WIDTH] = stream_data_fifo[j];
        end
    end

    //SEND PHASE
    always@(posedge axi_clk)begin 
        if (out_reg_send_wren)begin                  
                m_axis_data <=   top_tcb_number;
        end
    end
//valid and last
reg valid;
always@(posedge axi_clk)
    begin
        if(mst_exec_state==EXECUTION_STATE)
        begin
            valid<=1'b0;
        end
        if(mst_exec_state==SEND_STATE)
        begin
             valid<=1'b1;
        end
    end
wire m_axis_valid_last;
assign m_axis_valid_last=((mst_exec_state == SEND_STATE) );

assign axis_tlast = m_axis_valid_last;
assign axis_valid = m_axis_valid_last;

always@(posedge axi_clk)begin
    if(!axi_reset_n)
    begin 
        axis_tlast_delay    <= 1'b0; 
        axis_tvalid_delay   <= 1'b0;
    end
    else 
    begin 
        axis_tlast_delay    <= axis_tlast;
        axis_tvalid_delay   <= axis_valid;
    end
end

    function integer clogb2 (input integer bit_depth);
	  begin
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)
	      bit_depth = bit_depth >> 1;
	  end
	endfunction
endmodule
