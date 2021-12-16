//`timescale 1ns

module tb_mul ();

   wire CLK_i;
   wire RST_n_i;
   wire [31:0] DUT_OUT_i;
   wire VIN_i;
   wire [31:0] DATA_IN_i;
   wire VOUT_i;
   wire END_SIM_i;
   wire ERR_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker SM(.CLK(CLK_i),
	         .RST_n(RST_n_i),
		 .DATA_IN(DATA_IN_i),
		 .VIN(VIN_i),
		 .END_SIM(END_SIM_i));

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.VIN(VIN_i),
		.DUT_OUT(DUT_OUT_i),
                .ERR(ERR_i));

   FPmul UUT(.FP_A(DATA_IN_i),
	     .FP_B(DATA_IN_i),
	     .clk(CLK_i),
             .FP_Z(DUT_OUT_i));

endmodule
