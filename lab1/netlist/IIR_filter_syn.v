/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Sun Nov 21 21:52:57 2021
/////////////////////////////////////////////////////////////


module IIR_filter ( CLK, RST_n, DIN, VIN, b0, b1, a1, DOUT, VOUT );
  input [11:0] DIN;
  input [11:0] b0;
  input [11:0] b1;
  input [11:0] a1;
  output [11:0] DOUT;
  input CLK, RST_n, VIN;
  output VOUT;
  wire   q1, n5, n6, n7, n8, n9, n10, n11, regX0_n21, regX0_n20, regX0_n19,
         regX0_n18, regX0_n17, regX0_n16, regX0_n15, regX0_n14, regX0_n12,
         regX0_n10, regX0_n9, regX0_n7, regX0_n5, regX0_n3, regX0_n2, regU_n4,
         regU_n3, regU_n2, regU_n1, regU_n24, regU_n23, regU_n22, regU_n21,
         regU_n20, regU_n19, regU_n18, regU_n17, regU_n16, regU_n12, regU_n11,
         regU_n10, regY_n34, regY_n33, regY_n32, regY_n31, regY_n30, regY_n29,
         regY_n28, regY_n27, regY_n26, regY_n25, regY_n24, regY_n12, regY_n11,
         regY_n10, regY_n9, regY_n8, regY_n3, regY_n2, regY_n1, mult_64_n290,
         mult_64_n289, mult_64_n288, mult_64_n287, mult_64_n286, mult_64_n285,
         mult_64_n284, mult_64_n283, mult_64_n282, mult_64_n281, mult_64_n280,
         mult_64_n279, mult_64_n278, mult_64_n277, mult_64_n276, mult_64_n275,
         mult_64_n274, mult_64_n273, mult_64_n272, mult_64_n271, mult_64_n270,
         mult_64_n269, mult_64_n268, mult_64_n267, mult_64_n266, mult_64_n265,
         mult_64_n264, mult_64_n263, mult_64_n262, mult_64_n261, mult_64_n260,
         mult_64_n259, mult_64_n258, mult_64_n257, mult_64_n256, mult_64_n255,
         mult_64_n254, mult_64_n253, mult_64_n252, mult_64_n251, mult_64_n250,
         mult_64_n249, mult_64_n248, mult_64_n247, mult_64_n246, mult_64_n245,
         mult_64_n244, mult_64_n243, mult_64_n242, mult_64_n241, mult_64_n240,
         mult_64_n239, mult_64_n238, mult_64_n218, mult_64_n206, mult_64_n205,
         mult_64_n204, mult_64_n203, mult_64_n201, mult_64_n200, mult_64_n199,
         mult_64_n198, mult_64_n197, mult_64_n196, mult_64_n194, mult_64_n193,
         mult_64_n192, mult_64_n182, mult_64_n181, mult_64_n180, mult_64_n179,
         mult_64_n178, mult_64_n177, mult_64_n176, mult_64_n175, mult_64_n174,
         mult_64_n173, mult_64_n172, mult_64_n171, mult_64_n170, mult_64_n169,
         mult_64_n168, mult_64_n167, mult_64_n166, mult_64_n165, mult_64_n164,
         mult_64_n163, mult_64_n162, mult_64_n161, mult_64_n160, mult_64_n159,
         mult_64_n158, mult_64_n157, mult_64_n156, mult_64_n155, mult_64_n153,
         mult_64_n152, mult_64_n151, mult_64_n150, mult_64_n149, mult_64_n148,
         mult_64_n147, mult_64_n146, mult_64_n145, mult_64_n144, mult_64_n143,
         mult_64_n142, mult_64_n141, mult_64_n140, mult_64_n139, mult_64_n138,
         mult_64_n137, mult_64_n136, mult_64_n135, mult_64_n134, mult_64_n133,
         mult_64_n132, mult_64_n131, mult_64_n130, mult_64_n129, mult_64_n128,
         mult_64_n127, mult_64_n126, mult_64_n125, mult_64_n124, mult_64_n122,
         mult_64_n121, mult_64_n120, mult_64_n119, mult_64_n118, mult_64_n116,
         mult_64_n115, mult_64_n114, mult_64_n113, mult_64_n111, mult_64_n109,
         mult_64_n108, mult_64_n106, mult_64_n105, mult_64_n103, mult_64_n102,
         mult_64_n101, mult_64_n100, mult_64_n99, mult_64_n98, mult_64_n97,
         mult_64_n96, mult_64_n95, mult_64_n94, mult_64_n93, mult_64_n92,
         mult_64_n91, mult_64_n90, mult_64_n89, mult_64_n88, mult_64_n87,
         mult_64_n86, mult_64_n85, mult_64_n84, mult_64_n83, mult_64_n82,
         mult_64_n81, mult_64_n80, mult_64_n79, mult_64_n78, mult_64_n77,
         mult_64_n76, mult_64_n75, mult_64_n74, mult_64_n73, mult_64_n72,
         mult_64_n71, mult_64_n70, mult_64_n69, mult_64_n68, mult_64_n67,
         mult_64_n66, mult_64_n65, mult_64_n64, mult_64_n63, mult_64_n62,
         mult_64_n59, mult_64_n55, mult_64_n54, mult_64_n53, mult_64_n52,
         mult_64_n47, mult_64_n46, mult_64_n45, mult_64_n44, mult_64_n39,
         mult_64_n38, mult_64_n37, mult_64_n36, mult_64_n35, mult_64_n34,
         mult_64_n32, mult_64_n31, mult_64_n30, mult_64_n29, mult_64_n28,
         mult_64_n27, mult_64_n26, mult_64_n25, mult_64_n24, mult_64_n23,
         mult_64_n22, mult_64_n21, mult_64_n20, mult_64_n19, mult_64_n18,
         mult_64_n17, mult_64_n15, mult_64_n13, mult_64_n12, mult_64_n11,
         mult_64_n10, mult_64_n6, mult_64_n4, mult_64_n3, mult_64_n2,
         mult_64_n1, add_56_n96, add_56_n95, add_56_n94, add_56_n93,
         add_56_n92, add_56_n91, add_56_n90, add_56_n89, add_56_n88,
         add_56_n87, add_56_n86, add_56_n85, add_56_n84, add_56_n83,
         add_56_n82, add_56_n80, add_56_n79, add_56_n50, add_56_n49,
         add_56_n45, add_56_n44, add_56_n41, add_56_n39, add_56_n38,
         add_56_n34, add_56_n33, add_56_n32, add_56_n31, add_56_n30,
         add_56_n29, add_56_n28, add_56_n27, add_56_n26, add_56_n25,
         add_56_n24, add_56_n23, add_56_n22, add_56_n19, add_56_n17,
         add_56_n16, add_56_n15, add_56_n14, add_56_n12, add_56_n10, add_56_n9,
         add_56_n8, add_56_n3, add_56_n1, mult_68_n247, mult_68_n246,
         mult_68_n245, mult_68_n244, mult_68_n243, mult_68_n242, mult_68_n241,
         mult_68_n240, mult_68_n220, mult_68_n219, mult_68_n218, mult_68_n217,
         mult_68_n216, mult_68_n215, mult_68_n214, mult_68_n212, mult_68_n211,
         mult_68_n210, mult_68_n209, mult_68_n208, mult_68_n207, mult_68_n206,
         mult_68_n204, mult_68_n203, mult_68_n202, mult_68_n200, mult_68_n199,
         mult_68_n198, mult_68_n196, mult_68_n195, mult_68_n194, mult_68_n192,
         mult_68_n184, mult_68_n183, mult_68_n182, mult_68_n181, mult_68_n180,
         mult_68_n179, mult_68_n178, mult_68_n177, mult_68_n176, mult_68_n175,
         mult_68_n174, mult_68_n173, mult_68_n172, mult_68_n171, mult_68_n170,
         mult_68_n169, mult_68_n168, mult_68_n167, mult_68_n166, mult_68_n165,
         mult_68_n164, mult_68_n163, mult_68_n162, mult_68_n161, mult_68_n160,
         mult_68_n159, mult_68_n158, mult_68_n157, mult_68_n155, mult_68_n154,
         mult_68_n153, mult_68_n152, mult_68_n151, mult_68_n150, mult_68_n149,
         mult_68_n148, mult_68_n147, mult_68_n146, mult_68_n145, mult_68_n144,
         mult_68_n143, mult_68_n142, mult_68_n141, mult_68_n140, mult_68_n139,
         mult_68_n138, mult_68_n137, mult_68_n136, mult_68_n135, mult_68_n134,
         mult_68_n133, mult_68_n132, mult_68_n131, mult_68_n130, mult_68_n129,
         mult_68_n128, mult_68_n127, mult_68_n125, mult_68_n124, mult_68_n123,
         mult_68_n122, mult_68_n121, mult_68_n120, mult_68_n119, mult_68_n118,
         mult_68_n117, mult_68_n116, mult_68_n115, mult_68_n113, mult_68_n111,
         mult_68_n110, mult_68_n108, mult_68_n107, mult_68_n106, mult_68_n104,
         mult_68_n103, mult_68_n102, mult_68_n101, mult_68_n100, mult_68_n99,
         mult_68_n98, mult_68_n97, mult_68_n96, mult_68_n95, mult_68_n94,
         mult_68_n93, mult_68_n92, mult_68_n91, mult_68_n90, mult_68_n89,
         mult_68_n88, mult_68_n87, mult_68_n86, mult_68_n85, mult_68_n84,
         mult_68_n83, mult_68_n82, mult_68_n81, mult_68_n80, mult_68_n79,
         mult_68_n78, mult_68_n77, mult_68_n76, mult_68_n75, mult_68_n74,
         mult_68_n73, mult_68_n72, mult_68_n71, mult_68_n70, mult_68_n69,
         mult_68_n68, mult_68_n67, mult_68_n66, mult_68_n65, mult_68_n64,
         mult_68_n63, mult_68_n62, mult_68_n61, mult_68_n60, mult_68_n51,
         mult_68_n50, mult_68_n49, mult_68_n48, mult_68_n47, mult_68_n46,
         mult_68_n45, mult_68_n44, mult_68_n39, mult_68_n38, mult_68_n37,
         mult_68_n36, mult_68_n35, mult_68_n34, mult_68_n33, mult_68_n32,
         mult_68_n31, mult_68_n30, mult_68_n29, mult_68_n28, mult_68_n27,
         mult_68_n26, mult_68_n25, mult_68_n24, mult_68_n23, mult_68_n22,
         mult_68_n21, mult_68_n20, mult_68_n19, mult_68_n18, mult_68_n17,
         mult_68_n15, mult_68_n13, mult_68_n12, mult_68_n11, mult_68_n10,
         mult_68_n8, mult_68_n7, mult_68_n6, mult_68_n5, mult_68_n4,
         mult_68_n3, mult_68_n2, mult_68_n1, add_72_n93, add_72_n92,
         add_72_n91, add_72_n90, add_72_n88, add_72_n87, add_72_n86,
         add_72_n85, add_72_n84, add_72_n83, add_72_n81, add_72_n80,
         add_72_n79, add_72_n78, add_72_n76, add_72_n42, add_72_n41,
         add_72_n40, add_72_n38, add_72_n36, add_72_n35, add_72_n34,
         add_72_n33, add_72_n32, add_72_n31, add_72_n30, add_72_n29,
         add_72_n28, add_72_n27, add_72_n26, add_72_n25, add_72_n24,
         add_72_n23, add_72_n22, add_72_n21, add_72_n20, add_72_n19,
         add_72_n18, add_72_n16, add_72_n15, add_72_n13, add_72_n11,
         add_72_n10, add_72_n9, add_72_n6, add_72_n5, add_72_n3, add_72_n2,
         add_72_n1, mult_66_n279, mult_66_n278, mult_66_n277, mult_66_n276,
         mult_66_n275, mult_66_n274, mult_66_n273, mult_66_n272, mult_66_n271,
         mult_66_n270, mult_66_n269, mult_66_n268, mult_66_n267, mult_66_n266,
         mult_66_n265, mult_66_n264, mult_66_n263, mult_66_n262, mult_66_n261,
         mult_66_n260, mult_66_n259, mult_66_n258, mult_66_n257, mult_66_n256,
         mult_66_n255, mult_66_n254, mult_66_n253, mult_66_n252, mult_66_n251,
         mult_66_n250, mult_66_n249, mult_66_n248, mult_66_n247, mult_66_n246,
         mult_66_n245, mult_66_n244, mult_66_n243, mult_66_n242, mult_66_n241,
         mult_66_n240, mult_66_n239, mult_66_n238, mult_66_n237, mult_66_n217,
         mult_66_n205, mult_66_n204, mult_66_n203, mult_66_n202, mult_66_n200,
         mult_66_n199, mult_66_n198, mult_66_n197, mult_66_n196, mult_66_n195,
         mult_66_n193, mult_66_n192, mult_66_n191, mult_66_n181, mult_66_n180,
         mult_66_n179, mult_66_n178, mult_66_n177, mult_66_n176, mult_66_n175,
         mult_66_n174, mult_66_n173, mult_66_n172, mult_66_n171, mult_66_n170,
         mult_66_n169, mult_66_n168, mult_66_n167, mult_66_n166, mult_66_n165,
         mult_66_n164, mult_66_n163, mult_66_n162, mult_66_n161, mult_66_n160,
         mult_66_n159, mult_66_n158, mult_66_n157, mult_66_n156, mult_66_n155,
         mult_66_n154, mult_66_n152, mult_66_n151, mult_66_n150, mult_66_n149,
         mult_66_n148, mult_66_n147, mult_66_n146, mult_66_n145, mult_66_n144,
         mult_66_n143, mult_66_n142, mult_66_n141, mult_66_n140, mult_66_n139,
         mult_66_n138, mult_66_n137, mult_66_n136, mult_66_n135, mult_66_n134,
         mult_66_n133, mult_66_n132, mult_66_n131, mult_66_n130, mult_66_n129,
         mult_66_n128, mult_66_n127, mult_66_n126, mult_66_n125, mult_66_n124,
         mult_66_n123, mult_66_n122, mult_66_n120, mult_66_n119, mult_66_n118,
         mult_66_n117, mult_66_n116, mult_66_n115, mult_66_n114, mult_66_n113,
         mult_66_n112, mult_66_n110, mult_66_n108, mult_66_n107, mult_66_n105,
         mult_66_n104, mult_66_n102, mult_66_n101, mult_66_n100, mult_66_n99,
         mult_66_n98, mult_66_n97, mult_66_n96, mult_66_n95, mult_66_n94,
         mult_66_n93, mult_66_n92, mult_66_n91, mult_66_n90, mult_66_n89,
         mult_66_n88, mult_66_n87, mult_66_n86, mult_66_n85, mult_66_n84,
         mult_66_n83, mult_66_n82, mult_66_n81, mult_66_n80, mult_66_n79,
         mult_66_n78, mult_66_n77, mult_66_n76, mult_66_n75, mult_66_n74,
         mult_66_n73, mult_66_n72, mult_66_n71, mult_66_n70, mult_66_n69,
         mult_66_n68, mult_66_n67, mult_66_n66, mult_66_n65, mult_66_n64,
         mult_66_n63, mult_66_n62, mult_66_n59, mult_66_n58, mult_66_n57,
         mult_66_n56, mult_66_n48, mult_66_n47, mult_66_n46, mult_66_n45,
         mult_66_n40, mult_66_n39, mult_66_n38, mult_66_n37, mult_66_n36,
         mult_66_n32, mult_66_n31, mult_66_n30, mult_66_n29, mult_66_n28,
         mult_66_n27, mult_66_n26, mult_66_n25, mult_66_n24, mult_66_n23,
         mult_66_n22, mult_66_n21, mult_66_n20, mult_66_n19, mult_66_n18,
         mult_66_n17, mult_66_n16, mult_66_n15, mult_66_n13, mult_66_n11,
         mult_66_n10, mult_66_n8, mult_66_n5, mult_66_n3, mult_66_n2,
         mult_66_n1;
  wire   [6:0] din_del;
  wire   [7:0] u;
  wire   [7:0] u_del_vec;
  wire   [12:6] mula1;
  wire   [12:6] mulb0;
  wire   [12:6] mulb1;
  wire   [7:0] y;
  assign DOUT[0] = 1'b0;
  assign DOUT[1] = 1'b0;
  assign DOUT[2] = 1'b0;
  assign DOUT[3] = 1'b0;

  CLKBUF_X1 U6 ( .A(u_del_vec[6]), .Z(n5) );
  CLKBUF_X1 U7 ( .A(u_del_vec[2]), .Z(n6) );
  CLKBUF_X1 U8 ( .A(u_del_vec[7]), .Z(n7) );
  CLKBUF_X1 U9 ( .A(u_del_vec[1]), .Z(n8) );
  CLKBUF_X1 U10 ( .A(u[4]), .Z(n9) );
  CLKBUF_X1 U11 ( .A(u[5]), .Z(n10) );
  CLKBUF_X1 U12 ( .A(u_del_vec[3]), .Z(n11) );
  MUX2_X1 regX0_U12 ( .A(din_del[5]), .B(DIN[10]), .S(VIN), .Z(regX0_n20) );
  MUX2_X1 regX0_U11 ( .A(din_del[3]), .B(DIN[8]), .S(VIN), .Z(regX0_n18) );
  MUX2_X1 regX0_U10 ( .A(din_del[0]), .B(DIN[5]), .S(VIN), .Z(regX0_n15) );
  NAND2_X1 regX0_U9 ( .A1(DIN[11]), .A2(VIN), .ZN(regX0_n7) );
  OAI21_X1 regX0_U8 ( .B1(regX0_n14), .B2(VIN), .A(regX0_n7), .ZN(regX0_n21)
         );
  NAND2_X1 regX0_U7 ( .A1(DIN[9]), .A2(VIN), .ZN(regX0_n5) );
  OAI21_X1 regX0_U6 ( .B1(regX0_n12), .B2(VIN), .A(regX0_n5), .ZN(regX0_n19)
         );
  NAND2_X1 regX0_U5 ( .A1(DIN[7]), .A2(VIN), .ZN(regX0_n3) );
  OAI21_X1 regX0_U4 ( .B1(regX0_n10), .B2(VIN), .A(regX0_n3), .ZN(regX0_n17)
         );
  NAND2_X1 regX0_U3 ( .A1(DIN[6]), .A2(VIN), .ZN(regX0_n2) );
  OAI21_X1 regX0_U2 ( .B1(regX0_n9), .B2(VIN), .A(regX0_n2), .ZN(regX0_n16) );
  DFFR_X1 regX0_Q_reg_0_ ( .D(regX0_n15), .CK(CLK), .RN(RST_n), .Q(din_del[0])
         );
  DFFR_X1 regX0_Q_reg_1_ ( .D(regX0_n16), .CK(CLK), .RN(RST_n), .Q(din_del[1]), 
        .QN(regX0_n9) );
  DFFR_X1 regX0_Q_reg_2_ ( .D(regX0_n17), .CK(CLK), .RN(RST_n), .Q(din_del[2]), 
        .QN(regX0_n10) );
  DFFR_X1 regX0_Q_reg_3_ ( .D(regX0_n18), .CK(CLK), .RN(RST_n), .Q(din_del[3])
         );
  DFFR_X1 regX0_Q_reg_4_ ( .D(regX0_n19), .CK(CLK), .RN(RST_n), .Q(din_del[4]), 
        .QN(regX0_n12) );
  DFFR_X1 regX0_Q_reg_5_ ( .D(regX0_n20), .CK(CLK), .RN(RST_n), .Q(din_del[5])
         );
  DFFR_X1 regX0_Q_reg_6_ ( .D(regX0_n21), .CK(CLK), .RN(RST_n), .Q(din_del[6]), 
        .QN(regX0_n14) );
  MUX2_X1 regU_U13 ( .A(regU_n3), .B(u[7]), .S(q1), .Z(regU_n24) );
  MUX2_X1 regU_U12 ( .A(u_del_vec[6]), .B(u[6]), .S(q1), .Z(regU_n23) );
  MUX2_X1 regU_U11 ( .A(u_del_vec[5]), .B(n10), .S(q1), .Z(regU_n22) );
  MUX2_X1 regU_U10 ( .A(u_del_vec[4]), .B(n9), .S(q1), .Z(regU_n21) );
  MUX2_X1 regU_U9 ( .A(regU_n2), .B(u[3]), .S(q1), .Z(regU_n20) );
  MUX2_X1 regU_U8 ( .A(regU_n4), .B(u[2]), .S(q1), .Z(regU_n19) );
  MUX2_X1 regU_U7 ( .A(regU_n1), .B(u[1]), .S(q1), .Z(regU_n18) );
  MUX2_X1 regU_U6 ( .A(u_del_vec[0]), .B(u[0]), .S(q1), .Z(regU_n17) );
  INV_X2 regU_U5 ( .A(regU_n12), .ZN(u_del_vec[3]) );
  INV_X2 regU_U4 ( .A(regU_n10), .ZN(u_del_vec[1]) );
  INV_X1 regU_U3 ( .A(regU_n16), .ZN(u_del_vec[7]) );
  INV_X1 regU_U2 ( .A(regU_n11), .ZN(u_del_vec[2]) );
  DFFR_X1 regU_Q_reg_7_ ( .D(regU_n24), .CK(CLK), .RN(RST_n), .Q(regU_n3), 
        .QN(regU_n16) );
  DFFR_X1 regU_Q_reg_1_ ( .D(regU_n18), .CK(CLK), .RN(RST_n), .Q(regU_n1), 
        .QN(regU_n10) );
  DFFR_X1 regU_Q_reg_2_ ( .D(regU_n19), .CK(CLK), .RN(RST_n), .Q(regU_n4), 
        .QN(regU_n11) );
  DFFR_X1 regU_Q_reg_3_ ( .D(regU_n20), .CK(CLK), .RN(RST_n), .Q(regU_n2), 
        .QN(regU_n12) );
  DFFR_X1 regU_Q_reg_6_ ( .D(regU_n23), .CK(CLK), .RN(RST_n), .Q(u_del_vec[6])
         );
  DFFR_X1 regU_Q_reg_0_ ( .D(regU_n17), .CK(CLK), .RN(RST_n), .Q(u_del_vec[0])
         );
  DFFR_X1 regU_Q_reg_4_ ( .D(regU_n21), .CK(CLK), .RN(RST_n), .Q(u_del_vec[4])
         );
  DFFR_X1 regU_Q_reg_5_ ( .D(regU_n22), .CK(CLK), .RN(RST_n), .Q(u_del_vec[5])
         );
  NAND2_X1 regY_U16 ( .A1(y[7]), .A2(q1), .ZN(regY_n11) );
  NAND2_X1 regY_U15 ( .A1(y[6]), .A2(q1), .ZN(regY_n10) );
  NAND2_X1 regY_U14 ( .A1(y[5]), .A2(q1), .ZN(regY_n9) );
  OAI21_X1 regY_U13 ( .B1(regY_n34), .B2(q1), .A(regY_n8), .ZN(regY_n26) );
  NAND2_X1 regY_U12 ( .A1(y[4]), .A2(q1), .ZN(regY_n8) );
  MUX2_X1 regY_U11 ( .A(DOUT[7]), .B(y[3]), .S(q1), .Z(regY_n27) );
  MUX2_X1 regY_U10 ( .A(DOUT[6]), .B(y[2]), .S(q1), .Z(regY_n28) );
  MUX2_X1 regY_U9 ( .A(DOUT[5]), .B(y[1]), .S(q1), .Z(regY_n29) );
  MUX2_X1 regY_U8 ( .A(DOUT[4]), .B(y[0]), .S(q1), .Z(regY_n30) );
  NAND2_X1 regY_U7 ( .A1(regY_n10), .A2(regY_n3), .ZN(regY_n24) );
  OR2_X1 regY_U6 ( .A1(regY_n32), .A2(q1), .ZN(regY_n3) );
  NAND2_X1 regY_U5 ( .A1(regY_n11), .A2(regY_n2), .ZN(regY_n12) );
  OR2_X1 regY_U4 ( .A1(regY_n31), .A2(q1), .ZN(regY_n2) );
  NAND2_X1 regY_U3 ( .A1(regY_n9), .A2(regY_n1), .ZN(regY_n25) );
  OR2_X1 regY_U2 ( .A1(regY_n33), .A2(q1), .ZN(regY_n1) );
  DFFR_X2 regY_Q_reg_5_ ( .D(regY_n25), .CK(CLK), .RN(RST_n), .Q(DOUT[9]), 
        .QN(regY_n33) );
  DFFR_X2 regY_Q_reg_6_ ( .D(regY_n24), .CK(CLK), .RN(RST_n), .Q(DOUT[10]), 
        .QN(regY_n32) );
  DFFR_X1 regY_Q_reg_0_ ( .D(regY_n30), .CK(CLK), .RN(RST_n), .Q(DOUT[4]) );
  DFFR_X1 regY_Q_reg_1_ ( .D(regY_n29), .CK(CLK), .RN(RST_n), .Q(DOUT[5]) );
  DFFR_X1 regY_Q_reg_2_ ( .D(regY_n28), .CK(CLK), .RN(RST_n), .Q(DOUT[6]) );
  DFFR_X1 regY_Q_reg_3_ ( .D(regY_n27), .CK(CLK), .RN(RST_n), .Q(DOUT[7]) );
  DFFR_X1 regY_Q_reg_4_ ( .D(regY_n26), .CK(CLK), .RN(RST_n), .Q(DOUT[8]), 
        .QN(regY_n34) );
  DFFR_X1 regY_Q_reg_7_ ( .D(regY_n12), .CK(CLK), .RN(RST_n), .Q(DOUT[11]), 
        .QN(regY_n31) );
  DFFR_X1 ff1_Q_reg ( .D(VIN), .CK(CLK), .RN(RST_n), .Q(q1) );
  DFFR_X1 ff2_Q_reg ( .D(q1), .CK(CLK), .RN(RST_n), .Q(VOUT) );
  XNOR2_X1 mult_64_U408 ( .A(u_del_vec[1]), .B(a1[8]), .ZN(mult_64_n171) );
  XNOR2_X1 mult_64_U407 ( .A(mult_64_n274), .B(a1[6]), .ZN(mult_64_n180) );
  XNOR2_X1 mult_64_U406 ( .A(u_del_vec[1]), .B(a1[11]), .ZN(mult_64_n153) );
  XNOR2_X1 mult_64_U405 ( .A(u_del_vec[1]), .B(a1[10]), .ZN(mult_64_n162) );
  OAI21_X1 mult_64_U404 ( .B1(mult_64_n268), .B2(mult_64_n12), .A(mult_64_n13), 
        .ZN(mult_64_n11) );
  OAI21_X1 mult_64_U403 ( .B1(mult_64_n268), .B2(mult_64_n19), .A(mult_64_n20), 
        .ZN(mult_64_n18) );
  OAI21_X1 mult_64_U402 ( .B1(mult_64_n1), .B2(mult_64_n26), .A(mult_64_n27), 
        .ZN(mult_64_n25) );
  XNOR2_X1 mult_64_U401 ( .A(u_del_vec[3]), .B(a1[6]), .ZN(mult_64_n178) );
  XNOR2_X1 mult_64_U400 ( .A(u_del_vec[3]), .B(a1[8]), .ZN(mult_64_n169) );
  XNOR2_X1 mult_64_U399 ( .A(u_del_vec[3]), .B(a1[10]), .ZN(mult_64_n160) );
  XNOR2_X1 mult_64_U398 ( .A(u_del_vec[3]), .B(a1[11]), .ZN(mult_64_n151) );
  NOR2_X1 mult_64_U397 ( .A1(mult_64_n100), .A2(mult_64_n101), .ZN(mult_64_n45) );
  XNOR2_X1 mult_64_U396 ( .A(mult_64_n275), .B(a1[6]), .ZN(mult_64_n179) );
  XNOR2_X1 mult_64_U395 ( .A(u_del_vec[2]), .B(a1[8]), .ZN(mult_64_n170) );
  XNOR2_X1 mult_64_U394 ( .A(mult_64_n275), .B(a1[11]), .ZN(mult_64_n152) );
  XNOR2_X1 mult_64_U393 ( .A(u_del_vec[2]), .B(a1[10]), .ZN(mult_64_n161) );
  NAND2_X1 mult_64_U392 ( .A1(mult_64_n146), .A2(mult_64_n139), .ZN(
        mult_64_n54) );
  XNOR2_X1 mult_64_U391 ( .A(u_del_vec[7]), .B(a1[6]), .ZN(mult_64_n174) );
  XNOR2_X1 mult_64_U390 ( .A(u_del_vec[7]), .B(a1[8]), .ZN(mult_64_n165) );
  XNOR2_X1 mult_64_U389 ( .A(mult_64_n242), .B(a1[10]), .ZN(mult_64_n156) );
  XNOR2_X1 mult_64_U388 ( .A(u_del_vec[6]), .B(a1[8]), .ZN(mult_64_n166) );
  XNOR2_X1 mult_64_U387 ( .A(mult_64_n290), .B(a1[10]), .ZN(mult_64_n157) );
  XNOR2_X1 mult_64_U386 ( .A(mult_64_n290), .B(a1[6]), .ZN(mult_64_n175) );
  XNOR2_X1 mult_64_U385 ( .A(mult_64_n290), .B(a1[11]), .ZN(mult_64_n148) );
  OAI22_X1 mult_64_U384 ( .A1(mult_64_n171), .A2(mult_64_n201), .B1(
        mult_64_n197), .B2(mult_64_n172), .ZN(mult_64_n138) );
  OAI22_X1 mult_64_U383 ( .A1(mult_64_n170), .A2(mult_64_n201), .B1(
        mult_64_n281), .B2(mult_64_n197), .ZN(mult_64_n137) );
  OAI22_X1 mult_64_U382 ( .A1(mult_64_n162), .A2(mult_64_n200), .B1(
        mult_64_n196), .B2(mult_64_n163), .ZN(mult_64_n129) );
  OAI22_X1 mult_64_U381 ( .A1(mult_64_n247), .A2(mult_64_n200), .B1(
        mult_64_n289), .B2(mult_64_n196), .ZN(mult_64_n128) );
  OAI21_X1 mult_64_U380 ( .B1(mult_64_n30), .B2(mult_64_n34), .A(mult_64_n31), 
        .ZN(mult_64_n29) );
  OAI22_X1 mult_64_U379 ( .A1(mult_64_n178), .A2(mult_64_n198), .B1(
        mult_64_n177), .B2(mult_64_n218), .ZN(mult_64_n144) );
  OAI22_X1 mult_64_U378 ( .A1(mult_64_n179), .A2(mult_64_n198), .B1(
        mult_64_n178), .B2(mult_64_n218), .ZN(mult_64_n145) );
  AOI21_X1 mult_64_U377 ( .B1(mult_64_n22), .B2(mult_64_n286), .A(mult_64_n15), 
        .ZN(mult_64_n13) );
  OAI22_X1 mult_64_U376 ( .A1(mult_64_n166), .A2(mult_64_n201), .B1(
        mult_64_n197), .B2(mult_64_n167), .ZN(mult_64_n133) );
  OAI22_X1 mult_64_U375 ( .A1(mult_64_n165), .A2(mult_64_n201), .B1(
        mult_64_n166), .B2(mult_64_n197), .ZN(mult_64_n132) );
  NOR2_X1 mult_64_U374 ( .A1(mult_64_n92), .A2(mult_64_n94), .ZN(mult_64_n37)
         );
  NAND2_X1 mult_64_U373 ( .A1(mult_64_n92), .A2(mult_64_n94), .ZN(mult_64_n38)
         );
  OAI21_X1 mult_64_U372 ( .B1(mult_64_n39), .B2(mult_64_n37), .A(mult_64_n38), 
        .ZN(mult_64_n36) );
  OAI22_X1 mult_64_U371 ( .A1(mult_64_n161), .A2(mult_64_n196), .B1(
        mult_64_n160), .B2(mult_64_n200), .ZN(mult_64_n127) );
  OAI22_X1 mult_64_U370 ( .A1(mult_64_n196), .A2(mult_64_n160), .B1(
        mult_64_n200), .B2(mult_64_n159), .ZN(mult_64_n126) );
  NOR2_X1 mult_64_U369 ( .A1(mult_64_n280), .A2(mult_64_n282), .ZN(mult_64_n28) );
  OAI21_X1 mult_64_U368 ( .B1(mult_64_n35), .B2(mult_64_n282), .A(mult_64_n34), 
        .ZN(mult_64_n32) );
  INV_X1 mult_64_U367 ( .A(mult_64_n36), .ZN(mult_64_n35) );
  INV_X1 mult_64_U366 ( .A(mult_64_n111), .ZN(mult_64_n140) );
  OAI21_X1 mult_64_U365 ( .B1(mult_64_n45), .B2(mult_64_n47), .A(mult_64_n46), 
        .ZN(mult_64_n44) );
  OAI21_X1 mult_64_U364 ( .B1(mult_64_n23), .B2(mult_64_n27), .A(mult_64_n24), 
        .ZN(mult_64_n22) );
  XNOR2_X1 mult_64_U363 ( .A(mult_64_n25), .B(mult_64_n4), .ZN(mula1[10]) );
  OAI22_X1 mult_64_U362 ( .A1(mult_64_n197), .A2(mult_64_n170), .B1(
        mult_64_n201), .B2(mult_64_n169), .ZN(mult_64_n136) );
  OAI22_X1 mult_64_U361 ( .A1(mult_64_n246), .A2(mult_64_n197), .B1(
        mult_64_n201), .B2(mult_64_n168), .ZN(mult_64_n135) );
  NOR2_X1 mult_64_U360 ( .A1(mult_64_n26), .A2(mult_64_n23), .ZN(mult_64_n21)
         );
  NAND2_X1 mult_64_U359 ( .A1(mult_64_n21), .A2(mult_64_n286), .ZN(mult_64_n12) );
  INV_X1 mult_64_U358 ( .A(mult_64_n21), .ZN(mult_64_n19) );
  NAND2_X1 mult_64_U357 ( .A1(mult_64_n86), .A2(mult_64_n91), .ZN(mult_64_n34)
         );
  OAI22_X1 mult_64_U356 ( .A1(mult_64_n288), .A2(mult_64_n198), .B1(
        mult_64_n174), .B2(mult_64_n218), .ZN(mult_64_n111) );
  AOI21_X1 mult_64_U355 ( .B1(mult_64_n255), .B2(mult_64_n52), .A(mult_64_n257), .ZN(mult_64_n47) );
  NAND2_X1 mult_64_U354 ( .A1(mult_64_n100), .A2(mult_64_n101), .ZN(
        mult_64_n46) );
  INV_X1 mult_64_U353 ( .A(mult_64_n37), .ZN(mult_64_n62) );
  NAND2_X1 mult_64_U352 ( .A1(mult_64_n256), .A2(mult_64_n243), .ZN(
        mult_64_n31) );
  NAND2_X1 mult_64_U351 ( .A1(mult_64_n70), .A2(mult_64_n73), .ZN(mult_64_n24)
         );
  NAND2_X1 mult_64_U350 ( .A1(mult_64_n74), .A2(mult_64_n79), .ZN(mult_64_n27)
         );
  XNOR2_X1 mult_64_U349 ( .A(mult_64_n18), .B(mult_64_n3), .ZN(mula1[11]) );
  XNOR2_X1 mult_64_U348 ( .A(mult_64_n274), .B(a1[10]), .ZN(mult_64_n289) );
  XNOR2_X1 mult_64_U347 ( .A(mult_64_n11), .B(mult_64_n2), .ZN(mula1[12]) );
  XNOR2_X1 mult_64_U346 ( .A(u_del_vec[7]), .B(a1[6]), .ZN(mult_64_n288) );
  INV_X1 mult_64_U345 ( .A(a1[11]), .ZN(mult_64_n203) );
  INV_X1 mult_64_U344 ( .A(a1[8]), .ZN(mult_64_n205) );
  INV_X1 mult_64_U343 ( .A(a1[10]), .ZN(mult_64_n204) );
  INV_X1 mult_64_U342 ( .A(a1[6]), .ZN(mult_64_n206) );
  INV_X1 mult_64_U341 ( .A(mult_64_n201), .ZN(mult_64_n109) );
  AND2_X1 mult_64_U340 ( .A1(u_del_vec[0]), .A2(mult_64_n109), .ZN(
        mult_64_n139) );
  OR2_X1 mult_64_U339 ( .A1(u_del_vec[0]), .A2(mult_64_n204), .ZN(mult_64_n164) );
  OAI22_X1 mult_64_U338 ( .A1(mult_64_n196), .A2(mult_64_n204), .B1(
        mult_64_n164), .B2(mult_64_n200), .ZN(mult_64_n114) );
  OAI22_X1 mult_64_U337 ( .A1(mult_64_n198), .A2(mult_64_n177), .B1(
        mult_64_n176), .B2(mult_64_n218), .ZN(mult_64_n143) );
  XNOR2_X1 mult_64_U336 ( .A(a1[8]), .B(u_del_vec[0]), .ZN(mult_64_n172) );
  XOR2_X1 mult_64_U335 ( .A(a1[5]), .B(a1[6]), .Z(mult_64_n194) );
  NAND2_X1 mult_64_U334 ( .A1(mult_64_n194), .A2(mult_64_n218), .ZN(
        mult_64_n198) );
  XOR2_X1 mult_64_U333 ( .A(a1[7]), .B(a1[8]), .Z(mult_64_n193) );
  NAND2_X1 mult_64_U332 ( .A1(mult_64_n193), .A2(mult_64_n201), .ZN(
        mult_64_n197) );
  XNOR2_X1 mult_64_U331 ( .A(a1[6]), .B(u_del_vec[0]), .ZN(mult_64_n181) );
  INV_X1 mult_64_U330 ( .A(a1[5]), .ZN(mult_64_n218) );
  XNOR2_X1 mult_64_U329 ( .A(a1[11]), .B(u_del_vec[5]), .ZN(mult_64_n149) );
  NOR2_X1 mult_64_U328 ( .A1(mult_64_n199), .A2(mult_64_n149), .ZN(mult_64_n67) );
  OR2_X1 mult_64_U327 ( .A1(u_del_vec[0]), .A2(mult_64_n203), .ZN(mult_64_n155) );
  OAI22_X1 mult_64_U326 ( .A1(mult_64_n197), .A2(mult_64_n168), .B1(
        mult_64_n201), .B2(mult_64_n167), .ZN(mult_64_n134) );
  NOR2_X1 mult_64_U325 ( .A1(mult_64_n155), .A2(mult_64_n199), .ZN(
        mult_64_n113) );
  XOR2_X1 mult_64_U324 ( .A(a1[9]), .B(a1[10]), .Z(mult_64_n192) );
  NAND2_X1 mult_64_U323 ( .A1(mult_64_n192), .A2(mult_64_n200), .ZN(
        mult_64_n196) );
  XNOR2_X1 mult_64_U322 ( .A(a1[8]), .B(u_del_vec[5]), .ZN(mult_64_n167) );
  XNOR2_X1 mult_64_U321 ( .A(a1[6]), .B(u_del_vec[4]), .ZN(mult_64_n177) );
  XNOR2_X1 mult_64_U320 ( .A(a1[8]), .B(u_del_vec[4]), .ZN(mult_64_n168) );
  XNOR2_X1 mult_64_U319 ( .A(a1[10]), .B(u_del_vec[4]), .ZN(mult_64_n159) );
  XNOR2_X1 mult_64_U318 ( .A(a1[6]), .B(u_del_vec[5]), .ZN(mult_64_n176) );
  XNOR2_X1 mult_64_U317 ( .A(a1[10]), .B(u_del_vec[5]), .ZN(mult_64_n158) );
  OR2_X1 mult_64_U316 ( .A1(u_del_vec[0]), .A2(mult_64_n206), .ZN(mult_64_n182) );
  OAI22_X1 mult_64_U315 ( .A1(mult_64_n180), .A2(mult_64_n218), .B1(
        mult_64_n198), .B2(mult_64_n181), .ZN(mult_64_n147) );
  OAI22_X1 mult_64_U314 ( .A1(mult_64_n198), .A2(mult_64_n206), .B1(
        mult_64_n182), .B2(mult_64_n218), .ZN(mult_64_n116) );
  NAND2_X1 mult_64_U313 ( .A1(mult_64_n147), .A2(mult_64_n116), .ZN(
        mult_64_n55) );
  XNOR2_X1 mult_64_U312 ( .A(a1[10]), .B(u_del_vec[0]), .ZN(mult_64_n163) );
  XNOR2_X1 mult_64_U311 ( .A(a1[11]), .B(u_del_vec[4]), .ZN(mult_64_n150) );
  OAI22_X1 mult_64_U310 ( .A1(mult_64_n157), .A2(mult_64_n200), .B1(
        mult_64_n196), .B2(mult_64_n158), .ZN(mult_64_n125) );
  NOR2_X1 mult_64_U309 ( .A1(mult_64_n199), .A2(mult_64_n150), .ZN(
        mult_64_n118) );
  NOR2_X1 mult_64_U308 ( .A1(mult_64_n153), .A2(mult_64_n199), .ZN(
        mult_64_n121) );
  AND2_X1 mult_64_U307 ( .A1(u_del_vec[0]), .A2(mult_64_n106), .ZN(
        mult_64_n130) );
  OAI22_X1 mult_64_U306 ( .A1(mult_64_n175), .A2(mult_64_n218), .B1(
        mult_64_n198), .B2(mult_64_n176), .ZN(mult_64_n142) );
  OAI22_X1 mult_64_U305 ( .A1(mult_64_n250), .A2(mult_64_n218), .B1(
        mult_64_n175), .B2(mult_64_n198), .ZN(mult_64_n141) );
  OR2_X1 mult_64_U304 ( .A1(u_del_vec[0]), .A2(mult_64_n205), .ZN(mult_64_n173) );
  OAI22_X1 mult_64_U303 ( .A1(mult_64_n197), .A2(mult_64_n205), .B1(
        mult_64_n173), .B2(mult_64_n201), .ZN(mult_64_n115) );
  INV_X1 mult_64_U302 ( .A(mult_64_n199), .ZN(mult_64_n103) );
  AND2_X1 mult_64_U301 ( .A1(u_del_vec[0]), .A2(mult_64_n103), .ZN(
        mult_64_n122) );
  INV_X1 mult_64_U300 ( .A(mult_64_n200), .ZN(mult_64_n106) );
  OAI22_X1 mult_64_U299 ( .A1(mult_64_n196), .A2(mult_64_n159), .B1(
        mult_64_n200), .B2(mult_64_n158), .ZN(mult_64_n77) );
  NOR2_X1 mult_64_U298 ( .A1(mult_64_n151), .A2(mult_64_n199), .ZN(
        mult_64_n119) );
  INV_X1 mult_64_U297 ( .A(mult_64_n77), .ZN(mult_64_n78) );
  NOR2_X1 mult_64_U296 ( .A1(mult_64_n152), .A2(mult_64_n199), .ZN(
        mult_64_n120) );
  OAI22_X1 mult_64_U295 ( .A1(mult_64_n165), .A2(mult_64_n197), .B1(
        mult_64_n165), .B2(mult_64_n201), .ZN(mult_64_n108) );
  INV_X1 mult_64_U294 ( .A(mult_64_n108), .ZN(mult_64_n131) );
  OR2_X1 mult_64_U293 ( .A1(mult_64_n126), .A2(mult_64_n89), .ZN(mult_64_n83)
         );
  XNOR2_X1 mult_64_U292 ( .A(mult_64_n126), .B(mult_64_n89), .ZN(mult_64_n84)
         );
  OAI21_X1 mult_64_U291 ( .B1(mult_64_n53), .B2(mult_64_n55), .A(mult_64_n54), 
        .ZN(mult_64_n52) );
  NOR2_X1 mult_64_U290 ( .A1(mult_64_n146), .A2(mult_64_n139), .ZN(mult_64_n53) );
  OAI22_X1 mult_64_U289 ( .A1(mult_64_n179), .A2(mult_64_n218), .B1(
        mult_64_n180), .B2(mult_64_n198), .ZN(mult_64_n146) );
  OAI22_X1 mult_64_U288 ( .A1(mult_64_n156), .A2(mult_64_n200), .B1(
        mult_64_n244), .B2(mult_64_n196), .ZN(mult_64_n124) );
  INV_X1 mult_64_U287 ( .A(mult_64_n67), .ZN(mult_64_n68) );
  OAI22_X1 mult_64_U286 ( .A1(mult_64_n156), .A2(mult_64_n196), .B1(
        mult_64_n156), .B2(mult_64_n200), .ZN(mult_64_n105) );
  OR2_X1 mult_64_U285 ( .A1(mult_64_n65), .A2(mult_64_n64), .ZN(mult_64_n287)
         );
  NAND2_X1 mult_64_U284 ( .A1(mult_64_n66), .A2(mult_64_n69), .ZN(mult_64_n17)
         );
  NAND2_X1 mult_64_U283 ( .A1(mult_64_n65), .A2(mult_64_n64), .ZN(mult_64_n10)
         );
  NOR2_X1 mult_64_U282 ( .A1(mult_64_n79), .A2(mult_64_n74), .ZN(mult_64_n26)
         );
  NAND2_X1 mult_64_U281 ( .A1(mult_64_n279), .A2(mult_64_n245), .ZN(mult_64_n6) );
  XNOR2_X1 mult_64_U280 ( .A(mult_64_n32), .B(mult_64_n6), .ZN(mula1[8]) );
  INV_X1 mult_64_U279 ( .A(mult_64_n17), .ZN(mult_64_n15) );
  NAND2_X1 mult_64_U278 ( .A1(mult_64_n287), .A2(mult_64_n10), .ZN(mult_64_n2)
         );
  NAND2_X1 mult_64_U277 ( .A1(mult_64_n286), .A2(mult_64_n17), .ZN(mult_64_n3)
         );
  INV_X1 mult_64_U276 ( .A(mult_64_n26), .ZN(mult_64_n59) );
  NAND2_X1 mult_64_U275 ( .A1(mult_64_n262), .A2(mult_64_n24), .ZN(mult_64_n4)
         );
  INV_X1 mult_64_U274 ( .A(mult_64_n22), .ZN(mult_64_n20) );
  NOR2_X1 mult_64_U273 ( .A1(mult_64_n148), .A2(mult_64_n199), .ZN(
        mult_64_n285) );
  XNOR2_X1 mult_64_U272 ( .A(mult_64_n105), .B(mult_64_n285), .ZN(mult_64_n63)
         );
  OR2_X1 mult_64_U271 ( .A1(mult_64_n66), .A2(mult_64_n69), .ZN(mult_64_n286)
         );
  BUF_X1 mult_64_U270 ( .A(mult_64_n36), .Z(mult_64_n284) );
  AND2_X1 mult_64_U269 ( .A1(mult_64_n273), .A2(mult_64_n34), .ZN(mult_64_n283) );
  XNOR2_X1 mult_64_U268 ( .A(mult_64_n35), .B(mult_64_n283), .ZN(mula1[7]) );
  NOR2_X1 mult_64_U267 ( .A1(mult_64_n86), .A2(mult_64_n91), .ZN(mult_64_n282)
         );
  XNOR2_X1 mult_64_U266 ( .A(u_del_vec[1]), .B(a1[8]), .ZN(mult_64_n281) );
  NOR2_X1 mult_64_U265 ( .A1(mult_64_n80), .A2(mult_64_n85), .ZN(mult_64_n30)
         );
  NOR2_X1 mult_64_U264 ( .A1(mult_64_n80), .A2(mult_64_n85), .ZN(mult_64_n280)
         );
  OR2_X1 mult_64_U263 ( .A1(mult_64_n256), .A2(mult_64_n243), .ZN(mult_64_n279) );
  NAND3_X1 mult_64_U262 ( .A1(mult_64_n276), .A2(mult_64_n277), .A3(
        mult_64_n278), .ZN(mult_64_n79) );
  NAND2_X1 mult_64_U261 ( .A1(mult_64_n253), .A2(mult_64_n84), .ZN(
        mult_64_n278) );
  NAND2_X1 mult_64_U260 ( .A1(mult_64_n82), .A2(mult_64_n84), .ZN(mult_64_n277) );
  NAND2_X1 mult_64_U259 ( .A1(mult_64_n82), .A2(mult_64_n253), .ZN(
        mult_64_n276) );
  CLKBUF_X1 mult_64_U258 ( .A(u_del_vec[2]), .Z(mult_64_n275) );
  OR2_X1 mult_64_U257 ( .A1(mult_64_n86), .A2(mult_64_n91), .ZN(mult_64_n273)
         );
  NAND3_X1 mult_64_U256 ( .A1(mult_64_n270), .A2(mult_64_n271), .A3(
        mult_64_n272), .ZN(mult_64_n91) );
  NAND2_X1 mult_64_U255 ( .A1(mult_64_n128), .A2(mult_64_n248), .ZN(
        mult_64_n272) );
  NAND2_X1 mult_64_U254 ( .A1(mult_64_n95), .A2(mult_64_n248), .ZN(
        mult_64_n271) );
  NAND2_X1 mult_64_U253 ( .A1(mult_64_n95), .A2(mult_64_n251), .ZN(
        mult_64_n270) );
  BUF_X2 mult_64_U252 ( .A(u_del_vec[6]), .Z(mult_64_n290) );
  XNOR2_X1 mult_64_U251 ( .A(mult_64_n87), .B(mult_64_n84), .ZN(mult_64_n269)
         );
  XNOR2_X1 mult_64_U250 ( .A(mult_64_n269), .B(mult_64_n82), .ZN(mult_64_n80)
         );
  AOI21_X1 mult_64_U249 ( .B1(mult_64_n284), .B2(mult_64_n28), .A(mult_64_n29), 
        .ZN(mult_64_n1) );
  AOI21_X1 mult_64_U248 ( .B1(mult_64_n44), .B2(mult_64_n240), .A(mult_64_n241), .ZN(mult_64_n39) );
  AOI21_X1 mult_64_U247 ( .B1(mult_64_n284), .B2(mult_64_n28), .A(mult_64_n29), 
        .ZN(mult_64_n268) );
  AOI21_X1 mult_64_U246 ( .B1(mult_64_n252), .B2(mult_64_n240), .A(
        mult_64_n241), .ZN(mult_64_n267) );
  XNOR2_X1 mult_64_U245 ( .A(mult_64_n128), .B(mult_64_n142), .ZN(mult_64_n266) );
  XNOR2_X1 mult_64_U244 ( .A(mult_64_n95), .B(mult_64_n266), .ZN(mult_64_n92)
         );
  NAND3_X1 mult_64_U243 ( .A1(mult_64_n263), .A2(mult_64_n264), .A3(
        mult_64_n265), .ZN(mult_64_n85) );
  NAND2_X1 mult_64_U242 ( .A1(mult_64_n239), .A2(mult_64_n141), .ZN(
        mult_64_n265) );
  NAND2_X1 mult_64_U241 ( .A1(mult_64_n88), .A2(mult_64_n141), .ZN(
        mult_64_n264) );
  NAND2_X1 mult_64_U240 ( .A1(mult_64_n88), .A2(mult_64_n239), .ZN(
        mult_64_n263) );
  NOR2_X1 mult_64_U239 ( .A1(mult_64_n70), .A2(mult_64_n73), .ZN(mult_64_n23)
         );
  OR2_X1 mult_64_U238 ( .A1(mult_64_n70), .A2(mult_64_n73), .ZN(mult_64_n262)
         );
  XNOR2_X1 mult_64_U237 ( .A(mult_64_n93), .B(mult_64_n141), .ZN(mult_64_n261)
         );
  XNOR2_X1 mult_64_U236 ( .A(mult_64_n261), .B(mult_64_n88), .ZN(mult_64_n86)
         );
  NAND3_X1 mult_64_U235 ( .A1(mult_64_n258), .A2(mult_64_n259), .A3(
        mult_64_n260), .ZN(mult_64_n71) );
  NAND2_X1 mult_64_U234 ( .A1(mult_64_n118), .A2(mult_64_n77), .ZN(
        mult_64_n260) );
  NAND2_X1 mult_64_U233 ( .A1(mult_64_n125), .A2(mult_64_n77), .ZN(
        mult_64_n259) );
  NAND2_X1 mult_64_U232 ( .A1(mult_64_n125), .A2(mult_64_n118), .ZN(
        mult_64_n258) );
  AND2_X1 mult_64_U231 ( .A1(mult_64_n102), .A2(mult_64_n145), .ZN(
        mult_64_n257) );
  XNOR2_X1 mult_64_U230 ( .A(mult_64_n269), .B(mult_64_n82), .ZN(mult_64_n256)
         );
  OR2_X1 mult_64_U229 ( .A1(mult_64_n102), .A2(mult_64_n145), .ZN(mult_64_n255) );
  AND2_X1 mult_64_U228 ( .A1(mult_64_n62), .A2(mult_64_n38), .ZN(mult_64_n254)
         );
  XNOR2_X1 mult_64_U227 ( .A(mult_64_n254), .B(mult_64_n267), .ZN(mula1[6]) );
  CLKBUF_X1 mult_64_U226 ( .A(mult_64_n44), .Z(mult_64_n252) );
  CLKBUF_X1 mult_64_U225 ( .A(mult_64_n128), .Z(mult_64_n251) );
  XNOR2_X1 mult_64_U224 ( .A(mult_64_n118), .B(mult_64_n77), .ZN(mult_64_n249)
         );
  XNOR2_X1 mult_64_U223 ( .A(mult_64_n125), .B(mult_64_n249), .ZN(mult_64_n72)
         );
  OAI22_X1 mult_64_U222 ( .A1(mult_64_n175), .A2(mult_64_n218), .B1(
        mult_64_n198), .B2(mult_64_n176), .ZN(mult_64_n248) );
  BUF_X1 mult_64_U221 ( .A(mult_64_n161), .Z(mult_64_n247) );
  XNOR2_X1 mult_64_U220 ( .A(u_del_vec[3]), .B(a1[8]), .ZN(mult_64_n246) );
  CLKBUF_X1 mult_64_U219 ( .A(u_del_vec[1]), .Z(mult_64_n274) );
  BUF_X1 mult_64_U218 ( .A(mult_64_n31), .Z(mult_64_n245) );
  CLKBUF_X1 mult_64_U217 ( .A(mult_64_n157), .Z(mult_64_n244) );
  CLKBUF_X1 mult_64_U216 ( .A(mult_64_n87), .Z(mult_64_n253) );
  NAND3_X1 mult_64_U215 ( .A1(mult_64_n263), .A2(mult_64_n264), .A3(
        mult_64_n265), .ZN(mult_64_n243) );
  CLKBUF_X1 mult_64_U214 ( .A(mult_64_n288), .Z(mult_64_n250) );
  CLKBUF_X1 mult_64_U213 ( .A(u_del_vec[7]), .Z(mult_64_n242) );
  AND2_X1 mult_64_U212 ( .A1(mult_64_n96), .A2(mult_64_n99), .ZN(mult_64_n241)
         );
  OR2_X1 mult_64_U211 ( .A1(mult_64_n96), .A2(mult_64_n99), .ZN(mult_64_n240)
         );
  XNOR2_X1 mult_64_U210 ( .A(a1[7]), .B(a1[6]), .ZN(mult_64_n201) );
  XNOR2_X1 mult_64_U209 ( .A(a1[9]), .B(a1[8]), .ZN(mult_64_n200) );
  XNOR2_X1 mult_64_U208 ( .A(a1[11]), .B(a1[10]), .ZN(mult_64_n199) );
  FA_X1 mult_64_U207 ( .A(mult_64_n97), .B(mult_64_n122), .CI(mult_64_n135), 
        .CO(mult_64_n239) );
  AND2_X1 mult_64_U206 ( .A1(mult_64_n59), .A2(mult_64_n27), .ZN(mult_64_n238)
         );
  XNOR2_X1 mult_64_U205 ( .A(mult_64_n268), .B(mult_64_n238), .ZN(mula1[9]) );
  HA_X1 mult_64_U91 ( .A(mult_64_n138), .B(mult_64_n115), .CO(mult_64_n101), 
        .S(mult_64_n102) );
  FA_X1 mult_64_U90 ( .A(mult_64_n137), .B(mult_64_n130), .CI(mult_64_n144), 
        .CO(mult_64_n99), .S(mult_64_n100) );
  HA_X1 mult_64_U89 ( .A(mult_64_n143), .B(mult_64_n114), .CO(mult_64_n97), 
        .S(mult_64_n98) );
  FA_X1 mult_64_U88 ( .A(mult_64_n129), .B(mult_64_n98), .CI(mult_64_n136), 
        .CO(mult_64_n95), .S(mult_64_n96) );
  FA_X1 mult_64_U87 ( .A(mult_64_n97), .B(mult_64_n122), .CI(mult_64_n135), 
        .CO(mult_64_n93), .S(mult_64_n94) );
  HA_X1 mult_64_U85 ( .A(mult_64_n134), .B(mult_64_n113), .CO(mult_64_n89), 
        .S(mult_64_n90) );
  FA_X1 mult_64_U84 ( .A(mult_64_n121), .B(mult_64_n90), .CI(mult_64_n127), 
        .CO(mult_64_n87), .S(mult_64_n88) );
  FA_X1 mult_64_U80 ( .A(mult_64_n140), .B(mult_64_n133), .CI(mult_64_n120), 
        .CO(mult_64_n81), .S(mult_64_n82) );
  FA_X1 mult_64_U77 ( .A(mult_64_n119), .B(mult_64_n78), .CI(mult_64_n132), 
        .CO(mult_64_n75), .S(mult_64_n76) );
  FA_X1 mult_64_U76 ( .A(mult_64_n81), .B(mult_64_n83), .CI(mult_64_n76), .CO(
        mult_64_n73), .S(mult_64_n74) );
  FA_X1 mult_64_U74 ( .A(mult_64_n75), .B(mult_64_n131), .CI(mult_64_n72), 
        .CO(mult_64_n69), .S(mult_64_n70) );
  FA_X1 mult_64_U72 ( .A(mult_64_n124), .B(mult_64_n68), .CI(mult_64_n71), 
        .CO(mult_64_n65), .S(mult_64_n66) );
  XOR2_X1 mult_64_U70 ( .A(mult_64_n67), .B(mult_64_n63), .Z(mult_64_n64) );
  OAI21_X1 add_56_U117 ( .B1(add_56_n93), .B2(add_56_n16), .A(add_56_n17), 
        .ZN(add_56_n15) );
  OAI21_X1 add_56_U116 ( .B1(add_56_n93), .B2(add_56_n9), .A(add_56_n10), .ZN(
        add_56_n8) );
  NAND2_X1 add_56_U115 ( .A1(mula1[7]), .A2(din_del[1]), .ZN(add_56_n38) );
  OAI21_X1 add_56_U114 ( .B1(add_56_n29), .B2(add_56_n25), .A(add_56_n26), 
        .ZN(add_56_n24) );
  NOR2_X1 add_56_U113 ( .A1(add_56_n96), .A2(add_56_n28), .ZN(add_56_n23) );
  INV_X1 add_56_U112 ( .A(add_56_n96), .ZN(add_56_n44) );
  INV_X1 add_56_U111 ( .A(add_56_n41), .ZN(add_56_n39) );
  INV_X1 add_56_U110 ( .A(add_56_n8), .ZN(u[7]) );
  INV_X1 add_56_U109 ( .A(add_56_n31), .ZN(add_56_n30) );
  NAND2_X1 add_56_U108 ( .A1(add_56_n95), .A2(add_56_n85), .ZN(add_56_n9) );
  AOI21_X1 add_56_U107 ( .B1(add_56_n95), .B2(add_56_n19), .A(add_56_n12), 
        .ZN(add_56_n10) );
  NAND2_X1 add_56_U106 ( .A1(add_56_n95), .A2(add_56_n14), .ZN(add_56_n1) );
  NAND2_X1 add_56_U105 ( .A1(mula1[10]), .A2(din_del[4]), .ZN(add_56_n26) );
  NAND2_X1 add_56_U104 ( .A1(mula1[6]), .A2(din_del[0]), .ZN(add_56_n41) );
  INV_X1 add_56_U103 ( .A(add_56_n14), .ZN(add_56_n12) );
  NOR2_X1 add_56_U102 ( .A1(mula1[10]), .A2(din_del[4]), .ZN(add_56_n25) );
  NOR2_X1 add_56_U101 ( .A1(mula1[10]), .A2(din_del[4]), .ZN(add_56_n96) );
  NAND2_X1 add_56_U100 ( .A1(mula1[11]), .A2(din_del[5]), .ZN(add_56_n17) );
  NAND2_X1 add_56_U99 ( .A1(mula1[9]), .A2(din_del[3]), .ZN(add_56_n29) );
  NOR2_X1 add_56_U98 ( .A1(mula1[9]), .A2(din_del[3]), .ZN(add_56_n28) );
  INV_X1 add_56_U97 ( .A(din_del[6]), .ZN(add_56_n50) );
  NAND2_X1 add_56_U96 ( .A1(mula1[8]), .A2(din_del[2]), .ZN(add_56_n33) );
  NAND2_X1 add_56_U95 ( .A1(add_56_n49), .A2(add_56_n50), .ZN(add_56_n14) );
  INV_X1 add_56_U94 ( .A(add_56_n17), .ZN(add_56_n19) );
  AND2_X1 add_56_U93 ( .A1(add_56_n85), .A2(add_56_n17), .ZN(add_56_n94) );
  INV_X1 add_56_U92 ( .A(add_56_n28), .ZN(add_56_n45) );
  NAND2_X1 add_56_U91 ( .A1(add_56_n44), .A2(add_56_n26), .ZN(add_56_n3) );
  INV_X1 add_56_U90 ( .A(mula1[12]), .ZN(add_56_n49) );
  AOI21_X1 add_56_U89 ( .B1(add_56_n23), .B2(add_56_n92), .A(add_56_n24), .ZN(
        add_56_n22) );
  AOI21_X1 add_56_U88 ( .B1(add_56_n23), .B2(add_56_n92), .A(add_56_n24), .ZN(
        add_56_n93) );
  XNOR2_X2 add_56_U87 ( .A(add_56_n27), .B(add_56_n3), .ZN(u[4]) );
  OAI21_X1 add_56_U86 ( .B1(add_56_n32), .B2(add_56_n34), .A(add_56_n33), .ZN(
        add_56_n31) );
  OAI21_X1 add_56_U85 ( .B1(add_56_n83), .B2(add_56_n32), .A(add_56_n79), .ZN(
        add_56_n92) );
  OAI21_X1 add_56_U84 ( .B1(add_56_n30), .B2(add_56_n80), .A(add_56_n84), .ZN(
        add_56_n27) );
  NOR2_X1 add_56_U83 ( .A1(din_del[2]), .A2(mula1[8]), .ZN(add_56_n32) );
  XNOR2_X1 add_56_U82 ( .A(add_56_n15), .B(add_56_n1), .ZN(u[6]) );
  XNOR2_X2 add_56_U81 ( .A(add_56_n22), .B(add_56_n94), .ZN(u[5]) );
  XNOR2_X1 add_56_U80 ( .A(add_56_n83), .B(add_56_n91), .ZN(u[2]) );
  AND2_X1 add_56_U79 ( .A1(add_56_n33), .A2(add_56_n86), .ZN(add_56_n91) );
  OR2_X1 add_56_U78 ( .A1(add_56_n49), .A2(add_56_n50), .ZN(add_56_n95) );
  AND2_X1 add_56_U77 ( .A1(mula1[7]), .A2(din_del[1]), .ZN(add_56_n90) );
  AND2_X1 add_56_U76 ( .A1(add_56_n45), .A2(add_56_n29), .ZN(add_56_n88) );
  XNOR2_X1 add_56_U75 ( .A(add_56_n30), .B(add_56_n88), .ZN(u[3]) );
  NAND2_X1 add_56_U74 ( .A1(add_56_n89), .A2(add_56_n38), .ZN(add_56_n87) );
  AOI21_X1 add_56_U73 ( .B1(add_56_n89), .B2(add_56_n39), .A(add_56_n90), .ZN(
        add_56_n34) );
  OR2_X1 add_56_U72 ( .A1(din_del[2]), .A2(mula1[8]), .ZN(add_56_n86) );
  OR2_X2 add_56_U71 ( .A1(mula1[11]), .A2(din_del[5]), .ZN(add_56_n85) );
  CLKBUF_X1 add_56_U70 ( .A(add_56_n29), .Z(add_56_n84) );
  OR2_X2 add_56_U69 ( .A1(mula1[7]), .A2(din_del[1]), .ZN(add_56_n89) );
  AOI21_X1 add_56_U68 ( .B1(add_56_n89), .B2(add_56_n39), .A(add_56_n90), .ZN(
        add_56_n83) );
  XNOR2_X1 add_56_U67 ( .A(add_56_n87), .B(add_56_n39), .ZN(u[1]) );
  OR2_X1 add_56_U66 ( .A1(mula1[6]), .A2(din_del[0]), .ZN(add_56_n82) );
  AND2_X1 add_56_U65 ( .A1(add_56_n82), .A2(add_56_n41), .ZN(u[0]) );
  INV_X1 add_56_U64 ( .A(add_56_n85), .ZN(add_56_n16) );
  CLKBUF_X1 add_56_U63 ( .A(add_56_n28), .Z(add_56_n80) );
  CLKBUF_X1 add_56_U62 ( .A(add_56_n33), .Z(add_56_n79) );
  XNOR2_X1 mult_68_U375 ( .A(mult_68_n209), .B(n8), .ZN(mult_68_n155) );
  XNOR2_X1 mult_68_U374 ( .A(mult_68_n211), .B(n8), .ZN(mult_68_n173) );
  XNOR2_X1 mult_68_U373 ( .A(mult_68_n212), .B(n8), .ZN(mult_68_n182) );
  XNOR2_X1 mult_68_U372 ( .A(mult_68_n210), .B(n8), .ZN(mult_68_n164) );
  XNOR2_X1 mult_68_U371 ( .A(mult_68_n212), .B(n11), .ZN(mult_68_n180) );
  XNOR2_X1 mult_68_U370 ( .A(mult_68_n210), .B(n11), .ZN(mult_68_n162) );
  XNOR2_X1 mult_68_U369 ( .A(mult_68_n209), .B(n11), .ZN(mult_68_n153) );
  XNOR2_X1 mult_68_U368 ( .A(mult_68_n211), .B(n11), .ZN(mult_68_n171) );
  XNOR2_X1 mult_68_U367 ( .A(mult_68_n212), .B(n6), .ZN(mult_68_n181) );
  XNOR2_X1 mult_68_U366 ( .A(mult_68_n210), .B(n6), .ZN(mult_68_n163) );
  XNOR2_X1 mult_68_U365 ( .A(mult_68_n209), .B(n6), .ZN(mult_68_n154) );
  XNOR2_X1 mult_68_U364 ( .A(mult_68_n211), .B(n6), .ZN(mult_68_n172) );
  XNOR2_X1 mult_68_U363 ( .A(mult_68_n211), .B(n7), .ZN(mult_68_n167) );
  XNOR2_X1 mult_68_U362 ( .A(mult_68_n210), .B(n7), .ZN(mult_68_n158) );
  XNOR2_X1 mult_68_U361 ( .A(mult_68_n212), .B(n7), .ZN(mult_68_n176) );
  XNOR2_X1 mult_68_U360 ( .A(mult_68_n211), .B(n5), .ZN(mult_68_n168) );
  XNOR2_X1 mult_68_U359 ( .A(mult_68_n210), .B(n5), .ZN(mult_68_n159) );
  XNOR2_X1 mult_68_U358 ( .A(mult_68_n212), .B(n5), .ZN(mult_68_n177) );
  XNOR2_X1 mult_68_U357 ( .A(mult_68_n209), .B(n5), .ZN(mult_68_n150) );
  INV_X1 mult_68_U356 ( .A(b1[5]), .ZN(mult_68_n220) );
  BUF_X1 mult_68_U355 ( .A(b1[11]), .Z(mult_68_n209) );
  BUF_X1 mult_68_U354 ( .A(u_del_vec[0]), .Z(mult_68_n192) );
  XOR2_X1 mult_68_U353 ( .A(b1[5]), .B(b1[6]), .Z(mult_68_n196) );
  NAND2_X1 mult_68_U352 ( .A1(mult_68_n196), .A2(mult_68_n220), .ZN(
        mult_68_n216) );
  BUF_X1 mult_68_U351 ( .A(mult_68_n216), .Z(mult_68_n200) );
  XOR2_X1 mult_68_U350 ( .A(b1[7]), .B(b1[8]), .Z(mult_68_n195) );
  NAND2_X1 mult_68_U349 ( .A1(mult_68_n195), .A2(mult_68_n219), .ZN(
        mult_68_n215) );
  BUF_X1 mult_68_U348 ( .A(mult_68_n215), .Z(mult_68_n199) );
  XOR2_X1 mult_68_U347 ( .A(b1[9]), .B(b1[10]), .Z(mult_68_n194) );
  NAND2_X1 mult_68_U346 ( .A1(mult_68_n194), .A2(mult_68_n218), .ZN(
        mult_68_n214) );
  BUF_X1 mult_68_U345 ( .A(mult_68_n214), .Z(mult_68_n198) );
  INV_X1 mult_68_U344 ( .A(mult_68_n247), .ZN(mult_68_n217) );
  XOR2_X1 mult_68_U343 ( .A(b1[11]), .B(b1[10]), .Z(mult_68_n247) );
  XNOR2_X1 mult_68_U342 ( .A(mult_68_n212), .B(u_del_vec[5]), .ZN(mult_68_n178) );
  XNOR2_X1 mult_68_U341 ( .A(mult_68_n212), .B(u_del_vec[4]), .ZN(mult_68_n179) );
  XNOR2_X1 mult_68_U340 ( .A(mult_68_n211), .B(u_del_vec[5]), .ZN(mult_68_n169) );
  XNOR2_X1 mult_68_U339 ( .A(mult_68_n211), .B(u_del_vec[4]), .ZN(mult_68_n170) );
  XNOR2_X1 mult_68_U338 ( .A(mult_68_n210), .B(u_del_vec[5]), .ZN(mult_68_n160) );
  XNOR2_X1 mult_68_U337 ( .A(mult_68_n210), .B(u_del_vec[4]), .ZN(mult_68_n161) );
  XNOR2_X1 mult_68_U336 ( .A(b1[7]), .B(b1[6]), .ZN(mult_68_n219) );
  XNOR2_X1 mult_68_U335 ( .A(b1[9]), .B(b1[8]), .ZN(mult_68_n218) );
  BUF_X1 mult_68_U334 ( .A(b1[6]), .Z(mult_68_n212) );
  BUF_X1 mult_68_U333 ( .A(b1[10]), .Z(mult_68_n210) );
  BUF_X1 mult_68_U332 ( .A(b1[8]), .Z(mult_68_n211) );
  XNOR2_X1 mult_68_U331 ( .A(mult_68_n209), .B(u_del_vec[5]), .ZN(mult_68_n151) );
  INV_X1 mult_68_U330 ( .A(mult_68_n69), .ZN(mult_68_n70) );
  NOR2_X1 mult_68_U329 ( .A1(mult_68_n217), .A2(mult_68_n151), .ZN(
        mult_68_n120) );
  XNOR2_X1 mult_68_U328 ( .A(mult_68_n209), .B(u_del_vec[4]), .ZN(mult_68_n152) );
  NOR2_X1 mult_68_U327 ( .A1(mult_68_n217), .A2(mult_68_n152), .ZN(
        mult_68_n121) );
  INV_X1 mult_68_U326 ( .A(mult_68_n209), .ZN(mult_68_n106) );
  OR2_X1 mult_68_U325 ( .A1(mult_68_n192), .A2(mult_68_n206), .ZN(mult_68_n166) );
  OR2_X1 mult_68_U324 ( .A1(mult_68_n192), .A2(mult_68_n208), .ZN(mult_68_n184) );
  XNOR2_X1 mult_68_U323 ( .A(mult_68_n210), .B(mult_68_n192), .ZN(mult_68_n165) );
  XNOR2_X1 mult_68_U322 ( .A(mult_68_n212), .B(mult_68_n192), .ZN(mult_68_n183) );
  INV_X1 mult_68_U321 ( .A(mult_68_n203), .ZN(mult_68_n111) );
  AND2_X1 mult_68_U320 ( .A1(mult_68_n192), .A2(mult_68_n111), .ZN(
        mult_68_n141) );
  BUF_X1 mult_68_U319 ( .A(mult_68_n220), .Z(mult_68_n204) );
  BUF_X1 mult_68_U318 ( .A(mult_68_n219), .Z(mult_68_n203) );
  BUF_X1 mult_68_U317 ( .A(mult_68_n218), .Z(mult_68_n202) );
  OR2_X1 mult_68_U316 ( .A1(mult_68_n192), .A2(mult_68_n207), .ZN(mult_68_n175) );
  INV_X1 mult_68_U315 ( .A(mult_68_n211), .ZN(mult_68_n207) );
  OAI22_X1 mult_68_U314 ( .A1(mult_68_n199), .A2(mult_68_n207), .B1(
        mult_68_n175), .B2(mult_68_n203), .ZN(mult_68_n117) );
  XNOR2_X1 mult_68_U313 ( .A(mult_68_n107), .B(mult_68_n119), .ZN(mult_68_n65)
         );
  OR2_X1 mult_68_U312 ( .A1(mult_68_n67), .A2(mult_68_n66), .ZN(mult_68_n246)
         );
  OR2_X1 mult_68_U311 ( .A1(mult_68_n192), .A2(mult_68_n106), .ZN(mult_68_n157) );
  NOR2_X1 mult_68_U310 ( .A1(mult_68_n217), .A2(mult_68_n155), .ZN(
        mult_68_n124) );
  NOR2_X1 mult_68_U309 ( .A1(mult_68_n157), .A2(mult_68_n217), .ZN(
        mult_68_n115) );
  INV_X1 mult_68_U308 ( .A(mult_68_n212), .ZN(mult_68_n208) );
  OAI22_X1 mult_68_U307 ( .A1(mult_68_n200), .A2(mult_68_n183), .B1(
        mult_68_n182), .B2(mult_68_n204), .ZN(mult_68_n149) );
  OAI22_X1 mult_68_U306 ( .A1(mult_68_n200), .A2(mult_68_n208), .B1(
        mult_68_n184), .B2(mult_68_n204), .ZN(mult_68_n118) );
  INV_X1 mult_68_U305 ( .A(mult_68_n210), .ZN(mult_68_n206) );
  OAI22_X1 mult_68_U304 ( .A1(mult_68_n198), .A2(mult_68_n165), .B1(
        mult_68_n202), .B2(mult_68_n164), .ZN(mult_68_n132) );
  OAI22_X1 mult_68_U303 ( .A1(mult_68_n198), .A2(mult_68_n206), .B1(
        mult_68_n166), .B2(mult_68_n202), .ZN(mult_68_n116) );
  INV_X1 mult_68_U302 ( .A(mult_68_n79), .ZN(mult_68_n80) );
  NOR2_X1 mult_68_U301 ( .A1(mult_68_n217), .A2(mult_68_n153), .ZN(
        mult_68_n122) );
  OAI22_X1 mult_68_U300 ( .A1(mult_68_n198), .A2(mult_68_n161), .B1(
        mult_68_n202), .B2(mult_68_n160), .ZN(mult_68_n128) );
  NAND2_X1 mult_68_U299 ( .A1(mult_68_n72), .A2(mult_68_n75), .ZN(mult_68_n24)
         );
  NAND2_X1 mult_68_U298 ( .A1(mult_68_n68), .A2(mult_68_n71), .ZN(mult_68_n17)
         );
  NAND2_X1 mult_68_U297 ( .A1(mult_68_n67), .A2(mult_68_n66), .ZN(mult_68_n10)
         );
  OAI22_X1 mult_68_U296 ( .A1(mult_68_n199), .A2(mult_68_n171), .B1(
        mult_68_n203), .B2(mult_68_n170), .ZN(mult_68_n137) );
  OAI22_X1 mult_68_U295 ( .A1(mult_68_n200), .A2(mult_68_n178), .B1(
        mult_68_n177), .B2(mult_68_n204), .ZN(mult_68_n144) );
  AND2_X1 mult_68_U294 ( .A1(mult_68_n192), .A2(mult_68_n247), .ZN(
        mult_68_n125) );
  OAI22_X1 mult_68_U293 ( .A1(mult_68_n198), .A2(mult_68_n163), .B1(
        mult_68_n202), .B2(mult_68_n162), .ZN(mult_68_n130) );
  OAI22_X1 mult_68_U292 ( .A1(mult_68_n200), .A2(mult_68_n177), .B1(
        mult_68_n176), .B2(mult_68_n204), .ZN(mult_68_n143) );
  OAI22_X1 mult_68_U291 ( .A1(mult_68_n199), .A2(mult_68_n170), .B1(
        mult_68_n203), .B2(mult_68_n169), .ZN(mult_68_n136) );
  AOI21_X1 mult_68_U290 ( .B1(mult_68_n200), .B2(mult_68_n204), .A(
        mult_68_n176), .ZN(mult_68_n113) );
  INV_X1 mult_68_U289 ( .A(mult_68_n113), .ZN(mult_68_n142) );
  OAI22_X1 mult_68_U288 ( .A1(mult_68_n198), .A2(mult_68_n162), .B1(
        mult_68_n202), .B2(mult_68_n161), .ZN(mult_68_n129) );
  AOI21_X1 mult_68_U287 ( .B1(mult_68_n199), .B2(mult_68_n203), .A(
        mult_68_n167), .ZN(mult_68_n110) );
  INV_X1 mult_68_U286 ( .A(mult_68_n110), .ZN(mult_68_n134) );
  OAI22_X1 mult_68_U285 ( .A1(mult_68_n198), .A2(mult_68_n160), .B1(
        mult_68_n202), .B2(mult_68_n159), .ZN(mult_68_n127) );
  AOI21_X1 mult_68_U284 ( .B1(mult_68_n198), .B2(mult_68_n202), .A(
        mult_68_n158), .ZN(mult_68_n107) );
  OAI22_X1 mult_68_U283 ( .A1(mult_68_n199), .A2(mult_68_n172), .B1(
        mult_68_n203), .B2(mult_68_n171), .ZN(mult_68_n138) );
  OAI22_X1 mult_68_U282 ( .A1(mult_68_n200), .A2(mult_68_n179), .B1(
        mult_68_n178), .B2(mult_68_n204), .ZN(mult_68_n145) );
  OR2_X1 mult_68_U281 ( .A1(mult_68_n135), .A2(mult_68_n123), .ZN(mult_68_n85)
         );
  OAI22_X1 mult_68_U280 ( .A1(mult_68_n200), .A2(mult_68_n180), .B1(
        mult_68_n179), .B2(mult_68_n204), .ZN(mult_68_n146) );
  OAI22_X1 mult_68_U279 ( .A1(mult_68_n199), .A2(mult_68_n173), .B1(
        mult_68_n203), .B2(mult_68_n172), .ZN(mult_68_n139) );
  AND2_X1 mult_68_U278 ( .A1(mult_68_n192), .A2(mult_68_n108), .ZN(
        mult_68_n133) );
  XNOR2_X1 mult_68_U277 ( .A(mult_68_n135), .B(mult_68_n123), .ZN(mult_68_n86)
         );
  OAI22_X1 mult_68_U276 ( .A1(mult_68_n198), .A2(mult_68_n164), .B1(
        mult_68_n202), .B2(mult_68_n163), .ZN(mult_68_n131) );
  OAI22_X1 mult_68_U275 ( .A1(mult_68_n199), .A2(mult_68_n169), .B1(
        mult_68_n203), .B2(mult_68_n168), .ZN(mult_68_n135) );
  OAI22_X1 mult_68_U274 ( .A1(mult_68_n200), .A2(mult_68_n182), .B1(
        mult_68_n181), .B2(mult_68_n204), .ZN(mult_68_n148) );
  XNOR2_X1 mult_68_U273 ( .A(mult_68_n211), .B(mult_68_n192), .ZN(mult_68_n174) );
  OAI22_X1 mult_68_U272 ( .A1(mult_68_n199), .A2(mult_68_n174), .B1(
        mult_68_n203), .B2(mult_68_n173), .ZN(mult_68_n140) );
  OAI22_X1 mult_68_U271 ( .A1(mult_68_n200), .A2(mult_68_n181), .B1(
        mult_68_n180), .B2(mult_68_n204), .ZN(mult_68_n147) );
  OAI22_X1 mult_68_U270 ( .A1(mult_68_n198), .A2(mult_68_n159), .B1(
        mult_68_n202), .B2(mult_68_n158), .ZN(mult_68_n69) );
  OAI22_X1 mult_68_U269 ( .A1(mult_68_n199), .A2(mult_68_n168), .B1(
        mult_68_n203), .B2(mult_68_n167), .ZN(mult_68_n79) );
  INV_X1 mult_68_U268 ( .A(mult_68_n202), .ZN(mult_68_n108) );
  NAND2_X1 mult_68_U267 ( .A1(mult_68_n104), .A2(mult_68_n117), .ZN(
        mult_68_n50) );
  NOR2_X1 mult_68_U266 ( .A1(mult_68_n104), .A2(mult_68_n117), .ZN(mult_68_n49) );
  OAI21_X1 mult_68_U265 ( .B1(mult_68_n49), .B2(mult_68_n51), .A(mult_68_n50), 
        .ZN(mult_68_n48) );
  INV_X1 mult_68_U264 ( .A(mult_68_n48), .ZN(mult_68_n47) );
  OAI21_X1 mult_68_U263 ( .B1(mult_68_n1), .B2(mult_68_n12), .A(mult_68_n13), 
        .ZN(mult_68_n11) );
  NAND2_X1 mult_68_U262 ( .A1(mult_68_n246), .A2(mult_68_n10), .ZN(mult_68_n2)
         );
  XNOR2_X1 mult_68_U261 ( .A(mult_68_n11), .B(mult_68_n2), .ZN(mulb1[12]) );
  INV_X1 mult_68_U260 ( .A(mult_68_n23), .ZN(mult_68_n60) );
  NAND2_X1 mult_68_U259 ( .A1(mult_68_n60), .A2(mult_68_n24), .ZN(mult_68_n4)
         );
  OAI21_X1 mult_68_U258 ( .B1(mult_68_n1), .B2(mult_68_n26), .A(mult_68_n27), 
        .ZN(mult_68_n25) );
  XNOR2_X1 mult_68_U257 ( .A(mult_68_n25), .B(mult_68_n4), .ZN(mulb1[10]) );
  INV_X1 mult_68_U256 ( .A(mult_68_n22), .ZN(mult_68_n20) );
  NAND2_X1 mult_68_U255 ( .A1(mult_68_n241), .A2(mult_68_n17), .ZN(mult_68_n3)
         );
  OAI21_X1 mult_68_U254 ( .B1(mult_68_n1), .B2(mult_68_n19), .A(mult_68_n20), 
        .ZN(mult_68_n18) );
  XNOR2_X1 mult_68_U253 ( .A(mult_68_n18), .B(mult_68_n3), .ZN(mulb1[11]) );
  NAND2_X1 mult_68_U252 ( .A1(mult_68_n102), .A2(mult_68_n103), .ZN(
        mult_68_n46) );
  NAND2_X1 mult_68_U251 ( .A1(mult_68_n94), .A2(mult_68_n97), .ZN(mult_68_n38)
         );
  NAND2_X1 mult_68_U250 ( .A1(mult_68_n82), .A2(mult_68_n87), .ZN(mult_68_n31)
         );
  NOR2_X1 mult_68_U249 ( .A1(mult_68_n102), .A2(mult_68_n103), .ZN(mult_68_n45) );
  NAND2_X1 mult_68_U248 ( .A1(mult_68_n76), .A2(mult_68_n81), .ZN(mult_68_n27)
         );
  NAND2_X1 mult_68_U247 ( .A1(mult_68_n88), .A2(mult_68_n93), .ZN(mult_68_n34)
         );
  INV_X1 mult_68_U246 ( .A(mult_68_n17), .ZN(mult_68_n15) );
  AOI21_X1 mult_68_U245 ( .B1(mult_68_n22), .B2(mult_68_n241), .A(mult_68_n15), 
        .ZN(mult_68_n13) );
  AOI21_X1 mult_68_U244 ( .B1(mult_68_n244), .B2(mult_68_n242), .A(
        mult_68_n240), .ZN(mult_68_n51) );
  NOR2_X1 mult_68_U243 ( .A1(mult_68_n26), .A2(mult_68_n23), .ZN(mult_68_n21)
         );
  OAI21_X1 mult_68_U242 ( .B1(mult_68_n23), .B2(mult_68_n27), .A(mult_68_n24), 
        .ZN(mult_68_n22) );
  INV_X1 mult_68_U241 ( .A(mult_68_n21), .ZN(mult_68_n19) );
  NAND2_X1 mult_68_U240 ( .A1(mult_68_n21), .A2(mult_68_n241), .ZN(mult_68_n12) );
  INV_X1 mult_68_U239 ( .A(mult_68_n30), .ZN(mult_68_n62) );
  NAND2_X1 mult_68_U238 ( .A1(mult_68_n62), .A2(mult_68_n31), .ZN(mult_68_n6)
         );
  OAI21_X1 mult_68_U237 ( .B1(mult_68_n35), .B2(mult_68_n33), .A(mult_68_n34), 
        .ZN(mult_68_n32) );
  XNOR2_X1 mult_68_U236 ( .A(mult_68_n32), .B(mult_68_n6), .ZN(mulb1[8]) );
  INV_X1 mult_68_U235 ( .A(mult_68_n33), .ZN(mult_68_n63) );
  NAND2_X1 mult_68_U234 ( .A1(mult_68_n63), .A2(mult_68_n34), .ZN(mult_68_n7)
         );
  XOR2_X1 mult_68_U233 ( .A(mult_68_n35), .B(mult_68_n7), .Z(mulb1[7]) );
  OAI21_X1 mult_68_U232 ( .B1(mult_68_n45), .B2(mult_68_n47), .A(mult_68_n46), 
        .ZN(mult_68_n44) );
  AOI21_X1 mult_68_U231 ( .B1(mult_68_n245), .B2(mult_68_n44), .A(mult_68_n243), .ZN(mult_68_n39) );
  INV_X1 mult_68_U230 ( .A(mult_68_n26), .ZN(mult_68_n61) );
  NAND2_X1 mult_68_U229 ( .A1(mult_68_n61), .A2(mult_68_n27), .ZN(mult_68_n5)
         );
  XOR2_X1 mult_68_U228 ( .A(mult_68_n1), .B(mult_68_n5), .Z(mulb1[9]) );
  OAI21_X1 mult_68_U227 ( .B1(mult_68_n30), .B2(mult_68_n34), .A(mult_68_n31), 
        .ZN(mult_68_n29) );
  NOR2_X1 mult_68_U226 ( .A1(mult_68_n30), .A2(mult_68_n33), .ZN(mult_68_n28)
         );
  AOI21_X1 mult_68_U225 ( .B1(mult_68_n28), .B2(mult_68_n36), .A(mult_68_n29), 
        .ZN(mult_68_n1) );
  INV_X1 mult_68_U224 ( .A(mult_68_n37), .ZN(mult_68_n64) );
  NAND2_X1 mult_68_U223 ( .A1(mult_68_n64), .A2(mult_68_n38), .ZN(mult_68_n8)
         );
  XOR2_X1 mult_68_U222 ( .A(mult_68_n8), .B(mult_68_n39), .Z(mulb1[6]) );
  INV_X1 mult_68_U221 ( .A(mult_68_n36), .ZN(mult_68_n35) );
  NOR2_X1 mult_68_U220 ( .A1(mult_68_n217), .A2(mult_68_n150), .ZN(
        mult_68_n119) );
  NOR2_X1 mult_68_U219 ( .A1(mult_68_n94), .A2(mult_68_n97), .ZN(mult_68_n37)
         );
  NOR2_X1 mult_68_U218 ( .A1(mult_68_n76), .A2(mult_68_n81), .ZN(mult_68_n26)
         );
  OAI21_X1 mult_68_U217 ( .B1(mult_68_n37), .B2(mult_68_n39), .A(mult_68_n38), 
        .ZN(mult_68_n36) );
  OR2_X1 mult_68_U216 ( .A1(mult_68_n98), .A2(mult_68_n101), .ZN(mult_68_n245)
         );
  OR2_X1 mult_68_U215 ( .A1(mult_68_n148), .A2(mult_68_n141), .ZN(mult_68_n244) );
  AND2_X1 mult_68_U214 ( .A1(mult_68_n98), .A2(mult_68_n101), .ZN(mult_68_n243) );
  AND2_X1 mult_68_U213 ( .A1(mult_68_n149), .A2(mult_68_n118), .ZN(
        mult_68_n242) );
  OR2_X1 mult_68_U212 ( .A1(mult_68_n68), .A2(mult_68_n71), .ZN(mult_68_n241)
         );
  AND2_X1 mult_68_U211 ( .A1(mult_68_n148), .A2(mult_68_n141), .ZN(
        mult_68_n240) );
  NOR2_X1 mult_68_U210 ( .A1(mult_68_n82), .A2(mult_68_n87), .ZN(mult_68_n30)
         );
  NOR2_X1 mult_68_U209 ( .A1(mult_68_n88), .A2(mult_68_n93), .ZN(mult_68_n33)
         );
  NOR2_X1 mult_68_U208 ( .A1(mult_68_n72), .A2(mult_68_n75), .ZN(mult_68_n23)
         );
  NOR2_X1 mult_68_U207 ( .A1(mult_68_n217), .A2(mult_68_n154), .ZN(
        mult_68_n123) );
  HA_X1 mult_68_U93 ( .A(mult_68_n140), .B(mult_68_n147), .CO(mult_68_n103), 
        .S(mult_68_n104) );
  FA_X1 mult_68_U92 ( .A(mult_68_n146), .B(mult_68_n133), .CI(mult_68_n139), 
        .CO(mult_68_n101), .S(mult_68_n102) );
  HA_X1 mult_68_U91 ( .A(mult_68_n116), .B(mult_68_n132), .CO(mult_68_n99), 
        .S(mult_68_n100) );
  FA_X1 mult_68_U90 ( .A(mult_68_n138), .B(mult_68_n145), .CI(mult_68_n100), 
        .CO(mult_68_n97), .S(mult_68_n98) );
  FA_X1 mult_68_U89 ( .A(mult_68_n144), .B(mult_68_n125), .CI(mult_68_n137), 
        .CO(mult_68_n95), .S(mult_68_n96) );
  FA_X1 mult_68_U88 ( .A(mult_68_n99), .B(mult_68_n131), .CI(mult_68_n96), 
        .CO(mult_68_n93), .S(mult_68_n94) );
  HA_X1 mult_68_U87 ( .A(mult_68_n115), .B(mult_68_n124), .CO(mult_68_n91), 
        .S(mult_68_n92) );
  FA_X1 mult_68_U86 ( .A(mult_68_n130), .B(mult_68_n143), .CI(mult_68_n136), 
        .CO(mult_68_n89), .S(mult_68_n90) );
  FA_X1 mult_68_U85 ( .A(mult_68_n95), .B(mult_68_n92), .CI(mult_68_n90), .CO(
        mult_68_n87), .S(mult_68_n88) );
  FA_X1 mult_68_U82 ( .A(mult_68_n142), .B(mult_68_n129), .CI(mult_68_n91), 
        .CO(mult_68_n83), .S(mult_68_n84) );
  FA_X1 mult_68_U81 ( .A(mult_68_n89), .B(mult_68_n86), .CI(mult_68_n84), .CO(
        mult_68_n81), .S(mult_68_n82) );
  FA_X1 mult_68_U79 ( .A(mult_68_n122), .B(mult_68_n128), .CI(mult_68_n80), 
        .CO(mult_68_n77), .S(mult_68_n78) );
  FA_X1 mult_68_U78 ( .A(mult_68_n83), .B(mult_68_n85), .CI(mult_68_n78), .CO(
        mult_68_n75), .S(mult_68_n76) );
  FA_X1 mult_68_U77 ( .A(mult_68_n127), .B(mult_68_n79), .CI(mult_68_n134), 
        .CO(mult_68_n73), .S(mult_68_n74) );
  FA_X1 mult_68_U76 ( .A(mult_68_n77), .B(mult_68_n121), .CI(mult_68_n74), 
        .CO(mult_68_n71), .S(mult_68_n72) );
  FA_X1 mult_68_U74 ( .A(mult_68_n70), .B(mult_68_n120), .CI(mult_68_n73), 
        .CO(mult_68_n67), .S(mult_68_n68) );
  XOR2_X1 mult_68_U72 ( .A(mult_68_n69), .B(mult_68_n65), .Z(mult_68_n66) );
  OAI21_X1 add_72_U115 ( .B1(add_72_n1), .B2(add_72_n87), .A(add_72_n83), .ZN(
        add_72_n23) );
  OAI21_X1 add_72_U114 ( .B1(add_72_n1), .B2(add_72_n85), .A(add_72_n18), .ZN(
        add_72_n16) );
  OAI21_X1 add_72_U113 ( .B1(add_72_n93), .B2(add_72_n10), .A(add_72_n11), 
        .ZN(add_72_n9) );
  XNOR2_X1 add_72_U112 ( .A(add_72_n16), .B(add_72_n2), .ZN(y[6]) );
  INV_X1 add_72_U111 ( .A(add_72_n9), .ZN(y[7]) );
  XNOR2_X1 add_72_U110 ( .A(add_72_n23), .B(add_72_n3), .ZN(y[5]) );
  NAND2_X1 add_72_U109 ( .A1(mulb0[9]), .A2(mulb1[9]), .ZN(add_72_n29) );
  OAI21_X1 add_72_U108 ( .B1(add_72_n28), .B2(add_72_n32), .A(add_72_n29), 
        .ZN(add_72_n27) );
  NOR2_X1 add_72_U107 ( .A1(add_72_n88), .A2(add_72_n31), .ZN(add_72_n26) );
  INV_X1 add_72_U106 ( .A(add_72_n88), .ZN(add_72_n42) );
  NAND2_X1 add_72_U105 ( .A1(mulb0[10]), .A2(mulb1[10]), .ZN(add_72_n25) );
  NOR2_X1 add_72_U104 ( .A1(mulb1[10]), .A2(mulb0[10]), .ZN(add_72_n24) );
  INV_X1 add_72_U103 ( .A(add_72_n84), .ZN(add_72_n40) );
  NAND2_X1 add_72_U102 ( .A1(add_72_n19), .A2(add_72_n91), .ZN(add_72_n10) );
  AOI21_X1 add_72_U101 ( .B1(add_72_n92), .B2(add_72_n91), .A(add_72_n13), 
        .ZN(add_72_n11) );
  NAND2_X1 add_72_U100 ( .A1(add_72_n15), .A2(add_72_n91), .ZN(add_72_n2) );
  NOR2_X1 add_72_U99 ( .A1(add_72_n84), .A2(add_72_n24), .ZN(add_72_n19) );
  OAI21_X1 add_72_U98 ( .B1(add_72_n35), .B2(add_72_n38), .A(add_72_n36), .ZN(
        add_72_n34) );
  INV_X1 add_72_U97 ( .A(add_72_n20), .ZN(add_72_n18) );
  NOR2_X1 add_72_U96 ( .A1(mulb0[7]), .A2(mulb1[7]), .ZN(add_72_n35) );
  OAI21_X1 add_72_U95 ( .B1(add_72_n25), .B2(add_72_n21), .A(add_72_n22), .ZN(
        add_72_n20) );
  INV_X1 add_72_U94 ( .A(add_72_n24), .ZN(add_72_n41) );
  INV_X1 add_72_U93 ( .A(add_72_n15), .ZN(add_72_n13) );
  AOI21_X1 add_72_U92 ( .B1(add_72_n26), .B2(add_72_n80), .A(add_72_n27), .ZN(
        add_72_n1) );
  AOI21_X1 add_72_U91 ( .B1(add_72_n26), .B2(add_72_n80), .A(add_72_n27), .ZN(
        add_72_n93) );
  OAI21_X1 add_72_U90 ( .B1(add_72_n84), .B2(add_72_n25), .A(add_72_n22), .ZN(
        add_72_n92) );
  NAND2_X1 add_72_U89 ( .A1(mulb0[11]), .A2(mulb1[11]), .ZN(add_72_n22) );
  NAND2_X1 add_72_U88 ( .A1(mulb0[8]), .A2(mulb1[8]), .ZN(add_72_n32) );
  NOR2_X1 add_72_U87 ( .A1(mulb0[8]), .A2(mulb1[8]), .ZN(add_72_n31) );
  NAND2_X1 add_72_U86 ( .A1(mulb0[7]), .A2(mulb1[7]), .ZN(add_72_n36) );
  NAND2_X1 add_72_U85 ( .A1(add_72_n32), .A2(add_72_n79), .ZN(add_72_n6) );
  XOR2_X1 add_72_U84 ( .A(add_72_n6), .B(add_72_n33), .Z(y[2]) );
  NAND2_X1 add_72_U83 ( .A1(add_72_n42), .A2(add_72_n86), .ZN(add_72_n5) );
  XNOR2_X1 add_72_U82 ( .A(add_72_n5), .B(add_72_n30), .ZN(y[3]) );
  NAND2_X1 add_72_U81 ( .A1(add_72_n40), .A2(add_72_n22), .ZN(add_72_n3) );
  OR2_X1 add_72_U80 ( .A1(mulb0[6]), .A2(mulb1[6]), .ZN(add_72_n90) );
  NAND2_X1 add_72_U79 ( .A1(mulb0[6]), .A2(mulb1[6]), .ZN(add_72_n38) );
  NOR2_X1 add_72_U78 ( .A1(mulb0[9]), .A2(mulb1[9]), .ZN(add_72_n28) );
  OAI21_X1 add_72_U77 ( .B1(add_72_n33), .B2(add_72_n31), .A(add_72_n32), .ZN(
        add_72_n30) );
  INV_X1 add_72_U76 ( .A(add_72_n34), .ZN(add_72_n33) );
  AND2_X1 add_72_U75 ( .A1(add_72_n38), .A2(add_72_n90), .ZN(y[0]) );
  NOR2_X1 add_72_U74 ( .A1(mulb0[9]), .A2(mulb1[9]), .ZN(add_72_n88) );
  INV_X1 add_72_U73 ( .A(add_72_n41), .ZN(add_72_n87) );
  OR2_X1 add_72_U72 ( .A1(mulb0[12]), .A2(mulb1[12]), .ZN(add_72_n15) );
  BUF_X1 add_72_U71 ( .A(add_72_n29), .Z(add_72_n86) );
  OR2_X1 add_72_U70 ( .A1(add_72_n24), .A2(add_72_n21), .ZN(add_72_n85) );
  NOR2_X1 add_72_U69 ( .A1(mulb0[11]), .A2(mulb1[11]), .ZN(add_72_n21) );
  NOR2_X1 add_72_U68 ( .A1(mulb0[11]), .A2(mulb1[11]), .ZN(add_72_n84) );
  NAND2_X1 add_72_U67 ( .A1(mulb0[12]), .A2(mulb1[12]), .ZN(add_72_n91) );
  NAND2_X1 add_72_U66 ( .A1(add_72_n83), .A2(add_72_n41), .ZN(add_72_n81) );
  XOR2_X1 add_72_U65 ( .A(add_72_n93), .B(add_72_n81), .Z(y[4]) );
  CLKBUF_X1 add_72_U64 ( .A(add_72_n25), .Z(add_72_n83) );
  INV_X1 add_72_U63 ( .A(add_72_n33), .ZN(add_72_n80) );
  OR2_X1 add_72_U62 ( .A1(mulb0[8]), .A2(mulb1[8]), .ZN(add_72_n79) );
  OR2_X1 add_72_U61 ( .A1(mulb0[7]), .A2(mulb1[7]), .ZN(add_72_n78) );
  NAND2_X1 add_72_U60 ( .A1(add_72_n78), .A2(add_72_n36), .ZN(add_72_n76) );
  XOR2_X1 add_72_U59 ( .A(add_72_n76), .B(add_72_n38), .Z(y[1]) );
  XNOR2_X1 mult_66_U391 ( .A(u[6]), .B(b0[6]), .ZN(mult_66_n174) );
  XNOR2_X1 mult_66_U390 ( .A(mult_66_n259), .B(b0[8]), .ZN(mult_66_n165) );
  XNOR2_X1 mult_66_U389 ( .A(mult_66_n259), .B(b0[10]), .ZN(mult_66_n156) );
  XNOR2_X1 mult_66_U388 ( .A(mult_66_n259), .B(b0[11]), .ZN(mult_66_n147) );
  XNOR2_X1 mult_66_U387 ( .A(u[4]), .B(b0[10]), .ZN(mult_66_n158) );
  XNOR2_X1 mult_66_U386 ( .A(u[4]), .B(b0[8]), .ZN(mult_66_n167) );
  XNOR2_X1 mult_66_U385 ( .A(u[4]), .B(b0[6]), .ZN(mult_66_n176) );
  OAI22_X1 mult_66_U384 ( .A1(mult_66_n199), .A2(mult_66_n243), .B1(
        mult_66_n159), .B2(mult_66_n195), .ZN(mult_66_n125) );
  XNOR2_X1 mult_66_U383 ( .A(mult_66_n252), .B(b0[11]), .ZN(mult_66_n149) );
  OAI22_X1 mult_66_U382 ( .A1(mult_66_n157), .A2(mult_66_n199), .B1(
        mult_66_n158), .B2(mult_66_n195), .ZN(mult_66_n124) );
  OAI21_X1 mult_66_U381 ( .B1(mult_66_n19), .B2(mult_66_n1), .A(mult_66_n20), 
        .ZN(mult_66_n18) );
  OAI21_X1 mult_66_U380 ( .B1(mult_66_n279), .B2(mult_66_n272), .A(mult_66_n13), .ZN(mult_66_n11) );
  XNOR2_X1 mult_66_U379 ( .A(u[5]), .B(b0[6]), .ZN(mult_66_n175) );
  XNOR2_X1 mult_66_U378 ( .A(u[5]), .B(b0[8]), .ZN(mult_66_n166) );
  XNOR2_X1 mult_66_U377 ( .A(u[5]), .B(b0[10]), .ZN(mult_66_n157) );
  XNOR2_X1 mult_66_U376 ( .A(mult_66_n263), .B(b0[11]), .ZN(mult_66_n148) );
  XNOR2_X1 mult_66_U375 ( .A(mult_66_n255), .B(b0[8]), .ZN(mult_66_n169) );
  XNOR2_X1 mult_66_U374 ( .A(mult_66_n255), .B(b0[6]), .ZN(mult_66_n178) );
  XNOR2_X1 mult_66_U373 ( .A(u[2]), .B(b0[10]), .ZN(mult_66_n160) );
  XNOR2_X1 mult_66_U372 ( .A(mult_66_n257), .B(b0[11]), .ZN(mult_66_n151) );
  OAI22_X1 mult_66_U371 ( .A1(mult_66_n175), .A2(mult_66_n217), .B1(
        mult_66_n176), .B2(mult_66_n197), .ZN(mult_66_n142) );
  OAI22_X1 mult_66_U370 ( .A1(mult_66_n174), .A2(mult_66_n217), .B1(
        mult_66_n175), .B2(mult_66_n197), .ZN(mult_66_n141) );
  NOR2_X1 mult_66_U369 ( .A1(mult_66_n95), .A2(mult_66_n98), .ZN(mult_66_n38)
         );
  OAI22_X1 mult_66_U368 ( .A1(mult_66_n253), .A2(mult_66_n197), .B1(
        mult_66_n173), .B2(mult_66_n217), .ZN(mult_66_n110) );
  INV_X1 mult_66_U367 ( .A(mult_66_n110), .ZN(mult_66_n139) );
  OAI22_X1 mult_66_U366 ( .A1(mult_66_n174), .A2(mult_66_n197), .B1(
        mult_66_n253), .B2(mult_66_n217), .ZN(mult_66_n140) );
  OAI21_X1 mult_66_U365 ( .B1(mult_66_n23), .B2(mult_66_n27), .A(mult_66_n24), 
        .ZN(mult_66_n22) );
  OAI21_X1 mult_66_U364 ( .B1(mult_66_n28), .B2(mult_66_n26), .A(mult_66_n27), 
        .ZN(mult_66_n25) );
  XNOR2_X1 mult_66_U363 ( .A(mult_66_n11), .B(mult_66_n2), .ZN(mulb0[12]) );
  XNOR2_X1 mult_66_U362 ( .A(mult_66_n18), .B(mult_66_n3), .ZN(mulb0[11]) );
  OAI22_X1 mult_66_U361 ( .A1(mult_66_n178), .A2(mult_66_n217), .B1(
        mult_66_n179), .B2(mult_66_n197), .ZN(mult_66_n145) );
  XNOR2_X1 mult_66_U360 ( .A(mult_66_n8), .B(mult_66_n37), .ZN(mulb0[6]) );
  OAI22_X1 mult_66_U359 ( .A1(mult_66_n164), .A2(mult_66_n196), .B1(
        mult_66_n164), .B2(mult_66_n200), .ZN(mult_66_n107) );
  XNOR2_X1 mult_66_U358 ( .A(u[7]), .B(b0[8]), .ZN(mult_66_n164) );
  INV_X1 mult_66_U357 ( .A(mult_66_n76), .ZN(mult_66_n77) );
  NOR2_X1 mult_66_U356 ( .A1(mult_66_n266), .A2(mult_66_n26), .ZN(mult_66_n21)
         );
  INV_X1 mult_66_U355 ( .A(mult_66_n266), .ZN(mult_66_n58) );
  OAI22_X1 mult_66_U354 ( .A1(mult_66_n160), .A2(mult_66_n199), .B1(
        mult_66_n246), .B2(mult_66_n195), .ZN(mult_66_n127) );
  OAI22_X1 mult_66_U353 ( .A1(mult_66_n245), .A2(mult_66_n199), .B1(
        mult_66_n249), .B2(mult_66_n195), .ZN(mult_66_n126) );
  INV_X1 mult_66_U352 ( .A(mult_66_n29), .ZN(mult_66_n28) );
  OAI22_X1 mult_66_U351 ( .A1(mult_66_n165), .A2(mult_66_n196), .B1(
        mult_66_n244), .B2(mult_66_n200), .ZN(mult_66_n131) );
  NAND2_X1 mult_66_U350 ( .A1(mult_66_n65), .A2(mult_66_n68), .ZN(mult_66_n17)
         );
  INV_X1 mult_66_U349 ( .A(mult_66_n107), .ZN(mult_66_n130) );
  OAI21_X1 mult_66_U348 ( .B1(mult_66_n32), .B2(mult_66_n30), .A(mult_66_n31), 
        .ZN(mult_66_n29) );
  XNOR2_X1 mult_66_U347 ( .A(mult_66_n25), .B(mult_66_n5), .ZN(mulb0[9]) );
  OAI22_X1 mult_66_U346 ( .A1(mult_66_n166), .A2(mult_66_n200), .B1(
        mult_66_n167), .B2(mult_66_n196), .ZN(mult_66_n133) );
  OAI22_X1 mult_66_U345 ( .A1(mult_66_n165), .A2(mult_66_n200), .B1(
        mult_66_n166), .B2(mult_66_n196), .ZN(mult_66_n132) );
  NAND2_X1 mult_66_U344 ( .A1(mult_66_n79), .A2(mult_66_n84), .ZN(mult_66_n27)
         );
  XNOR2_X1 mult_66_U343 ( .A(u[1]), .B(b0[10]), .ZN(mult_66_n161) );
  OAI22_X1 mult_66_U342 ( .A1(mult_66_n161), .A2(mult_66_n199), .B1(
        mult_66_n162), .B2(mult_66_n195), .ZN(mult_66_n128) );
  XNOR2_X1 mult_66_U341 ( .A(u[7]), .B(b0[6]), .ZN(mult_66_n173) );
  XNOR2_X1 mult_66_U340 ( .A(mult_66_n88), .B(mult_66_n118), .ZN(mult_66_n83)
         );
  XNOR2_X1 mult_66_U339 ( .A(u[3]), .B(b0[11]), .ZN(mult_66_n150) );
  XNOR2_X1 mult_66_U338 ( .A(u[1]), .B(b0[8]), .ZN(mult_66_n170) );
  XNOR2_X1 mult_66_U337 ( .A(u[1]), .B(b0[11]), .ZN(mult_66_n152) );
  XNOR2_X1 mult_66_U336 ( .A(mult_66_n248), .B(b0[6]), .ZN(mult_66_n179) );
  NAND2_X1 mult_66_U335 ( .A1(mult_66_n73), .A2(mult_66_n78), .ZN(mult_66_n24)
         );
  AOI21_X1 mult_66_U334 ( .B1(mult_66_n21), .B2(mult_66_n29), .A(mult_66_n22), 
        .ZN(mult_66_n1) );
  BUF_X1 mult_66_U333 ( .A(mult_66_n1), .Z(mult_66_n279) );
  OAI22_X1 mult_66_U332 ( .A1(mult_66_n156), .A2(mult_66_n199), .B1(
        mult_66_n237), .B2(mult_66_n195), .ZN(mult_66_n123) );
  NAND2_X1 mult_66_U331 ( .A1(mult_66_n90), .A2(mult_66_n85), .ZN(mult_66_n31)
         );
  XNOR2_X1 mult_66_U330 ( .A(mult_66_n250), .B(b0[8]), .ZN(mult_66_n168) );
  XNOR2_X1 mult_66_U329 ( .A(mult_66_n250), .B(b0[6]), .ZN(mult_66_n177) );
  XNOR2_X1 mult_66_U328 ( .A(mult_66_n250), .B(b0[10]), .ZN(mult_66_n159) );
  XNOR2_X1 mult_66_U327 ( .A(mult_66_n251), .B(b0[10]), .ZN(mult_66_n155) );
  INV_X1 mult_66_U326 ( .A(b0[11]), .ZN(mult_66_n202) );
  INV_X1 mult_66_U325 ( .A(b0[10]), .ZN(mult_66_n203) );
  INV_X1 mult_66_U324 ( .A(b0[6]), .ZN(mult_66_n205) );
  INV_X1 mult_66_U323 ( .A(b0[8]), .ZN(mult_66_n204) );
  XOR2_X1 mult_66_U322 ( .A(b0[5]), .B(b0[6]), .Z(mult_66_n193) );
  NAND2_X1 mult_66_U321 ( .A1(mult_66_n193), .A2(mult_66_n217), .ZN(
        mult_66_n197) );
  INV_X1 mult_66_U320 ( .A(b0[5]), .ZN(mult_66_n217) );
  XOR2_X1 mult_66_U319 ( .A(b0[9]), .B(b0[10]), .Z(mult_66_n191) );
  NAND2_X1 mult_66_U318 ( .A1(mult_66_n191), .A2(mult_66_n199), .ZN(
        mult_66_n195) );
  XOR2_X1 mult_66_U317 ( .A(b0[7]), .B(b0[8]), .Z(mult_66_n192) );
  NAND2_X1 mult_66_U316 ( .A1(mult_66_n192), .A2(mult_66_n200), .ZN(
        mult_66_n196) );
  XNOR2_X1 mult_66_U315 ( .A(u[0]), .B(b0[6]), .ZN(mult_66_n180) );
  NOR2_X1 mult_66_U314 ( .A1(mult_66_n148), .A2(mult_66_n198), .ZN(mult_66_n66) );
  XNOR2_X1 mult_66_U313 ( .A(u[0]), .B(b0[10]), .ZN(mult_66_n162) );
  NOR2_X1 mult_66_U312 ( .A1(mult_66_n149), .A2(mult_66_n198), .ZN(
        mult_66_n117) );
  XNOR2_X1 mult_66_U311 ( .A(u[0]), .B(b0[8]), .ZN(mult_66_n171) );
  NOR2_X1 mult_66_U310 ( .A1(mult_66_n151), .A2(mult_66_n198), .ZN(
        mult_66_n118) );
  OR2_X1 mult_66_U309 ( .A1(u[0]), .A2(mult_66_n205), .ZN(mult_66_n181) );
  INV_X1 mult_66_U308 ( .A(mult_66_n200), .ZN(mult_66_n108) );
  AND2_X1 mult_66_U307 ( .A1(u[0]), .A2(mult_66_n108), .ZN(mult_66_n138) );
  OR2_X1 mult_66_U306 ( .A1(u[0]), .A2(mult_66_n203), .ZN(mult_66_n163) );
  OAI22_X1 mult_66_U305 ( .A1(mult_66_n163), .A2(mult_66_n199), .B1(
        mult_66_n195), .B2(mult_66_n203), .ZN(mult_66_n113) );
  OR2_X1 mult_66_U304 ( .A1(u[0]), .A2(mult_66_n202), .ZN(mult_66_n154) );
  NOR2_X1 mult_66_U303 ( .A1(mult_66_n152), .A2(mult_66_n198), .ZN(
        mult_66_n119) );
  NOR2_X1 mult_66_U302 ( .A1(mult_66_n154), .A2(mult_66_n198), .ZN(
        mult_66_n112) );
  INV_X1 mult_66_U301 ( .A(mult_66_n198), .ZN(mult_66_n102) );
  AND2_X1 mult_66_U300 ( .A1(u[0]), .A2(mult_66_n102), .ZN(mult_66_n120) );
  OAI22_X1 mult_66_U299 ( .A1(mult_66_n167), .A2(mult_66_n200), .B1(
        mult_66_n168), .B2(mult_66_n196), .ZN(mult_66_n134) );
  INV_X1 mult_66_U298 ( .A(mult_66_n199), .ZN(mult_66_n105) );
  OAI22_X1 mult_66_U297 ( .A1(mult_66_n169), .A2(mult_66_n200), .B1(
        mult_66_n170), .B2(mult_66_n196), .ZN(mult_66_n136) );
  AND2_X1 mult_66_U296 ( .A1(u[0]), .A2(mult_66_n105), .ZN(mult_66_n129) );
  OAI22_X1 mult_66_U295 ( .A1(mult_66_n156), .A2(mult_66_n195), .B1(
        mult_66_n155), .B2(mult_66_n199), .ZN(mult_66_n122) );
  INV_X1 mult_66_U294 ( .A(mult_66_n66), .ZN(mult_66_n67) );
  OAI22_X1 mult_66_U293 ( .A1(mult_66_n168), .A2(mult_66_n200), .B1(
        mult_66_n242), .B2(mult_66_n196), .ZN(mult_66_n135) );
  XNOR2_X1 mult_66_U292 ( .A(mult_66_n104), .B(mult_66_n116), .ZN(mult_66_n62)
         );
  OR2_X1 mult_66_U291 ( .A1(u[0]), .A2(mult_66_n204), .ZN(mult_66_n172) );
  OAI22_X1 mult_66_U290 ( .A1(mult_66_n170), .A2(mult_66_n200), .B1(
        mult_66_n171), .B2(mult_66_n196), .ZN(mult_66_n137) );
  OAI22_X1 mult_66_U289 ( .A1(mult_66_n172), .A2(mult_66_n200), .B1(
        mult_66_n196), .B2(mult_66_n204), .ZN(mult_66_n114) );
  OAI22_X1 mult_66_U288 ( .A1(mult_66_n176), .A2(mult_66_n217), .B1(
        mult_66_n177), .B2(mult_66_n197), .ZN(mult_66_n143) );
  OAI22_X1 mult_66_U287 ( .A1(mult_66_n179), .A2(mult_66_n217), .B1(
        mult_66_n180), .B2(mult_66_n197), .ZN(mult_66_n146) );
  OAI22_X1 mult_66_U286 ( .A1(mult_66_n181), .A2(mult_66_n217), .B1(
        mult_66_n197), .B2(mult_66_n205), .ZN(mult_66_n115) );
  OAI22_X1 mult_66_U285 ( .A1(mult_66_n155), .A2(mult_66_n195), .B1(
        mult_66_n155), .B2(mult_66_n199), .ZN(mult_66_n104) );
  NAND2_X1 mult_66_U284 ( .A1(mult_66_n64), .A2(mult_66_n63), .ZN(mult_66_n10)
         );
  AND2_X1 mult_66_U283 ( .A1(mult_66_n99), .A2(mult_66_n143), .ZN(mult_66_n278) );
  OR2_X1 mult_66_U282 ( .A1(mult_66_n99), .A2(mult_66_n143), .ZN(mult_66_n277)
         );
  OR2_X1 mult_66_U281 ( .A1(mult_66_n64), .A2(mult_66_n63), .ZN(mult_66_n276)
         );
  OR2_X1 mult_66_U280 ( .A1(mult_66_n145), .A2(mult_66_n138), .ZN(mult_66_n275) );
  AND2_X1 mult_66_U279 ( .A1(mult_66_n145), .A2(mult_66_n138), .ZN(
        mult_66_n274) );
  NAND2_X1 mult_66_U278 ( .A1(mult_66_n69), .A2(mult_66_n72), .ZN(mult_66_n20)
         );
  NOR2_X1 mult_66_U277 ( .A1(mult_66_n144), .A2(mult_66_n101), .ZN(mult_66_n46) );
  NAND2_X1 mult_66_U276 ( .A1(mult_66_n144), .A2(mult_66_n101), .ZN(
        mult_66_n47) );
  AOI21_X1 mult_66_U275 ( .B1(mult_66_n275), .B2(mult_66_n270), .A(
        mult_66_n274), .ZN(mult_66_n48) );
  NOR2_X1 mult_66_U274 ( .A1(mult_66_n85), .A2(mult_66_n90), .ZN(mult_66_n30)
         );
  AOI21_X1 mult_66_U273 ( .B1(mult_66_n277), .B2(mult_66_n45), .A(mult_66_n278), .ZN(mult_66_n40) );
  NAND2_X1 mult_66_U272 ( .A1(mult_66_n95), .A2(mult_66_n98), .ZN(mult_66_n39)
         );
  OR2_X1 mult_66_U271 ( .A1(mult_66_n19), .A2(mult_66_n16), .ZN(mult_66_n272)
         );
  OAI21_X1 mult_66_U270 ( .B1(mult_66_n20), .B2(mult_66_n16), .A(mult_66_n17), 
        .ZN(mult_66_n15) );
  INV_X1 mult_66_U269 ( .A(mult_66_n15), .ZN(mult_66_n13) );
  NAND2_X1 mult_66_U268 ( .A1(mult_66_n276), .A2(mult_66_n10), .ZN(mult_66_n2)
         );
  NAND2_X1 mult_66_U267 ( .A1(mult_66_n58), .A2(mult_66_n258), .ZN(mult_66_n5)
         );
  XNOR2_X1 mult_66_U266 ( .A(mult_66_n279), .B(mult_66_n271), .ZN(mulb0[10])
         );
  INV_X1 mult_66_U265 ( .A(mult_66_n26), .ZN(mult_66_n59) );
  INV_X1 mult_66_U264 ( .A(mult_66_n16), .ZN(mult_66_n56) );
  NAND2_X1 mult_66_U263 ( .A1(mult_66_n56), .A2(mult_66_n17), .ZN(mult_66_n3)
         );
  NAND2_X1 mult_66_U262 ( .A1(mult_66_n36), .A2(mult_66_n273), .ZN(mult_66_n8)
         );
  AND2_X1 mult_66_U261 ( .A1(mult_66_n146), .A2(mult_66_n115), .ZN(
        mult_66_n270) );
  NOR2_X1 mult_66_U260 ( .A1(mult_66_n147), .A2(mult_66_n198), .ZN(
        mult_66_n116) );
  OAI21_X1 mult_66_U259 ( .B1(mult_66_n46), .B2(mult_66_n48), .A(mult_66_n47), 
        .ZN(mult_66_n45) );
  AND2_X1 mult_66_U258 ( .A1(mult_66_n57), .A2(mult_66_n20), .ZN(mult_66_n271)
         );
  NOR2_X2 mult_66_U257 ( .A1(mult_66_n150), .A2(mult_66_n198), .ZN(mult_66_n76) );
  NAND3_X1 mult_66_U256 ( .A1(mult_66_n267), .A2(mult_66_n268), .A3(
        mult_66_n269), .ZN(mult_66_n78) );
  NAND2_X1 mult_66_U255 ( .A1(mult_66_n264), .A2(mult_66_n132), .ZN(
        mult_66_n269) );
  NAND2_X1 mult_66_U254 ( .A1(mult_66_n81), .A2(mult_66_n132), .ZN(
        mult_66_n268) );
  NAND2_X1 mult_66_U253 ( .A1(mult_66_n81), .A2(mult_66_n264), .ZN(
        mult_66_n267) );
  NOR2_X1 mult_66_U252 ( .A1(mult_66_n73), .A2(mult_66_n78), .ZN(mult_66_n23)
         );
  NOR2_X1 mult_66_U251 ( .A1(mult_66_n73), .A2(mult_66_n78), .ZN(mult_66_n266)
         );
  OR2_X1 mult_66_U250 ( .A1(mult_66_n85), .A2(mult_66_n90), .ZN(mult_66_n265)
         );
  AOI21_X1 mult_66_U249 ( .B1(mult_66_n273), .B2(mult_66_n37), .A(mult_66_n256), .ZN(mult_66_n32) );
  CLKBUF_X1 mult_66_U248 ( .A(mult_66_n86), .Z(mult_66_n264) );
  CLKBUF_X1 mult_66_U247 ( .A(u[5]), .Z(mult_66_n263) );
  NOR2_X1 mult_66_U246 ( .A1(mult_66_n79), .A2(mult_66_n84), .ZN(mult_66_n26)
         );
  NAND3_X1 mult_66_U245 ( .A1(mult_66_n260), .A2(mult_66_n261), .A3(
        mult_66_n262), .ZN(mult_66_n84) );
  NAND2_X1 mult_66_U244 ( .A1(mult_66_n140), .A2(mult_66_n92), .ZN(
        mult_66_n262) );
  NAND2_X1 mult_66_U243 ( .A1(mult_66_n87), .A2(mult_66_n92), .ZN(mult_66_n261) );
  NAND2_X1 mult_66_U242 ( .A1(mult_66_n87), .A2(mult_66_n140), .ZN(
        mult_66_n260) );
  BUF_X1 mult_66_U241 ( .A(u[6]), .Z(mult_66_n259) );
  BUF_X1 mult_66_U240 ( .A(u[2]), .Z(mult_66_n257) );
  OR2_X2 mult_66_U239 ( .A1(mult_66_n118), .A2(mult_66_n88), .ZN(mult_66_n82)
         );
  XNOR2_X1 mult_66_U238 ( .A(mult_66_n86), .B(mult_66_n132), .ZN(mult_66_n254)
         );
  XNOR2_X1 mult_66_U237 ( .A(mult_66_n254), .B(mult_66_n81), .ZN(mult_66_n79)
         );
  CLKBUF_X1 mult_66_U236 ( .A(mult_66_n24), .Z(mult_66_n258) );
  XNOR2_X1 mult_66_U235 ( .A(u[7]), .B(b0[6]), .ZN(mult_66_n253) );
  CLKBUF_X1 mult_66_U234 ( .A(u[4]), .Z(mult_66_n252) );
  CLKBUF_X1 mult_66_U233 ( .A(u[2]), .Z(mult_66_n255) );
  CLKBUF_X1 mult_66_U232 ( .A(u[7]), .Z(mult_66_n251) );
  CLKBUF_X1 mult_66_U231 ( .A(mult_66_n160), .Z(mult_66_n249) );
  CLKBUF_X1 mult_66_U230 ( .A(mult_66_n241), .Z(mult_66_n248) );
  XNOR2_X1 mult_66_U229 ( .A(mult_66_n140), .B(mult_66_n92), .ZN(mult_66_n247)
         );
  XNOR2_X1 mult_66_U228 ( .A(mult_66_n87), .B(mult_66_n247), .ZN(mult_66_n85)
         );
  XNOR2_X1 mult_66_U227 ( .A(mult_66_n241), .B(b0[10]), .ZN(mult_66_n246) );
  AND2_X1 mult_66_U226 ( .A1(mult_66_n91), .A2(mult_66_n94), .ZN(mult_66_n256)
         );
  INV_X1 mult_66_U225 ( .A(mult_66_n256), .ZN(mult_66_n36) );
  OAI21_X2 mult_66_U224 ( .B1(mult_66_n38), .B2(mult_66_n40), .A(mult_66_n39), 
        .ZN(mult_66_n37) );
  BUF_X2 mult_66_U223 ( .A(u[3]), .Z(mult_66_n250) );
  XNOR2_X1 mult_66_U222 ( .A(mult_66_n250), .B(b0[10]), .ZN(mult_66_n245) );
  BUF_X1 mult_66_U221 ( .A(mult_66_n164), .Z(mult_66_n244) );
  XNOR2_X1 mult_66_U220 ( .A(u[4]), .B(b0[10]), .ZN(mult_66_n243) );
  CLKBUF_X1 mult_66_U219 ( .A(mult_66_n169), .Z(mult_66_n242) );
  BUF_X1 mult_66_U218 ( .A(u[1]), .Z(mult_66_n241) );
  AOI21_X1 mult_66_U217 ( .B1(mult_66_n273), .B2(mult_66_n37), .A(mult_66_n256), .ZN(mult_66_n240) );
  AND2_X1 mult_66_U216 ( .A1(mult_66_n265), .A2(mult_66_n31), .ZN(mult_66_n239) );
  XNOR2_X1 mult_66_U215 ( .A(mult_66_n239), .B(mult_66_n240), .ZN(mulb0[7]) );
  AND2_X1 mult_66_U214 ( .A1(mult_66_n59), .A2(mult_66_n27), .ZN(mult_66_n238)
         );
  XNOR2_X1 mult_66_U213 ( .A(mult_66_n28), .B(mult_66_n238), .ZN(mulb0[8]) );
  INV_X1 mult_66_U212 ( .A(mult_66_n19), .ZN(mult_66_n57) );
  XNOR2_X1 mult_66_U211 ( .A(b0[7]), .B(b0[6]), .ZN(mult_66_n200) );
  NOR2_X1 mult_66_U210 ( .A1(mult_66_n65), .A2(mult_66_n68), .ZN(mult_66_n16)
         );
  XNOR2_X1 mult_66_U209 ( .A(b0[9]), .B(b0[8]), .ZN(mult_66_n199) );
  OAI22_X1 mult_66_U208 ( .A1(mult_66_n177), .A2(mult_66_n217), .B1(
        mult_66_n178), .B2(mult_66_n197), .ZN(mult_66_n144) );
  XNOR2_X1 mult_66_U207 ( .A(b0[11]), .B(b0[10]), .ZN(mult_66_n198) );
  NOR2_X1 mult_66_U206 ( .A1(mult_66_n69), .A2(mult_66_n72), .ZN(mult_66_n19)
         );
  XNOR2_X1 mult_66_U205 ( .A(mult_66_n263), .B(b0[10]), .ZN(mult_66_n237) );
  OR2_X2 mult_66_U204 ( .A1(mult_66_n91), .A2(mult_66_n94), .ZN(mult_66_n273)
         );
  HA_X1 mult_66_U90 ( .A(mult_66_n137), .B(mult_66_n114), .CO(mult_66_n100), 
        .S(mult_66_n101) );
  FA_X1 mult_66_U89 ( .A(mult_66_n100), .B(mult_66_n129), .CI(mult_66_n136), 
        .CO(mult_66_n98), .S(mult_66_n99) );
  HA_X1 mult_66_U88 ( .A(mult_66_n128), .B(mult_66_n113), .CO(mult_66_n96), 
        .S(mult_66_n97) );
  FA_X1 mult_66_U87 ( .A(mult_66_n142), .B(mult_66_n97), .CI(mult_66_n135), 
        .CO(mult_66_n94), .S(mult_66_n95) );
  FA_X1 mult_66_U86 ( .A(mult_66_n127), .B(mult_66_n120), .CI(mult_66_n96), 
        .CO(mult_66_n92), .S(mult_66_n93) );
  FA_X1 mult_66_U85 ( .A(mult_66_n141), .B(mult_66_n134), .CI(mult_66_n93), 
        .CO(mult_66_n90), .S(mult_66_n91) );
  HA_X1 mult_66_U84 ( .A(mult_66_n119), .B(mult_66_n112), .CO(mult_66_n88), 
        .S(mult_66_n89) );
  FA_X1 mult_66_U83 ( .A(mult_66_n126), .B(mult_66_n89), .CI(mult_66_n133), 
        .CO(mult_66_n86), .S(mult_66_n87) );
  FA_X1 mult_66_U79 ( .A(mult_66_n83), .B(mult_66_n125), .CI(mult_66_n139), 
        .CO(mult_66_n80), .S(mult_66_n81) );
  FA_X1 mult_66_U76 ( .A(mult_66_n77), .B(mult_66_n82), .CI(mult_66_n124), 
        .CO(mult_66_n74), .S(mult_66_n75) );
  FA_X1 mult_66_U75 ( .A(mult_66_n80), .B(mult_66_n131), .CI(mult_66_n75), 
        .CO(mult_66_n72), .S(mult_66_n73) );
  FA_X1 mult_66_U74 ( .A(mult_66_n117), .B(mult_66_n76), .CI(mult_66_n130), 
        .CO(mult_66_n70), .S(mult_66_n71) );
  FA_X1 mult_66_U73 ( .A(mult_66_n74), .B(mult_66_n123), .CI(mult_66_n71), 
        .CO(mult_66_n68), .S(mult_66_n69) );
  FA_X1 mult_66_U71 ( .A(mult_66_n67), .B(mult_66_n122), .CI(mult_66_n70), 
        .CO(mult_66_n64), .S(mult_66_n65) );
  XOR2_X1 mult_66_U69 ( .A(mult_66_n66), .B(mult_66_n62), .Z(mult_66_n63) );
endmodule

