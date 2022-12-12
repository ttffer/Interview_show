module maxpool
    #(
        parameter   INPUT_BIT   =   19,
                    INPUT_NODE  =   100,
                    OUTPUT_NODE =   25,
                    DATA_WIDTH  =   19
)
(
    input   clk,
    input   rst,
    input   [INPUT_BIT*INPUT_NODE-1:0] layer_in,
    input   valid,
    output  reg ready,
    output [INPUT_BIT*OUTPUT_NODE-1:0] layer_out
);
reg    signed [DATA_WIDTH-1:0]  in_buffer[0:INPUT_NODE-1];
genvar j;
generate
for(j=0;j<INPUT_NODE;j=j+1) 
    begin:init_block
        always@(posedge clk)
            begin
                if(rst)
                    begin
                        in_buffer[j]<=0;
                    end
                else
                    begin
                        in_buffer[j]<=layer_in[j*DATA_WIDTH+(DATA_WIDTH-1):j*DATA_WIDTH+0];
                    end
            end
    end
endgenerate
wire [DATA_WIDTH-1:0] com_0_1;
wire [DATA_WIDTH-1:0] com_10_11;
wire [DATA_WIDTH-1:0] com_out0_0_1_10_11;
assign com_0_1   =  (in_buffer[0]>in_buffer[1])    ?   in_buffer[0]:in_buffer[1];
assign com_10_11   =  (in_buffer[10]>in_buffer[11])    ?   in_buffer[10]:in_buffer[11];
assign com_out0_0_1_10_11   =   (com_0_1>com_10_11)    ?   com_0_1:com_10_11;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*0-1:0+DATA_WIDTH*0]    =com_out0_0_1_10_11;
wire [DATA_WIDTH-1:0] com_2_3;
wire [DATA_WIDTH-1:0] com_12_13;
wire [DATA_WIDTH-1:0] com_out1_2_3_12_13;
assign com_2_3   =  (in_buffer[2]>in_buffer[3])    ?   in_buffer[2]:in_buffer[3];
assign com_12_13   =  (in_buffer[12]>in_buffer[13])    ?   in_buffer[12]:in_buffer[13];
assign com_out1_2_3_12_13   =   (com_2_3>com_12_13)    ?   com_2_3:com_12_13;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*1-1:0+DATA_WIDTH*1]    =com_out1_2_3_12_13;
wire [DATA_WIDTH-1:0] com_4_5;
wire [DATA_WIDTH-1:0] com_14_15;
wire [DATA_WIDTH-1:0] com_out2_4_5_14_15;
assign com_4_5   =  (in_buffer[4]>in_buffer[5])    ?   in_buffer[4]:in_buffer[5];
assign com_14_15   =  (in_buffer[14]>in_buffer[15])    ?   in_buffer[14]:in_buffer[15];
assign com_out2_4_5_14_15   =   (com_4_5>com_14_15)    ?   com_4_5:com_14_15;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*2-1:0+DATA_WIDTH*2]    =com_out2_4_5_14_15;
wire [DATA_WIDTH-1:0] com_6_7;
wire [DATA_WIDTH-1:0] com_16_17;
wire [DATA_WIDTH-1:0] com_out3_6_7_16_17;
assign com_6_7   =  (in_buffer[6]>in_buffer[7])    ?   in_buffer[6]:in_buffer[7];
assign com_16_17   =  (in_buffer[16]>in_buffer[17])    ?   in_buffer[16]:in_buffer[17];
assign com_out3_6_7_16_17   =   (com_6_7>com_16_17)    ?   com_6_7:com_16_17;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*3-1:0+DATA_WIDTH*3]    =com_out3_6_7_16_17;
wire [DATA_WIDTH-1:0] com_8_9;
wire [DATA_WIDTH-1:0] com_18_19;
wire [DATA_WIDTH-1:0] com_out4_8_9_18_19;
assign com_8_9   =  (in_buffer[8]>in_buffer[9])    ?   in_buffer[8]:in_buffer[9];
assign com_18_19   =  (in_buffer[18]>in_buffer[19])    ?   in_buffer[18]:in_buffer[19];
assign com_out4_8_9_18_19   =   (com_8_9>com_18_19)    ?   com_8_9:com_18_19;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*4-1:0+DATA_WIDTH*4]    =com_out4_8_9_18_19;
wire [DATA_WIDTH-1:0] com_20_21;
wire [DATA_WIDTH-1:0] com_30_31;
wire [DATA_WIDTH-1:0] com_out5_20_21_30_31;
assign com_20_21   =  (in_buffer[20]>in_buffer[21])    ?   in_buffer[20]:in_buffer[21];
assign com_30_31   =  (in_buffer[30]>in_buffer[31])    ?   in_buffer[30]:in_buffer[31];
assign com_out5_20_21_30_31   =   (com_20_21>com_30_31)    ?   com_20_21:com_30_31;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*5-1:0+DATA_WIDTH*5]    =com_out5_20_21_30_31;
wire [DATA_WIDTH-1:0] com_22_23;
wire [DATA_WIDTH-1:0] com_32_33;
wire [DATA_WIDTH-1:0] com_out6_22_23_32_33;
assign com_22_23   =  (in_buffer[22]>in_buffer[23])    ?   in_buffer[22]:in_buffer[23];
assign com_32_33   =  (in_buffer[32]>in_buffer[33])    ?   in_buffer[32]:in_buffer[33];
assign com_out6_22_23_32_33   =   (com_22_23>com_32_33)    ?   com_22_23:com_32_33;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*6-1:0+DATA_WIDTH*6]    =com_out6_22_23_32_33;
wire [DATA_WIDTH-1:0] com_24_25;
wire [DATA_WIDTH-1:0] com_34_35;
wire [DATA_WIDTH-1:0] com_out7_24_25_34_35;
assign com_24_25   =  (in_buffer[24]>in_buffer[25])    ?   in_buffer[24]:in_buffer[25];
assign com_34_35   =  (in_buffer[34]>in_buffer[35])    ?   in_buffer[34]:in_buffer[35];
assign com_out7_24_25_34_35   =   (com_24_25>com_34_35)    ?   com_24_25:com_34_35;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*7-1:0+DATA_WIDTH*7]    =com_out7_24_25_34_35;
wire [DATA_WIDTH-1:0] com_26_27;
wire [DATA_WIDTH-1:0] com_36_37;
wire [DATA_WIDTH-1:0] com_out8_26_27_36_37;
assign com_26_27   =  (in_buffer[26]>in_buffer[27])    ?   in_buffer[26]:in_buffer[27];
assign com_36_37   =  (in_buffer[36]>in_buffer[37])    ?   in_buffer[36]:in_buffer[37];
assign com_out8_26_27_36_37   =   (com_26_27>com_36_37)    ?   com_26_27:com_36_37;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*8-1:0+DATA_WIDTH*8]    =com_out8_26_27_36_37;
wire [DATA_WIDTH-1:0] com_28_29;
wire [DATA_WIDTH-1:0] com_38_39;
wire [DATA_WIDTH-1:0] com_out9_28_29_38_39;
assign com_28_29   =  (in_buffer[28]>in_buffer[29])    ?   in_buffer[28]:in_buffer[29];
assign com_38_39   =  (in_buffer[38]>in_buffer[39])    ?   in_buffer[38]:in_buffer[39];
assign com_out9_28_29_38_39   =   (com_28_29>com_38_39)    ?   com_28_29:com_38_39;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*9-1:0+DATA_WIDTH*9]    =com_out9_28_29_38_39;
wire [DATA_WIDTH-1:0] com_40_41;
wire [DATA_WIDTH-1:0] com_50_51;
wire [DATA_WIDTH-1:0] com_out10_40_41_50_51;
assign com_40_41   =  (in_buffer[40]>in_buffer[41])    ?   in_buffer[40]:in_buffer[41];
assign com_50_51   =  (in_buffer[50]>in_buffer[51])    ?   in_buffer[50]:in_buffer[51];
assign com_out10_40_41_50_51   =   (com_40_41>com_50_51)    ?   com_40_41:com_50_51;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*10-1:0+DATA_WIDTH*10]    =com_out10_40_41_50_51;
wire [DATA_WIDTH-1:0] com_42_43;
wire [DATA_WIDTH-1:0] com_52_53;
wire [DATA_WIDTH-1:0] com_out11_42_43_52_53;
assign com_42_43   =  (in_buffer[42]>in_buffer[43])    ?   in_buffer[42]:in_buffer[43];
assign com_52_53   =  (in_buffer[52]>in_buffer[53])    ?   in_buffer[52]:in_buffer[53];
assign com_out11_42_43_52_53   =   (com_42_43>com_52_53)    ?   com_42_43:com_52_53;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*11-1:0+DATA_WIDTH*11]    =com_out11_42_43_52_53;
wire [DATA_WIDTH-1:0] com_44_45;
wire [DATA_WIDTH-1:0] com_54_55;
wire [DATA_WIDTH-1:0] com_out12_44_45_54_55;
assign com_44_45   =  (in_buffer[44]>in_buffer[45])    ?   in_buffer[44]:in_buffer[45];
assign com_54_55   =  (in_buffer[54]>in_buffer[55])    ?   in_buffer[54]:in_buffer[55];
assign com_out12_44_45_54_55   =   (com_44_45>com_54_55)    ?   com_44_45:com_54_55;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*12-1:0+DATA_WIDTH*12]    =com_out12_44_45_54_55;
wire [DATA_WIDTH-1:0] com_46_47;
wire [DATA_WIDTH-1:0] com_56_57;
wire [DATA_WIDTH-1:0] com_out13_46_47_56_57;
assign com_46_47   =  (in_buffer[46]>in_buffer[47])    ?   in_buffer[46]:in_buffer[47];
assign com_56_57   =  (in_buffer[56]>in_buffer[57])    ?   in_buffer[56]:in_buffer[57];
assign com_out13_46_47_56_57   =   (com_46_47>com_56_57)    ?   com_46_47:com_56_57;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*13-1:0+DATA_WIDTH*13]    =com_out13_46_47_56_57;
wire [DATA_WIDTH-1:0] com_48_49;
wire [DATA_WIDTH-1:0] com_58_59;
wire [DATA_WIDTH-1:0] com_out14_48_49_58_59;
assign com_48_49   =  (in_buffer[48]>in_buffer[49])    ?   in_buffer[48]:in_buffer[49];
assign com_58_59   =  (in_buffer[58]>in_buffer[59])    ?   in_buffer[58]:in_buffer[59];
assign com_out14_48_49_58_59   =   (com_48_49>com_58_59)    ?   com_48_49:com_58_59;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*14-1:0+DATA_WIDTH*14]    =com_out14_48_49_58_59;
wire [DATA_WIDTH-1:0] com_60_61;
wire [DATA_WIDTH-1:0] com_70_71;
wire [DATA_WIDTH-1:0] com_out15_60_61_70_71;
assign com_60_61   =  (in_buffer[60]>in_buffer[61])    ?   in_buffer[60]:in_buffer[61];
assign com_70_71   =  (in_buffer[70]>in_buffer[71])    ?   in_buffer[70]:in_buffer[71];
assign com_out15_60_61_70_71   =   (com_60_61>com_70_71)    ?   com_60_61:com_70_71;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*15-1:0+DATA_WIDTH*15]    =com_out15_60_61_70_71;
wire [DATA_WIDTH-1:0] com_62_63;
wire [DATA_WIDTH-1:0] com_72_73;
wire [DATA_WIDTH-1:0] com_out16_62_63_72_73;
assign com_62_63   =  (in_buffer[62]>in_buffer[63])    ?   in_buffer[62]:in_buffer[63];
assign com_72_73   =  (in_buffer[72]>in_buffer[73])    ?   in_buffer[72]:in_buffer[73];
assign com_out16_62_63_72_73   =   (com_62_63>com_72_73)    ?   com_62_63:com_72_73;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*16-1:0+DATA_WIDTH*16]    =com_out16_62_63_72_73;
wire [DATA_WIDTH-1:0] com_64_65;
wire [DATA_WIDTH-1:0] com_74_75;
wire [DATA_WIDTH-1:0] com_out17_64_65_74_75;
assign com_64_65   =  (in_buffer[64]>in_buffer[65])    ?   in_buffer[64]:in_buffer[65];
assign com_74_75   =  (in_buffer[74]>in_buffer[75])    ?   in_buffer[74]:in_buffer[75];
assign com_out17_64_65_74_75   =   (com_64_65>com_74_75)    ?   com_64_65:com_74_75;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*17-1:0+DATA_WIDTH*17]    =com_out17_64_65_74_75;
wire [DATA_WIDTH-1:0] com_66_67;
wire [DATA_WIDTH-1:0] com_76_77;
wire [DATA_WIDTH-1:0] com_out18_66_67_76_77;
assign com_66_67   =  (in_buffer[66]>in_buffer[67])    ?   in_buffer[66]:in_buffer[67];
assign com_76_77   =  (in_buffer[76]>in_buffer[77])    ?   in_buffer[76]:in_buffer[77];
assign com_out18_66_67_76_77   =   (com_66_67>com_76_77)    ?   com_66_67:com_76_77;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*18-1:0+DATA_WIDTH*18]    =com_out18_66_67_76_77;
wire [DATA_WIDTH-1:0] com_68_69;
wire [DATA_WIDTH-1:0] com_78_79;
wire [DATA_WIDTH-1:0] com_out19_68_69_78_79;
assign com_68_69   =  (in_buffer[68]>in_buffer[69])    ?   in_buffer[68]:in_buffer[69];
assign com_78_79   =  (in_buffer[78]>in_buffer[79])    ?   in_buffer[78]:in_buffer[79];
assign com_out19_68_69_78_79   =   (com_68_69>com_78_79)    ?   com_68_69:com_78_79;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*19-1:0+DATA_WIDTH*19]    =com_out19_68_69_78_79;
wire [DATA_WIDTH-1:0] com_80_81;
wire [DATA_WIDTH-1:0] com_90_91;
wire [DATA_WIDTH-1:0] com_out20_80_81_90_91;
assign com_80_81   =  (in_buffer[80]>in_buffer[81])    ?   in_buffer[80]:in_buffer[81];
assign com_90_91   =  (in_buffer[90]>in_buffer[91])    ?   in_buffer[90]:in_buffer[91];
assign com_out20_80_81_90_91   =   (com_80_81>com_90_91)    ?   com_80_81:com_90_91;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*20-1:0+DATA_WIDTH*20]    =com_out20_80_81_90_91;
wire [DATA_WIDTH-1:0] com_82_83;
wire [DATA_WIDTH-1:0] com_92_93;
wire [DATA_WIDTH-1:0] com_out21_82_83_92_93;
assign com_82_83   =  (in_buffer[82]>in_buffer[83])    ?   in_buffer[82]:in_buffer[83];
assign com_92_93   =  (in_buffer[92]>in_buffer[93])    ?   in_buffer[92]:in_buffer[93];
assign com_out21_82_83_92_93   =   (com_82_83>com_92_93)    ?   com_82_83:com_92_93;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*21-1:0+DATA_WIDTH*21]    =com_out21_82_83_92_93;
wire [DATA_WIDTH-1:0] com_84_85;
wire [DATA_WIDTH-1:0] com_94_95;
wire [DATA_WIDTH-1:0] com_out22_84_85_94_95;
assign com_84_85   =  (in_buffer[84]>in_buffer[85])    ?   in_buffer[84]:in_buffer[85];
assign com_94_95   =  (in_buffer[94]>in_buffer[95])    ?   in_buffer[94]:in_buffer[95];
assign com_out22_84_85_94_95   =   (com_84_85>com_94_95)    ?   com_84_85:com_94_95;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*22-1:0+DATA_WIDTH*22]    =com_out22_84_85_94_95;
wire [DATA_WIDTH-1:0] com_86_87;
wire [DATA_WIDTH-1:0] com_96_97;
wire [DATA_WIDTH-1:0] com_out23_86_87_96_97;
assign com_86_87   =  (in_buffer[86]>in_buffer[87])    ?   in_buffer[86]:in_buffer[87];
assign com_96_97   =  (in_buffer[96]>in_buffer[97])    ?   in_buffer[96]:in_buffer[97];
assign com_out23_86_87_96_97   =   (com_86_87>com_96_97)    ?   com_86_87:com_96_97;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*23-1:0+DATA_WIDTH*23]    =com_out23_86_87_96_97;
wire [DATA_WIDTH-1:0] com_88_89;
wire [DATA_WIDTH-1:0] com_98_99;
wire [DATA_WIDTH-1:0] com_out24_88_89_98_99;
assign com_88_89   =  (in_buffer[88]>in_buffer[89])    ?   in_buffer[88]:in_buffer[89];
assign com_98_99   =  (in_buffer[98]>in_buffer[99])    ?   in_buffer[98]:in_buffer[99];
assign com_out24_88_89_98_99   =   (com_88_89>com_98_99)    ?   com_88_89:com_98_99;
assign layer_out   [DATA_WIDTH+DATA_WIDTH*24-1:0+DATA_WIDTH*24]    =com_out24_88_89_98_99;
always@(posedge clk)
    begin
        if(rst)
            begin
                ready<=1'b0;
            end
        else
            begin
                ready<=valid;
            end
    end
endmodule
