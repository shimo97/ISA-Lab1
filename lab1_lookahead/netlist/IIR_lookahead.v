/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Mon Nov 15 14:51:54 2021
/////////////////////////////////////////////////////////////


module IIR_lookahead ( CLK, RST_n, DIN, VIN, b0, b1, b2, a1, DOUT, VOUT );
  input [11:0] DIN;
  input [11:0] b0;
  input [11:0] b1;
  input [11:0] b2;
  input [11:0] a1;
  output [11:0] DOUT;
  input CLK, RST_n, VIN;
  output VOUT;
  wire   q1, q2, q3, n7, n8, regX0_n21, regX0_n20, regX0_n19, regX0_n18,
         regX0_n17, regX0_n16, regX0_n15, regX0_n14, regX0_n13, regX0_n12,
         regX0_n11, regX0_n10, regX0_n9, regX0_n8, regX0_n7, regX0_n6,
         regX0_n5, regX0_n4, regX0_n3, regX0_n2, regX0_n1, regU_n24, regU_n23,
         regU_n22, regU_n21, regU_n20, regU_n19, regU_n18, regU_n17, regU_n16,
         regU_n15, regU_n14, regU_n13, regU_n12, regU_n11, regU_n10, regU_n9,
         regU_n8, regU_n7, regU_n6, regU_n5, regU_n4, regU_n3, regU_n2,
         regU_n1, rega1_n44, rega1_n43, rega1_n42, rega1_n41, rega1_n40,
         rega1_n39, rega1_n38, rega1_n37, rega1_n36, rega1_n35, rega1_n34,
         rega1_n33, rega1_n32, rega1_n31, rega1_n30, rega1_n29, rega1_n28,
         rega1_n27, rega1_n26, rega1_n25, rega1_n24, rega1_n23, rega1_n22,
         regb0_n44, regb0_n43, regb0_n42, regb0_n41, regb0_n40, regb0_n39,
         regb0_n38, regb0_n37, regb0_n36, regb0_n35, regb0_n34, regb0_n33,
         regb0_n32, regb0_n31, regb0_n30, regb0_n29, regb0_n28, regb0_n27,
         regb0_n26, regb0_n25, regb0_n24, regb0_n23, regb0_n22, regb1_n44,
         regb1_n43, regb1_n42, regb1_n41, regb1_n40, regb1_n39, regb1_n38,
         regb1_n37, regb1_n36, regb1_n35, regb1_n34, regb1_n33, regb1_n32,
         regb1_n31, regb1_n30, regb1_n29, regb1_n28, regb1_n27, regb1_n26,
         regb1_n25, regb1_n24, regb1_n23, regb1_n22, regU2_n50, regU2_n49,
         regU2_n48, regU2_n47, regU2_n46, regU2_n45, regU2_n44, regU2_n43,
         regU2_n42, regU2_n41, regU2_n40, regU2_n39, regU2_n38, regU2_n37,
         regU2_n36, regU2_n35, regU2_n34, regU2_n33, regU2_n32, regU2_n31,
         regU2_n30, regU2_n29, regU2_n28, regU2_n27, regU2_n26, regU2_n25,
         regb2_n44, regb2_n43, regb2_n42, regb2_n41, regb2_n40, regb2_n39,
         regb2_n38, regb2_n37, regb2_n36, regb2_n35, regb2_n34, regb2_n33,
         regb2_n32, regb2_n31, regb2_n30, regb2_n29, regb2_n28, regb2_n27,
         regb2_n26, regb2_n25, regb2_n24, regb2_n23, regb2_n22, regsum_n44,
         regsum_n43, regsum_n42, regsum_n41, regsum_n40, regsum_n39,
         regsum_n38, regsum_n37, regsum_n36, regsum_n35, regsum_n34,
         regsum_n33, regsum_n32, regsum_n31, regsum_n30, regsum_n29,
         regsum_n28, regsum_n27, regsum_n26, regsum_n25, regsum_n24,
         regsum_n23, regsum_n22, regY_n50, regY_n49, regY_n48, regY_n47,
         regY_n46, regY_n45, regY_n44, regY_n43, regY_n42, regY_n41, regY_n40,
         regY_n39, regY_n38, regY_n37, regY_n36, regY_n35, regY_n34, regY_n33,
         regY_n32, regY_n31, regY_n30, regY_n29, regY_n28, regY_n27, regY_n26,
         regY_n25, add_96_n2, add_90_n2, add_60_n2, mult_85_n208, mult_85_n207,
         mult_85_n206, mult_85_n205, mult_85_n204, mult_85_n203, mult_85_n202,
         mult_85_n201, mult_85_n200, mult_85_n199, mult_85_n198, mult_85_n197,
         mult_85_n196, mult_85_n195, mult_85_n194, mult_85_n193, mult_85_n192,
         mult_85_n191, mult_85_n190, mult_85_n189, mult_85_n188, mult_85_n187,
         mult_85_n186, mult_85_n185, mult_85_n184, mult_85_n183, mult_85_n182,
         mult_85_n181, mult_85_n180, mult_85_n179, mult_85_n136, mult_85_n135,
         mult_85_n134, mult_85_n133, mult_85_n131, mult_85_n129, mult_85_n128,
         mult_85_n127, mult_85_n126, mult_85_n125, mult_85_n124, mult_85_n123,
         mult_85_n121, mult_85_n120, mult_85_n119, mult_85_n118, mult_85_n117,
         mult_85_n116, mult_85_n115, mult_85_n114, mult_85_n113, mult_85_n112,
         mult_85_n111, mult_85_n110, mult_85_n109, mult_85_n108, mult_85_n107,
         mult_85_n106, mult_85_n105, mult_85_n103, mult_85_n102, mult_85_n101,
         mult_85_n100, mult_85_n99, mult_85_n98, mult_85_n97, mult_85_n96,
         mult_85_n95, mult_85_n94, mult_85_n93, mult_85_n91, mult_85_n90,
         mult_85_n89, mult_85_n88, mult_85_n87, mult_85_n86, mult_85_n84,
         mult_85_n83, mult_85_n82, mult_85_n81, mult_85_n80, mult_85_n79,
         mult_85_n78, mult_85_n77, mult_85_n76, mult_85_n75, mult_85_n74,
         mult_85_n73, mult_85_n72, mult_85_n71, mult_85_n70, mult_85_n69,
         mult_85_n68, mult_85_n67, mult_85_n66, mult_85_n65, mult_85_n64,
         mult_85_n63, mult_85_n62, mult_85_n61, mult_85_n60, mult_85_n59,
         mult_85_n58, mult_85_n57, mult_85_n56, mult_85_n55, mult_85_n54,
         mult_85_n52, mult_85_n51, mult_85_n50, mult_85_n49, mult_85_n48,
         mult_85_n47, mult_85_n46, mult_85_n45, mult_85_n44, mult_85_n43,
         mult_85_n42, mult_85_n41, mult_85_n40, mult_85_n39, mult_85_n38,
         mult_85_n37, mult_85_n36, mult_85_n35, mult_85_n34, mult_85_n33,
         mult_85_n32, mult_85_n31, mult_85_n30, mult_85_n29, mult_85_n28,
         mult_85_n27, mult_85_n26, mult_85_n25, mult_85_n24, mult_85_n23,
         mult_85_n22, mult_85_n21, mult_85_n20, mult_85_n19, mult_85_n18,
         mult_85_n17, mult_85_n16, mult_85_n15, mult_85_n8, mult_85_n7,
         mult_85_n6, mult_85_n5, mult_85_n4, mult_85_n3, mult_85_n2,
         mult_78_n208, mult_78_n207, mult_78_n206, mult_78_n205, mult_78_n204,
         mult_78_n203, mult_78_n202, mult_78_n201, mult_78_n200, mult_78_n199,
         mult_78_n198, mult_78_n197, mult_78_n196, mult_78_n195, mult_78_n194,
         mult_78_n193, mult_78_n192, mult_78_n191, mult_78_n190, mult_78_n189,
         mult_78_n188, mult_78_n187, mult_78_n186, mult_78_n185, mult_78_n184,
         mult_78_n183, mult_78_n182, mult_78_n181, mult_78_n180, mult_78_n179,
         mult_78_n136, mult_78_n135, mult_78_n134, mult_78_n133, mult_78_n131,
         mult_78_n129, mult_78_n128, mult_78_n127, mult_78_n126, mult_78_n125,
         mult_78_n124, mult_78_n123, mult_78_n121, mult_78_n120, mult_78_n119,
         mult_78_n118, mult_78_n117, mult_78_n116, mult_78_n115, mult_78_n114,
         mult_78_n113, mult_78_n112, mult_78_n111, mult_78_n110, mult_78_n109,
         mult_78_n108, mult_78_n107, mult_78_n106, mult_78_n105, mult_78_n103,
         mult_78_n102, mult_78_n101, mult_78_n100, mult_78_n99, mult_78_n98,
         mult_78_n97, mult_78_n96, mult_78_n95, mult_78_n94, mult_78_n93,
         mult_78_n91, mult_78_n90, mult_78_n89, mult_78_n88, mult_78_n87,
         mult_78_n86, mult_78_n84, mult_78_n83, mult_78_n82, mult_78_n81,
         mult_78_n80, mult_78_n79, mult_78_n78, mult_78_n77, mult_78_n76,
         mult_78_n75, mult_78_n74, mult_78_n73, mult_78_n72, mult_78_n71,
         mult_78_n70, mult_78_n69, mult_78_n68, mult_78_n67, mult_78_n66,
         mult_78_n65, mult_78_n64, mult_78_n63, mult_78_n62, mult_78_n61,
         mult_78_n60, mult_78_n59, mult_78_n58, mult_78_n57, mult_78_n56,
         mult_78_n55, mult_78_n54, mult_78_n52, mult_78_n51, mult_78_n50,
         mult_78_n49, mult_78_n48, mult_78_n47, mult_78_n46, mult_78_n45,
         mult_78_n44, mult_78_n43, mult_78_n42, mult_78_n41, mult_78_n40,
         mult_78_n39, mult_78_n38, mult_78_n37, mult_78_n36, mult_78_n35,
         mult_78_n34, mult_78_n33, mult_78_n32, mult_78_n31, mult_78_n30,
         mult_78_n29, mult_78_n28, mult_78_n27, mult_78_n26, mult_78_n25,
         mult_78_n24, mult_78_n23, mult_78_n22, mult_78_n21, mult_78_n20,
         mult_78_n19, mult_78_n18, mult_78_n17, mult_78_n16, mult_78_n15,
         mult_78_n8, mult_78_n7, mult_78_n6, mult_78_n5, mult_78_n4,
         mult_78_n3, mult_78_n2, mult_73_n208, mult_73_n207, mult_73_n206,
         mult_73_n205, mult_73_n204, mult_73_n203, mult_73_n202, mult_73_n201,
         mult_73_n200, mult_73_n199, mult_73_n198, mult_73_n197, mult_73_n196,
         mult_73_n195, mult_73_n194, mult_73_n193, mult_73_n192, mult_73_n191,
         mult_73_n190, mult_73_n189, mult_73_n188, mult_73_n187, mult_73_n186,
         mult_73_n185, mult_73_n184, mult_73_n183, mult_73_n182, mult_73_n181,
         mult_73_n180, mult_73_n179, mult_73_n136, mult_73_n135, mult_73_n134,
         mult_73_n133, mult_73_n131, mult_73_n129, mult_73_n128, mult_73_n127,
         mult_73_n126, mult_73_n125, mult_73_n124, mult_73_n123, mult_73_n121,
         mult_73_n120, mult_73_n119, mult_73_n118, mult_73_n117, mult_73_n116,
         mult_73_n115, mult_73_n114, mult_73_n113, mult_73_n112, mult_73_n111,
         mult_73_n110, mult_73_n109, mult_73_n108, mult_73_n107, mult_73_n106,
         mult_73_n105, mult_73_n103, mult_73_n102, mult_73_n101, mult_73_n100,
         mult_73_n99, mult_73_n98, mult_73_n97, mult_73_n96, mult_73_n95,
         mult_73_n94, mult_73_n93, mult_73_n91, mult_73_n90, mult_73_n89,
         mult_73_n88, mult_73_n87, mult_73_n86, mult_73_n84, mult_73_n83,
         mult_73_n82, mult_73_n81, mult_73_n80, mult_73_n79, mult_73_n78,
         mult_73_n77, mult_73_n76, mult_73_n75, mult_73_n74, mult_73_n73,
         mult_73_n72, mult_73_n71, mult_73_n70, mult_73_n69, mult_73_n68,
         mult_73_n67, mult_73_n66, mult_73_n65, mult_73_n64, mult_73_n63,
         mult_73_n62, mult_73_n61, mult_73_n60, mult_73_n59, mult_73_n58,
         mult_73_n57, mult_73_n56, mult_73_n55, mult_73_n54, mult_73_n52,
         mult_73_n51, mult_73_n50, mult_73_n49, mult_73_n48, mult_73_n47,
         mult_73_n46, mult_73_n45, mult_73_n44, mult_73_n43, mult_73_n42,
         mult_73_n41, mult_73_n40, mult_73_n39, mult_73_n38, mult_73_n37,
         mult_73_n36, mult_73_n35, mult_73_n34, mult_73_n33, mult_73_n32,
         mult_73_n31, mult_73_n30, mult_73_n29, mult_73_n28, mult_73_n27,
         mult_73_n26, mult_73_n25, mult_73_n24, mult_73_n23, mult_73_n22,
         mult_73_n21, mult_73_n20, mult_73_n19, mult_73_n18, mult_73_n17,
         mult_73_n16, mult_73_n15, mult_73_n8, mult_73_n7, mult_73_n6,
         mult_73_n5, mult_73_n4, mult_73_n3, mult_73_n2, mult_68_n208,
         mult_68_n207, mult_68_n206, mult_68_n205, mult_68_n204, mult_68_n203,
         mult_68_n202, mult_68_n201, mult_68_n200, mult_68_n199, mult_68_n198,
         mult_68_n197, mult_68_n196, mult_68_n195, mult_68_n194, mult_68_n193,
         mult_68_n192, mult_68_n191, mult_68_n190, mult_68_n189, mult_68_n188,
         mult_68_n187, mult_68_n186, mult_68_n185, mult_68_n184, mult_68_n183,
         mult_68_n182, mult_68_n181, mult_68_n180, mult_68_n179, mult_68_n136,
         mult_68_n135, mult_68_n134, mult_68_n133, mult_68_n131, mult_68_n129,
         mult_68_n128, mult_68_n127, mult_68_n126, mult_68_n125, mult_68_n124,
         mult_68_n123, mult_68_n121, mult_68_n120, mult_68_n119, mult_68_n118,
         mult_68_n117, mult_68_n116, mult_68_n115, mult_68_n114, mult_68_n113,
         mult_68_n112, mult_68_n111, mult_68_n110, mult_68_n109, mult_68_n108,
         mult_68_n107, mult_68_n106, mult_68_n105, mult_68_n103, mult_68_n102,
         mult_68_n101, mult_68_n100, mult_68_n99, mult_68_n98, mult_68_n97,
         mult_68_n96, mult_68_n95, mult_68_n94, mult_68_n93, mult_68_n91,
         mult_68_n90, mult_68_n89, mult_68_n88, mult_68_n87, mult_68_n86,
         mult_68_n84, mult_68_n83, mult_68_n82, mult_68_n81, mult_68_n80,
         mult_68_n79, mult_68_n78, mult_68_n77, mult_68_n76, mult_68_n75,
         mult_68_n74, mult_68_n73, mult_68_n72, mult_68_n71, mult_68_n70,
         mult_68_n69, mult_68_n68, mult_68_n67, mult_68_n66, mult_68_n65,
         mult_68_n64, mult_68_n63, mult_68_n62, mult_68_n61, mult_68_n60,
         mult_68_n59, mult_68_n58, mult_68_n57, mult_68_n56, mult_68_n55,
         mult_68_n54, mult_68_n52, mult_68_n51, mult_68_n50, mult_68_n49,
         mult_68_n48, mult_68_n47, mult_68_n46, mult_68_n45, mult_68_n44,
         mult_68_n43, mult_68_n42, mult_68_n41, mult_68_n40, mult_68_n39,
         mult_68_n38, mult_68_n37, mult_68_n36, mult_68_n35, mult_68_n34,
         mult_68_n33, mult_68_n32, mult_68_n31, mult_68_n30, mult_68_n29,
         mult_68_n28, mult_68_n27, mult_68_n26, mult_68_n25, mult_68_n24,
         mult_68_n23, mult_68_n22, mult_68_n21, mult_68_n20, mult_68_n19,
         mult_68_n18, mult_68_n17, mult_68_n16, mult_68_n15, mult_68_n8,
         mult_68_n7, mult_68_n6, mult_68_n5, mult_68_n4, mult_68_n3,
         mult_68_n2;
  wire   [6:0] din_del;
  wire   [7:0] u;
  wire   [7:0] u_del_vec;
  wire   [12:6] mula1;
  wire   [6:0] t_mula1_del_vec;
  wire   [12:6] mulb0;
  wire   [6:0] t_mulb0_del_vec;
  wire   [12:6] mulb1;
  wire   [6:0] t_mulb1_del_vec;
  wire   [7:0] u_del_vec2;
  wire   [12:6] mulb2;
  wire   [6:0] t_mulb2_del_vec;
  wire   [6:0] sum1;
  wire   [6:0] sum1_del_vec;
  wire   [7:0] y;
  wire   [7:2] add_96_carry;
  wire   [6:2] add_90_carry;
  wire   [7:2] add_60_carry;
  assign DOUT[0] = 1'b0;
  assign DOUT[1] = 1'b0;
  assign DOUT[2] = 1'b0;
  assign DOUT[3] = 1'b0;

  BUF_X1 U8 ( .A(q3), .Z(n7) );
  BUF_X1 U9 ( .A(q2), .Z(n8) );
  NAND2_X1 regX0_U15 ( .A1(VIN), .A2(DIN[5]), .ZN(regX0_n1) );
  OAI21_X1 regX0_U14 ( .B1(regX0_n8), .B2(VIN), .A(regX0_n1), .ZN(regX0_n15)
         );
  NAND2_X1 regX0_U13 ( .A1(DIN[11]), .A2(VIN), .ZN(regX0_n7) );
  OAI21_X1 regX0_U12 ( .B1(regX0_n14), .B2(VIN), .A(regX0_n7), .ZN(regX0_n21)
         );
  NAND2_X1 regX0_U11 ( .A1(DIN[10]), .A2(VIN), .ZN(regX0_n6) );
  OAI21_X1 regX0_U10 ( .B1(regX0_n13), .B2(VIN), .A(regX0_n6), .ZN(regX0_n20)
         );
  NAND2_X1 regX0_U9 ( .A1(DIN[9]), .A2(VIN), .ZN(regX0_n5) );
  OAI21_X1 regX0_U8 ( .B1(regX0_n12), .B2(VIN), .A(regX0_n5), .ZN(regX0_n19)
         );
  NAND2_X1 regX0_U7 ( .A1(DIN[8]), .A2(VIN), .ZN(regX0_n4) );
  OAI21_X1 regX0_U6 ( .B1(regX0_n11), .B2(VIN), .A(regX0_n4), .ZN(regX0_n18)
         );
  NAND2_X1 regX0_U5 ( .A1(DIN[7]), .A2(VIN), .ZN(regX0_n3) );
  OAI21_X1 regX0_U4 ( .B1(regX0_n10), .B2(VIN), .A(regX0_n3), .ZN(regX0_n17)
         );
  NAND2_X1 regX0_U3 ( .A1(DIN[6]), .A2(VIN), .ZN(regX0_n2) );
  OAI21_X1 regX0_U2 ( .B1(regX0_n9), .B2(VIN), .A(regX0_n2), .ZN(regX0_n16) );
  DFFR_X1 regX0_Q_reg_0_ ( .D(regX0_n15), .CK(CLK), .RN(RST_n), .Q(din_del[0]), 
        .QN(regX0_n8) );
  DFFR_X1 regX0_Q_reg_1_ ( .D(regX0_n16), .CK(CLK), .RN(RST_n), .Q(din_del[1]), 
        .QN(regX0_n9) );
  DFFR_X1 regX0_Q_reg_2_ ( .D(regX0_n17), .CK(CLK), .RN(RST_n), .Q(din_del[2]), 
        .QN(regX0_n10) );
  DFFR_X1 regX0_Q_reg_3_ ( .D(regX0_n18), .CK(CLK), .RN(RST_n), .Q(din_del[3]), 
        .QN(regX0_n11) );
  DFFR_X1 regX0_Q_reg_4_ ( .D(regX0_n19), .CK(CLK), .RN(RST_n), .Q(din_del[4]), 
        .QN(regX0_n12) );
  DFFR_X1 regX0_Q_reg_5_ ( .D(regX0_n20), .CK(CLK), .RN(RST_n), .Q(din_del[5]), 
        .QN(regX0_n13) );
  DFFR_X1 regX0_Q_reg_6_ ( .D(regX0_n21), .CK(CLK), .RN(RST_n), .Q(din_del[6]), 
        .QN(regX0_n14) );
  NAND2_X1 regU_U17 ( .A1(u[4]), .A2(q1), .ZN(regU_n5) );
  OAI21_X1 regU_U16 ( .B1(regU_n13), .B2(q1), .A(regU_n5), .ZN(regU_n21) );
  NAND2_X1 regU_U15 ( .A1(u[3]), .A2(q1), .ZN(regU_n4) );
  OAI21_X1 regU_U14 ( .B1(regU_n12), .B2(q1), .A(regU_n4), .ZN(regU_n20) );
  NAND2_X1 regU_U13 ( .A1(u[2]), .A2(q1), .ZN(regU_n3) );
  OAI21_X1 regU_U12 ( .B1(regU_n11), .B2(q1), .A(regU_n3), .ZN(regU_n19) );
  NAND2_X1 regU_U11 ( .A1(u[1]), .A2(q1), .ZN(regU_n2) );
  OAI21_X1 regU_U10 ( .B1(regU_n10), .B2(q1), .A(regU_n2), .ZN(regU_n18) );
  NAND2_X1 regU_U9 ( .A1(q1), .A2(u[0]), .ZN(regU_n1) );
  OAI21_X1 regU_U8 ( .B1(regU_n9), .B2(q1), .A(regU_n1), .ZN(regU_n17) );
  NAND2_X1 regU_U7 ( .A1(u[7]), .A2(q1), .ZN(regU_n8) );
  OAI21_X1 regU_U6 ( .B1(regU_n16), .B2(q1), .A(regU_n8), .ZN(regU_n24) );
  NAND2_X1 regU_U5 ( .A1(u[6]), .A2(q1), .ZN(regU_n7) );
  OAI21_X1 regU_U4 ( .B1(regU_n15), .B2(q1), .A(regU_n7), .ZN(regU_n23) );
  NAND2_X1 regU_U3 ( .A1(u[5]), .A2(q1), .ZN(regU_n6) );
  OAI21_X1 regU_U2 ( .B1(regU_n14), .B2(q1), .A(regU_n6), .ZN(regU_n22) );
  DFFR_X1 regU_Q_reg_0_ ( .D(regU_n17), .CK(CLK), .RN(RST_n), .Q(u_del_vec[0]), 
        .QN(regU_n9) );
  DFFR_X1 regU_Q_reg_1_ ( .D(regU_n18), .CK(CLK), .RN(RST_n), .Q(u_del_vec[1]), 
        .QN(regU_n10) );
  DFFR_X1 regU_Q_reg_2_ ( .D(regU_n19), .CK(CLK), .RN(RST_n), .Q(u_del_vec[2]), 
        .QN(regU_n11) );
  DFFR_X1 regU_Q_reg_3_ ( .D(regU_n20), .CK(CLK), .RN(RST_n), .Q(u_del_vec[3]), 
        .QN(regU_n12) );
  DFFR_X1 regU_Q_reg_4_ ( .D(regU_n21), .CK(CLK), .RN(RST_n), .Q(u_del_vec[4]), 
        .QN(regU_n13) );
  DFFR_X1 regU_Q_reg_5_ ( .D(regU_n22), .CK(CLK), .RN(RST_n), .Q(u_del_vec[5]), 
        .QN(regU_n14) );
  DFFR_X1 regU_Q_reg_6_ ( .D(regU_n23), .CK(CLK), .RN(RST_n), .Q(u_del_vec[6]), 
        .QN(regU_n15) );
  DFFR_X1 regU_Q_reg_7_ ( .D(regU_n24), .CK(CLK), .RN(RST_n), .Q(u_del_vec[7]), 
        .QN(regU_n16) );
  NAND2_X1 rega1_U17 ( .A1(mula1[11]), .A2(rega1_n22), .ZN(rega1_n39) );
  OAI21_X1 rega1_U16 ( .B1(rega1_n32), .B2(rega1_n23), .A(rega1_n39), .ZN(
        rega1_n25) );
  NAND2_X1 rega1_U15 ( .A1(mula1[10]), .A2(rega1_n22), .ZN(rega1_n40) );
  OAI21_X1 rega1_U14 ( .B1(rega1_n33), .B2(rega1_n22), .A(rega1_n40), .ZN(
        rega1_n26) );
  NAND2_X1 rega1_U13 ( .A1(mula1[9]), .A2(rega1_n22), .ZN(rega1_n41) );
  OAI21_X1 rega1_U12 ( .B1(rega1_n34), .B2(rega1_n22), .A(rega1_n41), .ZN(
        rega1_n27) );
  NAND2_X1 rega1_U11 ( .A1(mula1[8]), .A2(rega1_n22), .ZN(rega1_n42) );
  OAI21_X1 rega1_U10 ( .B1(rega1_n35), .B2(rega1_n22), .A(rega1_n42), .ZN(
        rega1_n28) );
  NAND2_X1 rega1_U9 ( .A1(mula1[7]), .A2(rega1_n22), .ZN(rega1_n43) );
  OAI21_X1 rega1_U8 ( .B1(rega1_n36), .B2(rega1_n22), .A(rega1_n43), .ZN(
        rega1_n29) );
  NAND2_X1 rega1_U7 ( .A1(rega1_n23), .A2(mula1[6]), .ZN(rega1_n44) );
  OAI21_X1 rega1_U6 ( .B1(rega1_n37), .B2(rega1_n22), .A(rega1_n44), .ZN(
        rega1_n30) );
  NAND2_X1 rega1_U5 ( .A1(mula1[12]), .A2(rega1_n22), .ZN(rega1_n38) );
  OAI21_X1 rega1_U4 ( .B1(rega1_n31), .B2(rega1_n22), .A(rega1_n38), .ZN(
        rega1_n24) );
  BUF_X1 rega1_U3 ( .A(n8), .Z(rega1_n23) );
  BUF_X1 rega1_U2 ( .A(n8), .Z(rega1_n22) );
  DFFR_X1 rega1_Q_reg_0_ ( .D(rega1_n30), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[0]), .QN(rega1_n37) );
  DFFR_X1 rega1_Q_reg_1_ ( .D(rega1_n29), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[1]), .QN(rega1_n36) );
  DFFR_X1 rega1_Q_reg_2_ ( .D(rega1_n28), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[2]), .QN(rega1_n35) );
  DFFR_X1 rega1_Q_reg_3_ ( .D(rega1_n27), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[3]), .QN(rega1_n34) );
  DFFR_X1 rega1_Q_reg_4_ ( .D(rega1_n26), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[4]), .QN(rega1_n33) );
  DFFR_X1 rega1_Q_reg_5_ ( .D(rega1_n25), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[5]), .QN(rega1_n32) );
  DFFR_X1 rega1_Q_reg_6_ ( .D(rega1_n24), .CK(CLK), .RN(RST_n), .Q(
        t_mula1_del_vec[6]), .QN(rega1_n31) );
  NAND2_X1 regb0_U17 ( .A1(mulb0[11]), .A2(regb0_n22), .ZN(regb0_n39) );
  OAI21_X1 regb0_U16 ( .B1(regb0_n32), .B2(regb0_n23), .A(regb0_n39), .ZN(
        regb0_n25) );
  NAND2_X1 regb0_U15 ( .A1(mulb0[10]), .A2(regb0_n22), .ZN(regb0_n40) );
  OAI21_X1 regb0_U14 ( .B1(regb0_n33), .B2(regb0_n22), .A(regb0_n40), .ZN(
        regb0_n26) );
  NAND2_X1 regb0_U13 ( .A1(mulb0[9]), .A2(regb0_n22), .ZN(regb0_n41) );
  OAI21_X1 regb0_U12 ( .B1(regb0_n34), .B2(regb0_n22), .A(regb0_n41), .ZN(
        regb0_n27) );
  NAND2_X1 regb0_U11 ( .A1(mulb0[8]), .A2(regb0_n22), .ZN(regb0_n42) );
  OAI21_X1 regb0_U10 ( .B1(regb0_n35), .B2(regb0_n22), .A(regb0_n42), .ZN(
        regb0_n28) );
  NAND2_X1 regb0_U9 ( .A1(mulb0[7]), .A2(regb0_n22), .ZN(regb0_n43) );
  OAI21_X1 regb0_U8 ( .B1(regb0_n36), .B2(regb0_n22), .A(regb0_n43), .ZN(
        regb0_n29) );
  NAND2_X1 regb0_U7 ( .A1(regb0_n23), .A2(mulb0[6]), .ZN(regb0_n44) );
  OAI21_X1 regb0_U6 ( .B1(regb0_n37), .B2(regb0_n22), .A(regb0_n44), .ZN(
        regb0_n30) );
  NAND2_X1 regb0_U5 ( .A1(mulb0[12]), .A2(regb0_n22), .ZN(regb0_n38) );
  OAI21_X1 regb0_U4 ( .B1(regb0_n31), .B2(regb0_n22), .A(regb0_n38), .ZN(
        regb0_n24) );
  BUF_X1 regb0_U3 ( .A(n8), .Z(regb0_n23) );
  BUF_X1 regb0_U2 ( .A(n8), .Z(regb0_n22) );
  DFFR_X1 regb0_Q_reg_0_ ( .D(regb0_n30), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[0]), .QN(regb0_n37) );
  DFFR_X1 regb0_Q_reg_1_ ( .D(regb0_n29), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[1]), .QN(regb0_n36) );
  DFFR_X1 regb0_Q_reg_2_ ( .D(regb0_n28), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[2]), .QN(regb0_n35) );
  DFFR_X1 regb0_Q_reg_3_ ( .D(regb0_n27), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[3]), .QN(regb0_n34) );
  DFFR_X1 regb0_Q_reg_4_ ( .D(regb0_n26), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[4]), .QN(regb0_n33) );
  DFFR_X1 regb0_Q_reg_5_ ( .D(regb0_n25), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[5]), .QN(regb0_n32) );
  DFFR_X1 regb0_Q_reg_6_ ( .D(regb0_n24), .CK(CLK), .RN(RST_n), .Q(
        t_mulb0_del_vec[6]), .QN(regb0_n31) );
  NAND2_X1 regb1_U17 ( .A1(mulb1[11]), .A2(regb1_n22), .ZN(regb1_n39) );
  OAI21_X1 regb1_U16 ( .B1(regb1_n32), .B2(regb1_n23), .A(regb1_n39), .ZN(
        regb1_n25) );
  NAND2_X1 regb1_U15 ( .A1(mulb1[10]), .A2(regb1_n22), .ZN(regb1_n40) );
  OAI21_X1 regb1_U14 ( .B1(regb1_n33), .B2(regb1_n22), .A(regb1_n40), .ZN(
        regb1_n26) );
  NAND2_X1 regb1_U13 ( .A1(mulb1[9]), .A2(regb1_n22), .ZN(regb1_n41) );
  OAI21_X1 regb1_U12 ( .B1(regb1_n34), .B2(regb1_n22), .A(regb1_n41), .ZN(
        regb1_n27) );
  NAND2_X1 regb1_U11 ( .A1(mulb1[8]), .A2(regb1_n22), .ZN(regb1_n42) );
  OAI21_X1 regb1_U10 ( .B1(regb1_n35), .B2(regb1_n22), .A(regb1_n42), .ZN(
        regb1_n28) );
  NAND2_X1 regb1_U9 ( .A1(mulb1[7]), .A2(regb1_n22), .ZN(regb1_n43) );
  OAI21_X1 regb1_U8 ( .B1(regb1_n36), .B2(regb1_n22), .A(regb1_n43), .ZN(
        regb1_n29) );
  NAND2_X1 regb1_U7 ( .A1(regb1_n23), .A2(mulb1[6]), .ZN(regb1_n44) );
  OAI21_X1 regb1_U6 ( .B1(regb1_n37), .B2(regb1_n22), .A(regb1_n44), .ZN(
        regb1_n30) );
  NAND2_X1 regb1_U5 ( .A1(mulb1[12]), .A2(regb1_n22), .ZN(regb1_n38) );
  OAI21_X1 regb1_U4 ( .B1(regb1_n31), .B2(regb1_n22), .A(regb1_n38), .ZN(
        regb1_n24) );
  BUF_X1 regb1_U3 ( .A(n8), .Z(regb1_n23) );
  BUF_X1 regb1_U2 ( .A(n8), .Z(regb1_n22) );
  DFFR_X1 regb1_Q_reg_0_ ( .D(regb1_n30), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[0]), .QN(regb1_n37) );
  DFFR_X1 regb1_Q_reg_1_ ( .D(regb1_n29), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[1]), .QN(regb1_n36) );
  DFFR_X1 regb1_Q_reg_2_ ( .D(regb1_n28), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[2]), .QN(regb1_n35) );
  DFFR_X1 regb1_Q_reg_3_ ( .D(regb1_n27), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[3]), .QN(regb1_n34) );
  DFFR_X1 regb1_Q_reg_4_ ( .D(regb1_n26), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[4]), .QN(regb1_n33) );
  DFFR_X1 regb1_Q_reg_5_ ( .D(regb1_n25), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[5]), .QN(regb1_n32) );
  DFFR_X1 regb1_Q_reg_6_ ( .D(regb1_n24), .CK(CLK), .RN(RST_n), .Q(
        t_mulb1_del_vec[6]), .QN(regb1_n31) );
  NAND2_X1 regU2_U19 ( .A1(u_del_vec[7]), .A2(regU2_n25), .ZN(regU2_n43) );
  OAI21_X1 regU2_U18 ( .B1(regU2_n35), .B2(regU2_n26), .A(regU2_n43), .ZN(
        regU2_n27) );
  NAND2_X1 regU2_U17 ( .A1(u_del_vec[6]), .A2(regU2_n25), .ZN(regU2_n44) );
  OAI21_X1 regU2_U16 ( .B1(regU2_n36), .B2(regU2_n26), .A(regU2_n44), .ZN(
        regU2_n28) );
  NAND2_X1 regU2_U15 ( .A1(regU2_n26), .A2(u_del_vec[0]), .ZN(regU2_n50) );
  OAI21_X1 regU2_U14 ( .B1(regU2_n42), .B2(regU2_n26), .A(regU2_n50), .ZN(
        regU2_n34) );
  NAND2_X1 regU2_U13 ( .A1(u_del_vec[5]), .A2(regU2_n25), .ZN(regU2_n45) );
  OAI21_X1 regU2_U12 ( .B1(regU2_n37), .B2(regU2_n25), .A(regU2_n45), .ZN(
        regU2_n29) );
  NAND2_X1 regU2_U11 ( .A1(u_del_vec[4]), .A2(regU2_n25), .ZN(regU2_n46) );
  OAI21_X1 regU2_U10 ( .B1(regU2_n38), .B2(regU2_n25), .A(regU2_n46), .ZN(
        regU2_n30) );
  NAND2_X1 regU2_U9 ( .A1(u_del_vec[3]), .A2(regU2_n25), .ZN(regU2_n47) );
  OAI21_X1 regU2_U8 ( .B1(regU2_n39), .B2(regU2_n25), .A(regU2_n47), .ZN(
        regU2_n31) );
  NAND2_X1 regU2_U7 ( .A1(u_del_vec[2]), .A2(regU2_n25), .ZN(regU2_n48) );
  OAI21_X1 regU2_U6 ( .B1(regU2_n40), .B2(regU2_n25), .A(regU2_n48), .ZN(
        regU2_n32) );
  NAND2_X1 regU2_U5 ( .A1(u_del_vec[1]), .A2(regU2_n25), .ZN(regU2_n49) );
  OAI21_X1 regU2_U4 ( .B1(regU2_n41), .B2(regU2_n25), .A(regU2_n49), .ZN(
        regU2_n33) );
  BUF_X1 regU2_U3 ( .A(n8), .Z(regU2_n26) );
  BUF_X1 regU2_U2 ( .A(n8), .Z(regU2_n25) );
  DFFR_X1 regU2_Q_reg_0_ ( .D(regU2_n34), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[0]), .QN(regU2_n42) );
  DFFR_X1 regU2_Q_reg_1_ ( .D(regU2_n33), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[1]), .QN(regU2_n41) );
  DFFR_X1 regU2_Q_reg_2_ ( .D(regU2_n32), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[2]), .QN(regU2_n40) );
  DFFR_X1 regU2_Q_reg_3_ ( .D(regU2_n31), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[3]), .QN(regU2_n39) );
  DFFR_X1 regU2_Q_reg_4_ ( .D(regU2_n30), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[4]), .QN(regU2_n38) );
  DFFR_X1 regU2_Q_reg_5_ ( .D(regU2_n29), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[5]), .QN(regU2_n37) );
  DFFR_X1 regU2_Q_reg_6_ ( .D(regU2_n28), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[6]), .QN(regU2_n36) );
  DFFR_X1 regU2_Q_reg_7_ ( .D(regU2_n27), .CK(CLK), .RN(RST_n), .Q(
        u_del_vec2[7]), .QN(regU2_n35) );
  NAND2_X1 regb2_U17 ( .A1(mulb2[11]), .A2(regb2_n22), .ZN(regb2_n39) );
  OAI21_X1 regb2_U16 ( .B1(regb2_n32), .B2(regb2_n23), .A(regb2_n39), .ZN(
        regb2_n25) );
  NAND2_X1 regb2_U15 ( .A1(mulb2[10]), .A2(regb2_n22), .ZN(regb2_n40) );
  OAI21_X1 regb2_U14 ( .B1(regb2_n33), .B2(regb2_n22), .A(regb2_n40), .ZN(
        regb2_n26) );
  NAND2_X1 regb2_U13 ( .A1(mulb2[9]), .A2(regb2_n22), .ZN(regb2_n41) );
  OAI21_X1 regb2_U12 ( .B1(regb2_n34), .B2(regb2_n22), .A(regb2_n41), .ZN(
        regb2_n27) );
  NAND2_X1 regb2_U11 ( .A1(mulb2[8]), .A2(regb2_n22), .ZN(regb2_n42) );
  OAI21_X1 regb2_U10 ( .B1(regb2_n35), .B2(regb2_n22), .A(regb2_n42), .ZN(
        regb2_n28) );
  NAND2_X1 regb2_U9 ( .A1(mulb2[7]), .A2(regb2_n22), .ZN(regb2_n43) );
  OAI21_X1 regb2_U8 ( .B1(regb2_n36), .B2(regb2_n22), .A(regb2_n43), .ZN(
        regb2_n29) );
  NAND2_X1 regb2_U7 ( .A1(regb2_n23), .A2(mulb2[6]), .ZN(regb2_n44) );
  OAI21_X1 regb2_U6 ( .B1(regb2_n37), .B2(regb2_n22), .A(regb2_n44), .ZN(
        regb2_n30) );
  NAND2_X1 regb2_U5 ( .A1(mulb2[12]), .A2(regb2_n22), .ZN(regb2_n38) );
  OAI21_X1 regb2_U4 ( .B1(regb2_n31), .B2(regb2_n22), .A(regb2_n38), .ZN(
        regb2_n24) );
  BUF_X1 regb2_U3 ( .A(n7), .Z(regb2_n23) );
  BUF_X1 regb2_U2 ( .A(n7), .Z(regb2_n22) );
  DFFR_X1 regb2_Q_reg_0_ ( .D(regb2_n30), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[0]), .QN(regb2_n37) );
  DFFR_X1 regb2_Q_reg_1_ ( .D(regb2_n29), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[1]), .QN(regb2_n36) );
  DFFR_X1 regb2_Q_reg_2_ ( .D(regb2_n28), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[2]), .QN(regb2_n35) );
  DFFR_X1 regb2_Q_reg_3_ ( .D(regb2_n27), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[3]), .QN(regb2_n34) );
  DFFR_X1 regb2_Q_reg_4_ ( .D(regb2_n26), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[4]), .QN(regb2_n33) );
  DFFR_X1 regb2_Q_reg_5_ ( .D(regb2_n25), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[5]), .QN(regb2_n32) );
  DFFR_X1 regb2_Q_reg_6_ ( .D(regb2_n24), .CK(CLK), .RN(RST_n), .Q(
        t_mulb2_del_vec[6]), .QN(regb2_n31) );
  NAND2_X1 regsum_U17 ( .A1(sum1[4]), .A2(regsum_n22), .ZN(regsum_n40) );
  OAI21_X1 regsum_U16 ( .B1(regsum_n33), .B2(regsum_n22), .A(regsum_n40), .ZN(
        regsum_n26) );
  NAND2_X1 regsum_U15 ( .A1(sum1[3]), .A2(regsum_n22), .ZN(regsum_n41) );
  OAI21_X1 regsum_U14 ( .B1(regsum_n34), .B2(regsum_n22), .A(regsum_n41), .ZN(
        regsum_n27) );
  NAND2_X1 regsum_U13 ( .A1(sum1[2]), .A2(regsum_n22), .ZN(regsum_n42) );
  OAI21_X1 regsum_U12 ( .B1(regsum_n35), .B2(regsum_n22), .A(regsum_n42), .ZN(
        regsum_n28) );
  NAND2_X1 regsum_U11 ( .A1(sum1[1]), .A2(regsum_n22), .ZN(regsum_n43) );
  OAI21_X1 regsum_U10 ( .B1(regsum_n36), .B2(regsum_n22), .A(regsum_n43), .ZN(
        regsum_n29) );
  NAND2_X1 regsum_U9 ( .A1(regsum_n23), .A2(sum1[0]), .ZN(regsum_n44) );
  OAI21_X1 regsum_U8 ( .B1(regsum_n37), .B2(regsum_n22), .A(regsum_n44), .ZN(
        regsum_n30) );
  NAND2_X1 regsum_U7 ( .A1(sum1[6]), .A2(regsum_n22), .ZN(regsum_n38) );
  OAI21_X1 regsum_U6 ( .B1(regsum_n31), .B2(regsum_n22), .A(regsum_n38), .ZN(
        regsum_n24) );
  NAND2_X1 regsum_U5 ( .A1(sum1[5]), .A2(regsum_n22), .ZN(regsum_n39) );
  OAI21_X1 regsum_U4 ( .B1(regsum_n32), .B2(regsum_n23), .A(regsum_n39), .ZN(
        regsum_n25) );
  BUF_X1 regsum_U3 ( .A(n7), .Z(regsum_n23) );
  BUF_X1 regsum_U2 ( .A(n7), .Z(regsum_n22) );
  DFFR_X1 regsum_Q_reg_0_ ( .D(regsum_n30), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[0]), .QN(regsum_n37) );
  DFFR_X1 regsum_Q_reg_1_ ( .D(regsum_n29), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[1]), .QN(regsum_n36) );
  DFFR_X1 regsum_Q_reg_2_ ( .D(regsum_n28), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[2]), .QN(regsum_n35) );
  DFFR_X1 regsum_Q_reg_3_ ( .D(regsum_n27), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[3]), .QN(regsum_n34) );
  DFFR_X1 regsum_Q_reg_4_ ( .D(regsum_n26), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[4]), .QN(regsum_n33) );
  DFFR_X1 regsum_Q_reg_5_ ( .D(regsum_n25), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[5]), .QN(regsum_n32) );
  DFFR_X1 regsum_Q_reg_6_ ( .D(regsum_n24), .CK(CLK), .RN(RST_n), .Q(
        sum1_del_vec[6]), .QN(regsum_n31) );
  NAND2_X1 regY_U19 ( .A1(y[1]), .A2(regY_n25), .ZN(regY_n49) );
  OAI21_X1 regY_U18 ( .B1(regY_n41), .B2(regY_n25), .A(regY_n49), .ZN(regY_n33) );
  NAND2_X1 regY_U17 ( .A1(y[4]), .A2(regY_n25), .ZN(regY_n46) );
  OAI21_X1 regY_U16 ( .B1(regY_n38), .B2(regY_n25), .A(regY_n46), .ZN(regY_n30) );
  NAND2_X1 regY_U15 ( .A1(y[3]), .A2(regY_n25), .ZN(regY_n47) );
  OAI21_X1 regY_U14 ( .B1(regY_n39), .B2(regY_n25), .A(regY_n47), .ZN(regY_n31) );
  NAND2_X1 regY_U13 ( .A1(y[2]), .A2(regY_n25), .ZN(regY_n48) );
  OAI21_X1 regY_U12 ( .B1(regY_n40), .B2(regY_n25), .A(regY_n48), .ZN(regY_n32) );
  NAND2_X1 regY_U11 ( .A1(regY_n26), .A2(y[0]), .ZN(regY_n50) );
  OAI21_X1 regY_U10 ( .B1(regY_n42), .B2(regY_n26), .A(regY_n50), .ZN(regY_n34) );
  NAND2_X1 regY_U9 ( .A1(y[6]), .A2(regY_n25), .ZN(regY_n44) );
  OAI21_X1 regY_U8 ( .B1(regY_n36), .B2(regY_n26), .A(regY_n44), .ZN(regY_n28)
         );
  NAND2_X1 regY_U7 ( .A1(y[5]), .A2(regY_n25), .ZN(regY_n45) );
  OAI21_X1 regY_U6 ( .B1(regY_n37), .B2(regY_n25), .A(regY_n45), .ZN(regY_n29)
         );
  NAND2_X1 regY_U5 ( .A1(y[7]), .A2(regY_n25), .ZN(regY_n43) );
  OAI21_X1 regY_U4 ( .B1(regY_n35), .B2(regY_n26), .A(regY_n43), .ZN(regY_n27)
         );
  BUF_X1 regY_U3 ( .A(n7), .Z(regY_n26) );
  BUF_X1 regY_U2 ( .A(n7), .Z(regY_n25) );
  DFFR_X1 regY_Q_reg_0_ ( .D(regY_n34), .CK(CLK), .RN(RST_n), .Q(DOUT[4]), 
        .QN(regY_n42) );
  DFFR_X1 regY_Q_reg_1_ ( .D(regY_n33), .CK(CLK), .RN(RST_n), .Q(DOUT[5]), 
        .QN(regY_n41) );
  DFFR_X1 regY_Q_reg_2_ ( .D(regY_n32), .CK(CLK), .RN(RST_n), .Q(DOUT[6]), 
        .QN(regY_n40) );
  DFFR_X1 regY_Q_reg_3_ ( .D(regY_n31), .CK(CLK), .RN(RST_n), .Q(DOUT[7]), 
        .QN(regY_n39) );
  DFFR_X1 regY_Q_reg_4_ ( .D(regY_n30), .CK(CLK), .RN(RST_n), .Q(DOUT[8]), 
        .QN(regY_n38) );
  DFFR_X1 regY_Q_reg_5_ ( .D(regY_n29), .CK(CLK), .RN(RST_n), .Q(DOUT[9]), 
        .QN(regY_n37) );
  DFFR_X1 regY_Q_reg_6_ ( .D(regY_n28), .CK(CLK), .RN(RST_n), .Q(DOUT[10]), 
        .QN(regY_n36) );
  DFFR_X1 regY_Q_reg_7_ ( .D(regY_n27), .CK(CLK), .RN(RST_n), .Q(DOUT[11]), 
        .QN(regY_n35) );
  DFFR_X1 ff1_Q_reg ( .D(VIN), .CK(CLK), .RN(RST_n), .Q(q1) );
  DFFR_X1 ff2_Q_reg ( .D(q1), .CK(CLK), .RN(RST_n), .Q(q2) );
  DFFR_X1 ff3_Q_reg ( .D(n8), .CK(CLK), .RN(RST_n), .Q(q3) );
  DFFR_X1 ff4_Q_reg ( .D(n7), .CK(CLK), .RN(RST_n), .Q(VOUT) );
  AND2_X1 add_96_U2 ( .A1(sum1_del_vec[0]), .A2(t_mulb0_del_vec[0]), .ZN(
        add_96_n2) );
  XOR2_X1 add_96_U1 ( .A(sum1_del_vec[0]), .B(t_mulb0_del_vec[0]), .Z(y[0]) );
  FA_X1 add_96_U1_1 ( .A(t_mulb0_del_vec[1]), .B(sum1_del_vec[1]), .CI(
        add_96_n2), .CO(add_96_carry[2]), .S(y[1]) );
  FA_X1 add_96_U1_2 ( .A(t_mulb0_del_vec[2]), .B(sum1_del_vec[2]), .CI(
        add_96_carry[2]), .CO(add_96_carry[3]), .S(y[2]) );
  FA_X1 add_96_U1_3 ( .A(t_mulb0_del_vec[3]), .B(sum1_del_vec[3]), .CI(
        add_96_carry[3]), .CO(add_96_carry[4]), .S(y[3]) );
  FA_X1 add_96_U1_4 ( .A(t_mulb0_del_vec[4]), .B(sum1_del_vec[4]), .CI(
        add_96_carry[4]), .CO(add_96_carry[5]), .S(y[4]) );
  FA_X1 add_96_U1_5 ( .A(t_mulb0_del_vec[5]), .B(sum1_del_vec[5]), .CI(
        add_96_carry[5]), .CO(add_96_carry[6]), .S(y[5]) );
  FA_X1 add_96_U1_6 ( .A(t_mulb0_del_vec[6]), .B(sum1_del_vec[6]), .CI(
        add_96_carry[6]), .CO(add_96_carry[7]), .S(y[6]) );
  FA_X1 add_96_U1_7 ( .A(t_mulb0_del_vec[6]), .B(sum1_del_vec[6]), .CI(
        add_96_carry[7]), .S(y[7]) );
  AND2_X1 add_90_U2 ( .A1(t_mulb1_del_vec[0]), .A2(t_mulb2_del_vec[0]), .ZN(
        add_90_n2) );
  XOR2_X1 add_90_U1 ( .A(t_mulb1_del_vec[0]), .B(t_mulb2_del_vec[0]), .Z(
        sum1[0]) );
  FA_X1 add_90_U1_1 ( .A(t_mulb2_del_vec[1]), .B(t_mulb1_del_vec[1]), .CI(
        add_90_n2), .CO(add_90_carry[2]), .S(sum1[1]) );
  FA_X1 add_90_U1_2 ( .A(t_mulb2_del_vec[2]), .B(t_mulb1_del_vec[2]), .CI(
        add_90_carry[2]), .CO(add_90_carry[3]), .S(sum1[2]) );
  FA_X1 add_90_U1_3 ( .A(t_mulb2_del_vec[3]), .B(t_mulb1_del_vec[3]), .CI(
        add_90_carry[3]), .CO(add_90_carry[4]), .S(sum1[3]) );
  FA_X1 add_90_U1_4 ( .A(t_mulb2_del_vec[4]), .B(t_mulb1_del_vec[4]), .CI(
        add_90_carry[4]), .CO(add_90_carry[5]), .S(sum1[4]) );
  FA_X1 add_90_U1_5 ( .A(t_mulb2_del_vec[5]), .B(t_mulb1_del_vec[5]), .CI(
        add_90_carry[5]), .CO(add_90_carry[6]), .S(sum1[5]) );
  FA_X1 add_90_U1_6 ( .A(t_mulb2_del_vec[6]), .B(t_mulb1_del_vec[6]), .CI(
        add_90_carry[6]), .S(sum1[6]) );
  AND2_X1 add_60_U2 ( .A1(t_mula1_del_vec[0]), .A2(din_del[0]), .ZN(add_60_n2)
         );
  XOR2_X1 add_60_U1 ( .A(t_mula1_del_vec[0]), .B(din_del[0]), .Z(u[0]) );
  FA_X1 add_60_U1_1 ( .A(din_del[1]), .B(t_mula1_del_vec[1]), .CI(add_60_n2), 
        .CO(add_60_carry[2]), .S(u[1]) );
  FA_X1 add_60_U1_2 ( .A(din_del[2]), .B(t_mula1_del_vec[2]), .CI(
        add_60_carry[2]), .CO(add_60_carry[3]), .S(u[2]) );
  FA_X1 add_60_U1_3 ( .A(din_del[3]), .B(t_mula1_del_vec[3]), .CI(
        add_60_carry[3]), .CO(add_60_carry[4]), .S(u[3]) );
  FA_X1 add_60_U1_4 ( .A(din_del[4]), .B(t_mula1_del_vec[4]), .CI(
        add_60_carry[4]), .CO(add_60_carry[5]), .S(u[4]) );
  FA_X1 add_60_U1_5 ( .A(din_del[5]), .B(t_mula1_del_vec[5]), .CI(
        add_60_carry[5]), .CO(add_60_carry[6]), .S(u[5]) );
  FA_X1 add_60_U1_6 ( .A(din_del[6]), .B(t_mula1_del_vec[6]), .CI(
        add_60_carry[6]), .CO(add_60_carry[7]), .S(u[6]) );
  FA_X1 add_60_U1_7 ( .A(din_del[6]), .B(t_mula1_del_vec[6]), .CI(
        add_60_carry[7]), .S(u[7]) );
  NOR2_X1 mult_85_U203 ( .A1(mult_85_n179), .A2(mult_85_n192), .ZN(
        mult_85_n100) );
  NOR2_X1 mult_85_U202 ( .A1(mult_85_n192), .A2(mult_85_n181), .ZN(
        mult_85_n101) );
  NOR2_X1 mult_85_U201 ( .A1(mult_85_n192), .A2(mult_85_n182), .ZN(
        mult_85_n102) );
  NOR2_X1 mult_85_U200 ( .A1(mult_85_n192), .A2(mult_85_n185), .ZN(
        mult_85_n103) );
  NOR2_X1 mult_85_U199 ( .A1(mult_85_n192), .A2(mult_85_n189), .ZN(
        mult_85_n105) );
  NOR2_X1 mult_85_U198 ( .A1(mult_85_n192), .A2(mult_85_n190), .ZN(
        mult_85_n106) );
  NAND2_X1 mult_85_U197 ( .A1(b2[8]), .A2(u_del_vec2[7]), .ZN(mult_85_n107) );
  NOR2_X1 mult_85_U196 ( .A1(mult_85_n179), .A2(mult_85_n193), .ZN(
        mult_85_n108) );
  NOR2_X1 mult_85_U195 ( .A1(mult_85_n181), .A2(mult_85_n193), .ZN(
        mult_85_n109) );
  NOR2_X1 mult_85_U194 ( .A1(mult_85_n182), .A2(mult_85_n193), .ZN(
        mult_85_n110) );
  NOR2_X1 mult_85_U193 ( .A1(mult_85_n185), .A2(mult_85_n193), .ZN(
        mult_85_n111) );
  NOR2_X1 mult_85_U192 ( .A1(mult_85_n187), .A2(mult_85_n193), .ZN(
        mult_85_n112) );
  NOR2_X1 mult_85_U191 ( .A1(mult_85_n189), .A2(mult_85_n193), .ZN(
        mult_85_n113) );
  NOR2_X1 mult_85_U190 ( .A1(mult_85_n190), .A2(mult_85_n193), .ZN(
        mult_85_n114) );
  NAND2_X1 mult_85_U189 ( .A1(b2[7]), .A2(u_del_vec2[7]), .ZN(mult_85_n115) );
  NOR2_X1 mult_85_U188 ( .A1(mult_85_n179), .A2(mult_85_n194), .ZN(
        mult_85_n116) );
  NOR2_X1 mult_85_U187 ( .A1(mult_85_n181), .A2(mult_85_n194), .ZN(
        mult_85_n117) );
  NOR2_X1 mult_85_U186 ( .A1(mult_85_n182), .A2(mult_85_n194), .ZN(
        mult_85_n118) );
  NOR2_X1 mult_85_U185 ( .A1(mult_85_n185), .A2(mult_85_n194), .ZN(
        mult_85_n119) );
  NOR2_X1 mult_85_U184 ( .A1(mult_85_n187), .A2(mult_85_n194), .ZN(
        mult_85_n120) );
  NOR2_X1 mult_85_U183 ( .A1(mult_85_n189), .A2(mult_85_n194), .ZN(
        mult_85_n121) );
  NAND2_X1 mult_85_U182 ( .A1(b2[6]), .A2(u_del_vec2[7]), .ZN(mult_85_n123) );
  NOR2_X1 mult_85_U181 ( .A1(mult_85_n179), .A2(mult_85_n195), .ZN(
        mult_85_n124) );
  NOR2_X1 mult_85_U180 ( .A1(mult_85_n181), .A2(mult_85_n195), .ZN(
        mult_85_n125) );
  NOR2_X1 mult_85_U179 ( .A1(mult_85_n182), .A2(mult_85_n195), .ZN(
        mult_85_n126) );
  NOR2_X1 mult_85_U178 ( .A1(mult_85_n185), .A2(mult_85_n195), .ZN(
        mult_85_n127) );
  NOR2_X1 mult_85_U177 ( .A1(mult_85_n187), .A2(mult_85_n195), .ZN(
        mult_85_n128) );
  NOR2_X1 mult_85_U176 ( .A1(mult_85_n189), .A2(mult_85_n195), .ZN(
        mult_85_n129) );
  NAND2_X1 mult_85_U175 ( .A1(b2[5]), .A2(u_del_vec2[7]), .ZN(mult_85_n131) );
  NOR2_X1 mult_85_U174 ( .A1(mult_85_n181), .A2(mult_85_n196), .ZN(
        mult_85_n133) );
  NOR2_X1 mult_85_U173 ( .A1(mult_85_n182), .A2(mult_85_n196), .ZN(
        mult_85_n134) );
  NOR2_X1 mult_85_U172 ( .A1(mult_85_n185), .A2(mult_85_n196), .ZN(
        mult_85_n135) );
  NOR2_X1 mult_85_U171 ( .A1(mult_85_n187), .A2(mult_85_n196), .ZN(
        mult_85_n136) );
  NAND2_X1 mult_85_U170 ( .A1(u_del_vec2[2]), .A2(b2[10]), .ZN(mult_85_n54) );
  NAND2_X1 mult_85_U169 ( .A1(b2[5]), .A2(u_del_vec2[6]), .ZN(mult_85_n208) );
  NAND2_X1 mult_85_U168 ( .A1(u_del_vec2[2]), .A2(b2[9]), .ZN(mult_85_n207) );
  NAND2_X1 mult_85_U167 ( .A1(mult_85_n208), .A2(mult_85_n207), .ZN(
        mult_85_n63) );
  XNOR2_X1 mult_85_U166 ( .A(mult_85_n207), .B(mult_85_n208), .ZN(mult_85_n64)
         );
  NOR4_X1 mult_85_U165 ( .A1(mult_85_n195), .A2(mult_85_n196), .A3(
        mult_85_n189), .A4(mult_85_n190), .ZN(mult_85_n205) );
  NOR2_X1 mult_85_U164 ( .A1(mult_85_n194), .A2(mult_85_n190), .ZN(
        mult_85_n206) );
  AOI222_X1 mult_85_U163 ( .A1(mult_85_n84), .A2(mult_85_n205), .B1(
        mult_85_n206), .B2(mult_85_n84), .C1(mult_85_n206), .C2(mult_85_n205), 
        .ZN(mult_85_n204) );
  OAI222_X1 mult_85_U162 ( .A1(mult_85_n204), .A2(mult_85_n184), .B1(
        mult_85_n184), .B2(mult_85_n188), .C1(mult_85_n204), .C2(mult_85_n188), 
        .ZN(mult_85_n203) );
  AOI222_X1 mult_85_U161 ( .A1(mult_85_n203), .A2(mult_85_n74), .B1(
        mult_85_n203), .B2(mult_85_n76), .C1(mult_85_n76), .C2(mult_85_n74), 
        .ZN(mult_85_n202) );
  OAI222_X1 mult_85_U160 ( .A1(mult_85_n202), .A2(mult_85_n180), .B1(
        mult_85_n202), .B2(mult_85_n183), .C1(mult_85_n183), .C2(mult_85_n180), 
        .ZN(mult_85_n8) );
  NAND2_X1 mult_85_U159 ( .A1(u_del_vec2[5]), .A2(b2[11]), .ZN(mult_85_n86) );
  NAND2_X1 mult_85_U158 ( .A1(u_del_vec2[4]), .A2(b2[11]), .ZN(mult_85_n87) );
  NAND2_X1 mult_85_U157 ( .A1(u_del_vec2[3]), .A2(b2[11]), .ZN(mult_85_n88) );
  NAND2_X1 mult_85_U156 ( .A1(u_del_vec2[2]), .A2(b2[11]), .ZN(mult_85_n89) );
  NAND2_X1 mult_85_U155 ( .A1(u_del_vec2[1]), .A2(b2[11]), .ZN(mult_85_n90) );
  NAND2_X1 mult_85_U154 ( .A1(u_del_vec2[0]), .A2(b2[11]), .ZN(mult_85_n91) );
  NOR2_X1 mult_85_U153 ( .A1(mult_85_n191), .A2(mult_85_n179), .ZN(mult_85_n93) );
  NOR2_X1 mult_85_U152 ( .A1(mult_85_n191), .A2(mult_85_n181), .ZN(mult_85_n94) );
  NOR2_X1 mult_85_U151 ( .A1(mult_85_n191), .A2(mult_85_n182), .ZN(mult_85_n95) );
  NOR2_X1 mult_85_U150 ( .A1(mult_85_n191), .A2(mult_85_n185), .ZN(mult_85_n96) );
  NOR2_X1 mult_85_U149 ( .A1(mult_85_n191), .A2(mult_85_n189), .ZN(mult_85_n97) );
  NOR2_X1 mult_85_U148 ( .A1(mult_85_n191), .A2(mult_85_n190), .ZN(mult_85_n98) );
  NAND2_X1 mult_85_U147 ( .A1(b2[9]), .A2(u_del_vec2[7]), .ZN(mult_85_n99) );
  XNOR2_X1 mult_85_U146 ( .A(mult_85_n2), .B(mult_85_n17), .ZN(mult_85_n201)
         );
  XOR2_X1 mult_85_U145 ( .A(mult_85_n201), .B(mult_85_n15), .Z(mult_85_n197)
         );
  NAND2_X1 mult_85_U144 ( .A1(u_del_vec2[7]), .A2(b2[10]), .ZN(mult_85_n199)
         );
  AND2_X1 mult_85_U143 ( .A1(u_del_vec2[6]), .A2(b2[11]), .ZN(mult_85_n200) );
  XOR2_X1 mult_85_U142 ( .A(mult_85_n199), .B(mult_85_n200), .Z(mult_85_n198)
         );
  XOR2_X1 mult_85_U141 ( .A(mult_85_n197), .B(mult_85_n198), .Z(mulb2[12]) );
  INV_X1 mult_85_U140 ( .A(u_del_vec2[2]), .ZN(mult_85_n187) );
  INV_X1 mult_85_U139 ( .A(u_del_vec2[0]), .ZN(mult_85_n190) );
  INV_X1 mult_85_U138 ( .A(u_del_vec2[6]), .ZN(mult_85_n179) );
  INV_X1 mult_85_U137 ( .A(u_del_vec2[1]), .ZN(mult_85_n189) );
  INV_X1 mult_85_U136 ( .A(u_del_vec2[5]), .ZN(mult_85_n181) );
  INV_X1 mult_85_U135 ( .A(u_del_vec2[4]), .ZN(mult_85_n182) );
  INV_X1 mult_85_U134 ( .A(u_del_vec2[3]), .ZN(mult_85_n185) );
  INV_X1 mult_85_U133 ( .A(b2[5]), .ZN(mult_85_n196) );
  INV_X1 mult_85_U132 ( .A(b2[9]), .ZN(mult_85_n192) );
  INV_X1 mult_85_U131 ( .A(b2[10]), .ZN(mult_85_n191) );
  INV_X1 mult_85_U130 ( .A(b2[8]), .ZN(mult_85_n193) );
  INV_X1 mult_85_U129 ( .A(b2[7]), .ZN(mult_85_n194) );
  INV_X1 mult_85_U128 ( .A(b2[6]), .ZN(mult_85_n195) );
  INV_X1 mult_85_U127 ( .A(mult_85_n54), .ZN(mult_85_n186) );
  INV_X1 mult_85_U126 ( .A(mult_85_n80), .ZN(mult_85_n184) );
  INV_X1 mult_85_U125 ( .A(mult_85_n66), .ZN(mult_85_n180) );
  INV_X1 mult_85_U124 ( .A(mult_85_n73), .ZN(mult_85_n183) );
  INV_X1 mult_85_U123 ( .A(mult_85_n82), .ZN(mult_85_n188) );
  HA_X1 mult_85_U51 ( .A(mult_85_n129), .B(mult_85_n136), .CO(mult_85_n83), 
        .S(mult_85_n84) );
  HA_X1 mult_85_U50 ( .A(mult_85_n114), .B(mult_85_n121), .CO(mult_85_n81), 
        .S(mult_85_n82) );
  FA_X1 mult_85_U49 ( .A(mult_85_n128), .B(mult_85_n135), .CI(mult_85_n83), 
        .CO(mult_85_n79), .S(mult_85_n80) );
  HA_X1 mult_85_U48 ( .A(mult_85_n106), .B(mult_85_n113), .CO(mult_85_n77), 
        .S(mult_85_n78) );
  FA_X1 mult_85_U47 ( .A(mult_85_n120), .B(mult_85_n134), .CI(mult_85_n127), 
        .CO(mult_85_n75), .S(mult_85_n76) );
  FA_X1 mult_85_U46 ( .A(mult_85_n78), .B(mult_85_n81), .CI(mult_85_n79), .CO(
        mult_85_n73), .S(mult_85_n74) );
  HA_X1 mult_85_U45 ( .A(mult_85_n98), .B(mult_85_n105), .CO(mult_85_n71), .S(
        mult_85_n72) );
  FA_X1 mult_85_U44 ( .A(mult_85_n112), .B(mult_85_n133), .CI(mult_85_n119), 
        .CO(mult_85_n69), .S(mult_85_n70) );
  FA_X1 mult_85_U43 ( .A(mult_85_n77), .B(mult_85_n126), .CI(mult_85_n72), 
        .CO(mult_85_n67), .S(mult_85_n68) );
  FA_X1 mult_85_U42 ( .A(mult_85_n70), .B(mult_85_n75), .CI(mult_85_n68), .CO(
        mult_85_n65), .S(mult_85_n66) );
  FA_X1 mult_85_U39 ( .A(mult_85_n97), .B(mult_85_n125), .CI(mult_85_n111), 
        .CO(mult_85_n61), .S(mult_85_n62) );
  FA_X1 mult_85_U38 ( .A(mult_85_n91), .B(mult_85_n118), .CI(mult_85_n71), 
        .CO(mult_85_n59), .S(mult_85_n60) );
  FA_X1 mult_85_U37 ( .A(mult_85_n69), .B(mult_85_n64), .CI(mult_85_n62), .CO(
        mult_85_n57), .S(mult_85_n58) );
  FA_X1 mult_85_U36 ( .A(mult_85_n60), .B(mult_85_n67), .CI(mult_85_n58), .CO(
        mult_85_n55), .S(mult_85_n56) );
  FA_X1 mult_85_U34 ( .A(mult_85_n103), .B(mult_85_n110), .CI(mult_85_n124), 
        .CO(mult_85_n51), .S(mult_85_n52) );
  FA_X1 mult_85_U33 ( .A(mult_85_n131), .B(mult_85_n117), .CI(mult_85_n90), 
        .CO(mult_85_n49), .S(mult_85_n50) );
  FA_X1 mult_85_U32 ( .A(mult_85_n63), .B(mult_85_n54), .CI(mult_85_n61), .CO(
        mult_85_n47), .S(mult_85_n48) );
  FA_X1 mult_85_U31 ( .A(mult_85_n52), .B(mult_85_n59), .CI(mult_85_n50), .CO(
        mult_85_n45), .S(mult_85_n46) );
  FA_X1 mult_85_U30 ( .A(mult_85_n48), .B(mult_85_n57), .CI(mult_85_n46), .CO(
        mult_85_n43), .S(mult_85_n44) );
  FA_X1 mult_85_U29 ( .A(mult_85_n102), .B(mult_85_n186), .CI(mult_85_n96), 
        .CO(mult_85_n41), .S(mult_85_n42) );
  FA_X1 mult_85_U28 ( .A(mult_85_n116), .B(mult_85_n109), .CI(mult_85_n123), 
        .CO(mult_85_n39), .S(mult_85_n40) );
  FA_X1 mult_85_U27 ( .A(mult_85_n51), .B(mult_85_n89), .CI(mult_85_n49), .CO(
        mult_85_n37), .S(mult_85_n38) );
  FA_X1 mult_85_U26 ( .A(mult_85_n40), .B(mult_85_n42), .CI(mult_85_n47), .CO(
        mult_85_n35), .S(mult_85_n36) );
  FA_X1 mult_85_U25 ( .A(mult_85_n38), .B(mult_85_n45), .CI(mult_85_n36), .CO(
        mult_85_n33), .S(mult_85_n34) );
  FA_X1 mult_85_U24 ( .A(mult_85_n95), .B(mult_85_n101), .CI(mult_85_n108), 
        .CO(mult_85_n31), .S(mult_85_n32) );
  FA_X1 mult_85_U23 ( .A(mult_85_n88), .B(mult_85_n115), .CI(mult_85_n41), 
        .CO(mult_85_n29), .S(mult_85_n30) );
  FA_X1 mult_85_U22 ( .A(mult_85_n32), .B(mult_85_n39), .CI(mult_85_n37), .CO(
        mult_85_n27), .S(mult_85_n28) );
  FA_X1 mult_85_U21 ( .A(mult_85_n35), .B(mult_85_n30), .CI(mult_85_n28), .CO(
        mult_85_n25), .S(mult_85_n26) );
  FA_X1 mult_85_U20 ( .A(mult_85_n94), .B(mult_85_n100), .CI(mult_85_n107), 
        .CO(mult_85_n23), .S(mult_85_n24) );
  FA_X1 mult_85_U19 ( .A(mult_85_n31), .B(mult_85_n87), .CI(mult_85_n24), .CO(
        mult_85_n21), .S(mult_85_n22) );
  FA_X1 mult_85_U18 ( .A(mult_85_n27), .B(mult_85_n29), .CI(mult_85_n22), .CO(
        mult_85_n19), .S(mult_85_n20) );
  FA_X1 mult_85_U17 ( .A(mult_85_n99), .B(mult_85_n93), .CI(mult_85_n86), .CO(
        mult_85_n17), .S(mult_85_n18) );
  FA_X1 mult_85_U16 ( .A(mult_85_n18), .B(mult_85_n23), .CI(mult_85_n21), .CO(
        mult_85_n15), .S(mult_85_n16) );
  FA_X1 mult_85_U8 ( .A(mult_85_n56), .B(mult_85_n65), .CI(mult_85_n8), .CO(
        mult_85_n7), .S(mulb2[6]) );
  FA_X1 mult_85_U7 ( .A(mult_85_n44), .B(mult_85_n55), .CI(mult_85_n7), .CO(
        mult_85_n6), .S(mulb2[7]) );
  FA_X1 mult_85_U6 ( .A(mult_85_n34), .B(mult_85_n43), .CI(mult_85_n6), .CO(
        mult_85_n5), .S(mulb2[8]) );
  FA_X1 mult_85_U5 ( .A(mult_85_n26), .B(mult_85_n33), .CI(mult_85_n5), .CO(
        mult_85_n4), .S(mulb2[9]) );
  FA_X1 mult_85_U4 ( .A(mult_85_n20), .B(mult_85_n25), .CI(mult_85_n4), .CO(
        mult_85_n3), .S(mulb2[10]) );
  FA_X1 mult_85_U3 ( .A(mult_85_n19), .B(mult_85_n16), .CI(mult_85_n3), .CO(
        mult_85_n2), .S(mulb2[11]) );
  NOR2_X1 mult_78_U203 ( .A1(mult_78_n179), .A2(mult_78_n192), .ZN(
        mult_78_n100) );
  NOR2_X1 mult_78_U202 ( .A1(mult_78_n192), .A2(mult_78_n181), .ZN(
        mult_78_n101) );
  NOR2_X1 mult_78_U201 ( .A1(mult_78_n192), .A2(mult_78_n182), .ZN(
        mult_78_n102) );
  NOR2_X1 mult_78_U200 ( .A1(mult_78_n192), .A2(mult_78_n185), .ZN(
        mult_78_n103) );
  NOR2_X1 mult_78_U199 ( .A1(mult_78_n192), .A2(mult_78_n189), .ZN(
        mult_78_n105) );
  NOR2_X1 mult_78_U198 ( .A1(mult_78_n192), .A2(mult_78_n190), .ZN(
        mult_78_n106) );
  NAND2_X1 mult_78_U197 ( .A1(b1[8]), .A2(u_del_vec[7]), .ZN(mult_78_n107) );
  NOR2_X1 mult_78_U196 ( .A1(mult_78_n179), .A2(mult_78_n193), .ZN(
        mult_78_n108) );
  NOR2_X1 mult_78_U195 ( .A1(mult_78_n181), .A2(mult_78_n193), .ZN(
        mult_78_n109) );
  NOR2_X1 mult_78_U194 ( .A1(mult_78_n182), .A2(mult_78_n193), .ZN(
        mult_78_n110) );
  NOR2_X1 mult_78_U193 ( .A1(mult_78_n185), .A2(mult_78_n193), .ZN(
        mult_78_n111) );
  NOR2_X1 mult_78_U192 ( .A1(mult_78_n187), .A2(mult_78_n193), .ZN(
        mult_78_n112) );
  NOR2_X1 mult_78_U191 ( .A1(mult_78_n189), .A2(mult_78_n193), .ZN(
        mult_78_n113) );
  NOR2_X1 mult_78_U190 ( .A1(mult_78_n190), .A2(mult_78_n193), .ZN(
        mult_78_n114) );
  NAND2_X1 mult_78_U189 ( .A1(b1[7]), .A2(u_del_vec[7]), .ZN(mult_78_n115) );
  NOR2_X1 mult_78_U188 ( .A1(mult_78_n179), .A2(mult_78_n194), .ZN(
        mult_78_n116) );
  NOR2_X1 mult_78_U187 ( .A1(mult_78_n181), .A2(mult_78_n194), .ZN(
        mult_78_n117) );
  NOR2_X1 mult_78_U186 ( .A1(mult_78_n182), .A2(mult_78_n194), .ZN(
        mult_78_n118) );
  NOR2_X1 mult_78_U185 ( .A1(mult_78_n185), .A2(mult_78_n194), .ZN(
        mult_78_n119) );
  NOR2_X1 mult_78_U184 ( .A1(mult_78_n187), .A2(mult_78_n194), .ZN(
        mult_78_n120) );
  NOR2_X1 mult_78_U183 ( .A1(mult_78_n189), .A2(mult_78_n194), .ZN(
        mult_78_n121) );
  NAND2_X1 mult_78_U182 ( .A1(b1[6]), .A2(u_del_vec[7]), .ZN(mult_78_n123) );
  NOR2_X1 mult_78_U181 ( .A1(mult_78_n179), .A2(mult_78_n195), .ZN(
        mult_78_n124) );
  NOR2_X1 mult_78_U180 ( .A1(mult_78_n181), .A2(mult_78_n195), .ZN(
        mult_78_n125) );
  NOR2_X1 mult_78_U179 ( .A1(mult_78_n182), .A2(mult_78_n195), .ZN(
        mult_78_n126) );
  NOR2_X1 mult_78_U178 ( .A1(mult_78_n185), .A2(mult_78_n195), .ZN(
        mult_78_n127) );
  NOR2_X1 mult_78_U177 ( .A1(mult_78_n187), .A2(mult_78_n195), .ZN(
        mult_78_n128) );
  NOR2_X1 mult_78_U176 ( .A1(mult_78_n189), .A2(mult_78_n195), .ZN(
        mult_78_n129) );
  NAND2_X1 mult_78_U175 ( .A1(b1[5]), .A2(u_del_vec[7]), .ZN(mult_78_n131) );
  NOR2_X1 mult_78_U174 ( .A1(mult_78_n181), .A2(mult_78_n196), .ZN(
        mult_78_n133) );
  NOR2_X1 mult_78_U173 ( .A1(mult_78_n182), .A2(mult_78_n196), .ZN(
        mult_78_n134) );
  NOR2_X1 mult_78_U172 ( .A1(mult_78_n185), .A2(mult_78_n196), .ZN(
        mult_78_n135) );
  NOR2_X1 mult_78_U171 ( .A1(mult_78_n187), .A2(mult_78_n196), .ZN(
        mult_78_n136) );
  NAND2_X1 mult_78_U170 ( .A1(u_del_vec[2]), .A2(b1[10]), .ZN(mult_78_n54) );
  NAND2_X1 mult_78_U169 ( .A1(b1[5]), .A2(u_del_vec[6]), .ZN(mult_78_n208) );
  NAND2_X1 mult_78_U168 ( .A1(u_del_vec[2]), .A2(b1[9]), .ZN(mult_78_n207) );
  NAND2_X1 mult_78_U167 ( .A1(mult_78_n208), .A2(mult_78_n207), .ZN(
        mult_78_n63) );
  XNOR2_X1 mult_78_U166 ( .A(mult_78_n207), .B(mult_78_n208), .ZN(mult_78_n64)
         );
  NOR4_X1 mult_78_U165 ( .A1(mult_78_n195), .A2(mult_78_n196), .A3(
        mult_78_n189), .A4(mult_78_n190), .ZN(mult_78_n205) );
  NOR2_X1 mult_78_U164 ( .A1(mult_78_n194), .A2(mult_78_n190), .ZN(
        mult_78_n206) );
  AOI222_X1 mult_78_U163 ( .A1(mult_78_n84), .A2(mult_78_n205), .B1(
        mult_78_n206), .B2(mult_78_n84), .C1(mult_78_n206), .C2(mult_78_n205), 
        .ZN(mult_78_n204) );
  OAI222_X1 mult_78_U162 ( .A1(mult_78_n204), .A2(mult_78_n184), .B1(
        mult_78_n184), .B2(mult_78_n188), .C1(mult_78_n204), .C2(mult_78_n188), 
        .ZN(mult_78_n203) );
  AOI222_X1 mult_78_U161 ( .A1(mult_78_n203), .A2(mult_78_n74), .B1(
        mult_78_n203), .B2(mult_78_n76), .C1(mult_78_n76), .C2(mult_78_n74), 
        .ZN(mult_78_n202) );
  OAI222_X1 mult_78_U160 ( .A1(mult_78_n202), .A2(mult_78_n180), .B1(
        mult_78_n202), .B2(mult_78_n183), .C1(mult_78_n183), .C2(mult_78_n180), 
        .ZN(mult_78_n8) );
  NAND2_X1 mult_78_U159 ( .A1(u_del_vec[5]), .A2(b1[11]), .ZN(mult_78_n86) );
  NAND2_X1 mult_78_U158 ( .A1(u_del_vec[4]), .A2(b1[11]), .ZN(mult_78_n87) );
  NAND2_X1 mult_78_U157 ( .A1(u_del_vec[3]), .A2(b1[11]), .ZN(mult_78_n88) );
  NAND2_X1 mult_78_U156 ( .A1(u_del_vec[2]), .A2(b1[11]), .ZN(mult_78_n89) );
  NAND2_X1 mult_78_U155 ( .A1(u_del_vec[1]), .A2(b1[11]), .ZN(mult_78_n90) );
  NAND2_X1 mult_78_U154 ( .A1(u_del_vec[0]), .A2(b1[11]), .ZN(mult_78_n91) );
  NOR2_X1 mult_78_U153 ( .A1(mult_78_n191), .A2(mult_78_n179), .ZN(mult_78_n93) );
  NOR2_X1 mult_78_U152 ( .A1(mult_78_n191), .A2(mult_78_n181), .ZN(mult_78_n94) );
  NOR2_X1 mult_78_U151 ( .A1(mult_78_n191), .A2(mult_78_n182), .ZN(mult_78_n95) );
  NOR2_X1 mult_78_U150 ( .A1(mult_78_n191), .A2(mult_78_n185), .ZN(mult_78_n96) );
  NOR2_X1 mult_78_U149 ( .A1(mult_78_n191), .A2(mult_78_n189), .ZN(mult_78_n97) );
  NOR2_X1 mult_78_U148 ( .A1(mult_78_n191), .A2(mult_78_n190), .ZN(mult_78_n98) );
  NAND2_X1 mult_78_U147 ( .A1(b1[9]), .A2(u_del_vec[7]), .ZN(mult_78_n99) );
  XNOR2_X1 mult_78_U146 ( .A(mult_78_n2), .B(mult_78_n17), .ZN(mult_78_n201)
         );
  XOR2_X1 mult_78_U145 ( .A(mult_78_n201), .B(mult_78_n15), .Z(mult_78_n197)
         );
  NAND2_X1 mult_78_U144 ( .A1(u_del_vec[7]), .A2(b1[10]), .ZN(mult_78_n199) );
  AND2_X1 mult_78_U143 ( .A1(u_del_vec[6]), .A2(b1[11]), .ZN(mult_78_n200) );
  XOR2_X1 mult_78_U142 ( .A(mult_78_n199), .B(mult_78_n200), .Z(mult_78_n198)
         );
  XOR2_X1 mult_78_U141 ( .A(mult_78_n197), .B(mult_78_n198), .Z(mulb1[12]) );
  INV_X1 mult_78_U140 ( .A(u_del_vec[0]), .ZN(mult_78_n190) );
  INV_X1 mult_78_U139 ( .A(u_del_vec[6]), .ZN(mult_78_n179) );
  INV_X1 mult_78_U138 ( .A(u_del_vec[1]), .ZN(mult_78_n189) );
  INV_X1 mult_78_U137 ( .A(u_del_vec[5]), .ZN(mult_78_n181) );
  INV_X1 mult_78_U136 ( .A(u_del_vec[4]), .ZN(mult_78_n182) );
  INV_X1 mult_78_U135 ( .A(u_del_vec[3]), .ZN(mult_78_n185) );
  INV_X1 mult_78_U134 ( .A(u_del_vec[2]), .ZN(mult_78_n187) );
  INV_X1 mult_78_U133 ( .A(b1[5]), .ZN(mult_78_n196) );
  INV_X1 mult_78_U132 ( .A(b1[9]), .ZN(mult_78_n192) );
  INV_X1 mult_78_U131 ( .A(b1[10]), .ZN(mult_78_n191) );
  INV_X1 mult_78_U130 ( .A(b1[8]), .ZN(mult_78_n193) );
  INV_X1 mult_78_U129 ( .A(b1[7]), .ZN(mult_78_n194) );
  INV_X1 mult_78_U128 ( .A(b1[6]), .ZN(mult_78_n195) );
  INV_X1 mult_78_U127 ( .A(mult_78_n54), .ZN(mult_78_n186) );
  INV_X1 mult_78_U126 ( .A(mult_78_n80), .ZN(mult_78_n184) );
  INV_X1 mult_78_U125 ( .A(mult_78_n66), .ZN(mult_78_n180) );
  INV_X1 mult_78_U124 ( .A(mult_78_n73), .ZN(mult_78_n183) );
  INV_X1 mult_78_U123 ( .A(mult_78_n82), .ZN(mult_78_n188) );
  HA_X1 mult_78_U51 ( .A(mult_78_n129), .B(mult_78_n136), .CO(mult_78_n83), 
        .S(mult_78_n84) );
  HA_X1 mult_78_U50 ( .A(mult_78_n114), .B(mult_78_n121), .CO(mult_78_n81), 
        .S(mult_78_n82) );
  FA_X1 mult_78_U49 ( .A(mult_78_n128), .B(mult_78_n135), .CI(mult_78_n83), 
        .CO(mult_78_n79), .S(mult_78_n80) );
  HA_X1 mult_78_U48 ( .A(mult_78_n106), .B(mult_78_n113), .CO(mult_78_n77), 
        .S(mult_78_n78) );
  FA_X1 mult_78_U47 ( .A(mult_78_n120), .B(mult_78_n134), .CI(mult_78_n127), 
        .CO(mult_78_n75), .S(mult_78_n76) );
  FA_X1 mult_78_U46 ( .A(mult_78_n78), .B(mult_78_n81), .CI(mult_78_n79), .CO(
        mult_78_n73), .S(mult_78_n74) );
  HA_X1 mult_78_U45 ( .A(mult_78_n98), .B(mult_78_n105), .CO(mult_78_n71), .S(
        mult_78_n72) );
  FA_X1 mult_78_U44 ( .A(mult_78_n112), .B(mult_78_n133), .CI(mult_78_n119), 
        .CO(mult_78_n69), .S(mult_78_n70) );
  FA_X1 mult_78_U43 ( .A(mult_78_n77), .B(mult_78_n126), .CI(mult_78_n72), 
        .CO(mult_78_n67), .S(mult_78_n68) );
  FA_X1 mult_78_U42 ( .A(mult_78_n70), .B(mult_78_n75), .CI(mult_78_n68), .CO(
        mult_78_n65), .S(mult_78_n66) );
  FA_X1 mult_78_U39 ( .A(mult_78_n97), .B(mult_78_n125), .CI(mult_78_n111), 
        .CO(mult_78_n61), .S(mult_78_n62) );
  FA_X1 mult_78_U38 ( .A(mult_78_n91), .B(mult_78_n118), .CI(mult_78_n71), 
        .CO(mult_78_n59), .S(mult_78_n60) );
  FA_X1 mult_78_U37 ( .A(mult_78_n69), .B(mult_78_n64), .CI(mult_78_n62), .CO(
        mult_78_n57), .S(mult_78_n58) );
  FA_X1 mult_78_U36 ( .A(mult_78_n60), .B(mult_78_n67), .CI(mult_78_n58), .CO(
        mult_78_n55), .S(mult_78_n56) );
  FA_X1 mult_78_U34 ( .A(mult_78_n103), .B(mult_78_n110), .CI(mult_78_n124), 
        .CO(mult_78_n51), .S(mult_78_n52) );
  FA_X1 mult_78_U33 ( .A(mult_78_n131), .B(mult_78_n117), .CI(mult_78_n90), 
        .CO(mult_78_n49), .S(mult_78_n50) );
  FA_X1 mult_78_U32 ( .A(mult_78_n63), .B(mult_78_n54), .CI(mult_78_n61), .CO(
        mult_78_n47), .S(mult_78_n48) );
  FA_X1 mult_78_U31 ( .A(mult_78_n52), .B(mult_78_n59), .CI(mult_78_n50), .CO(
        mult_78_n45), .S(mult_78_n46) );
  FA_X1 mult_78_U30 ( .A(mult_78_n48), .B(mult_78_n57), .CI(mult_78_n46), .CO(
        mult_78_n43), .S(mult_78_n44) );
  FA_X1 mult_78_U29 ( .A(mult_78_n102), .B(mult_78_n186), .CI(mult_78_n96), 
        .CO(mult_78_n41), .S(mult_78_n42) );
  FA_X1 mult_78_U28 ( .A(mult_78_n116), .B(mult_78_n109), .CI(mult_78_n123), 
        .CO(mult_78_n39), .S(mult_78_n40) );
  FA_X1 mult_78_U27 ( .A(mult_78_n51), .B(mult_78_n89), .CI(mult_78_n49), .CO(
        mult_78_n37), .S(mult_78_n38) );
  FA_X1 mult_78_U26 ( .A(mult_78_n40), .B(mult_78_n42), .CI(mult_78_n47), .CO(
        mult_78_n35), .S(mult_78_n36) );
  FA_X1 mult_78_U25 ( .A(mult_78_n38), .B(mult_78_n45), .CI(mult_78_n36), .CO(
        mult_78_n33), .S(mult_78_n34) );
  FA_X1 mult_78_U24 ( .A(mult_78_n95), .B(mult_78_n101), .CI(mult_78_n108), 
        .CO(mult_78_n31), .S(mult_78_n32) );
  FA_X1 mult_78_U23 ( .A(mult_78_n88), .B(mult_78_n115), .CI(mult_78_n41), 
        .CO(mult_78_n29), .S(mult_78_n30) );
  FA_X1 mult_78_U22 ( .A(mult_78_n32), .B(mult_78_n39), .CI(mult_78_n37), .CO(
        mult_78_n27), .S(mult_78_n28) );
  FA_X1 mult_78_U21 ( .A(mult_78_n35), .B(mult_78_n30), .CI(mult_78_n28), .CO(
        mult_78_n25), .S(mult_78_n26) );
  FA_X1 mult_78_U20 ( .A(mult_78_n94), .B(mult_78_n100), .CI(mult_78_n107), 
        .CO(mult_78_n23), .S(mult_78_n24) );
  FA_X1 mult_78_U19 ( .A(mult_78_n31), .B(mult_78_n87), .CI(mult_78_n24), .CO(
        mult_78_n21), .S(mult_78_n22) );
  FA_X1 mult_78_U18 ( .A(mult_78_n27), .B(mult_78_n29), .CI(mult_78_n22), .CO(
        mult_78_n19), .S(mult_78_n20) );
  FA_X1 mult_78_U17 ( .A(mult_78_n99), .B(mult_78_n93), .CI(mult_78_n86), .CO(
        mult_78_n17), .S(mult_78_n18) );
  FA_X1 mult_78_U16 ( .A(mult_78_n18), .B(mult_78_n23), .CI(mult_78_n21), .CO(
        mult_78_n15), .S(mult_78_n16) );
  FA_X1 mult_78_U8 ( .A(mult_78_n56), .B(mult_78_n65), .CI(mult_78_n8), .CO(
        mult_78_n7), .S(mulb1[6]) );
  FA_X1 mult_78_U7 ( .A(mult_78_n44), .B(mult_78_n55), .CI(mult_78_n7), .CO(
        mult_78_n6), .S(mulb1[7]) );
  FA_X1 mult_78_U6 ( .A(mult_78_n34), .B(mult_78_n43), .CI(mult_78_n6), .CO(
        mult_78_n5), .S(mulb1[8]) );
  FA_X1 mult_78_U5 ( .A(mult_78_n26), .B(mult_78_n33), .CI(mult_78_n5), .CO(
        mult_78_n4), .S(mulb1[9]) );
  FA_X1 mult_78_U4 ( .A(mult_78_n20), .B(mult_78_n25), .CI(mult_78_n4), .CO(
        mult_78_n3), .S(mulb1[10]) );
  FA_X1 mult_78_U3 ( .A(mult_78_n19), .B(mult_78_n16), .CI(mult_78_n3), .CO(
        mult_78_n2), .S(mulb1[11]) );
  NOR2_X1 mult_73_U203 ( .A1(mult_73_n179), .A2(mult_73_n192), .ZN(
        mult_73_n100) );
  NOR2_X1 mult_73_U202 ( .A1(mult_73_n192), .A2(mult_73_n181), .ZN(
        mult_73_n101) );
  NOR2_X1 mult_73_U201 ( .A1(mult_73_n192), .A2(mult_73_n182), .ZN(
        mult_73_n102) );
  NOR2_X1 mult_73_U200 ( .A1(mult_73_n192), .A2(mult_73_n185), .ZN(
        mult_73_n103) );
  NOR2_X1 mult_73_U199 ( .A1(mult_73_n192), .A2(mult_73_n189), .ZN(
        mult_73_n105) );
  NOR2_X1 mult_73_U198 ( .A1(mult_73_n192), .A2(mult_73_n190), .ZN(
        mult_73_n106) );
  NAND2_X1 mult_73_U197 ( .A1(b0[8]), .A2(u_del_vec[7]), .ZN(mult_73_n107) );
  NOR2_X1 mult_73_U196 ( .A1(mult_73_n179), .A2(mult_73_n193), .ZN(
        mult_73_n108) );
  NOR2_X1 mult_73_U195 ( .A1(mult_73_n181), .A2(mult_73_n193), .ZN(
        mult_73_n109) );
  NOR2_X1 mult_73_U194 ( .A1(mult_73_n182), .A2(mult_73_n193), .ZN(
        mult_73_n110) );
  NOR2_X1 mult_73_U193 ( .A1(mult_73_n185), .A2(mult_73_n193), .ZN(
        mult_73_n111) );
  NOR2_X1 mult_73_U192 ( .A1(mult_73_n187), .A2(mult_73_n193), .ZN(
        mult_73_n112) );
  NOR2_X1 mult_73_U191 ( .A1(mult_73_n189), .A2(mult_73_n193), .ZN(
        mult_73_n113) );
  NOR2_X1 mult_73_U190 ( .A1(mult_73_n190), .A2(mult_73_n193), .ZN(
        mult_73_n114) );
  NAND2_X1 mult_73_U189 ( .A1(b0[7]), .A2(u_del_vec[7]), .ZN(mult_73_n115) );
  NOR2_X1 mult_73_U188 ( .A1(mult_73_n179), .A2(mult_73_n194), .ZN(
        mult_73_n116) );
  NOR2_X1 mult_73_U187 ( .A1(mult_73_n181), .A2(mult_73_n194), .ZN(
        mult_73_n117) );
  NOR2_X1 mult_73_U186 ( .A1(mult_73_n182), .A2(mult_73_n194), .ZN(
        mult_73_n118) );
  NOR2_X1 mult_73_U185 ( .A1(mult_73_n185), .A2(mult_73_n194), .ZN(
        mult_73_n119) );
  NOR2_X1 mult_73_U184 ( .A1(mult_73_n187), .A2(mult_73_n194), .ZN(
        mult_73_n120) );
  NOR2_X1 mult_73_U183 ( .A1(mult_73_n189), .A2(mult_73_n194), .ZN(
        mult_73_n121) );
  NAND2_X1 mult_73_U182 ( .A1(b0[6]), .A2(u_del_vec[7]), .ZN(mult_73_n123) );
  NOR2_X1 mult_73_U181 ( .A1(mult_73_n179), .A2(mult_73_n195), .ZN(
        mult_73_n124) );
  NOR2_X1 mult_73_U180 ( .A1(mult_73_n181), .A2(mult_73_n195), .ZN(
        mult_73_n125) );
  NOR2_X1 mult_73_U179 ( .A1(mult_73_n182), .A2(mult_73_n195), .ZN(
        mult_73_n126) );
  NOR2_X1 mult_73_U178 ( .A1(mult_73_n185), .A2(mult_73_n195), .ZN(
        mult_73_n127) );
  NOR2_X1 mult_73_U177 ( .A1(mult_73_n187), .A2(mult_73_n195), .ZN(
        mult_73_n128) );
  NOR2_X1 mult_73_U176 ( .A1(mult_73_n189), .A2(mult_73_n195), .ZN(
        mult_73_n129) );
  NAND2_X1 mult_73_U175 ( .A1(b0[5]), .A2(u_del_vec[7]), .ZN(mult_73_n131) );
  NOR2_X1 mult_73_U174 ( .A1(mult_73_n181), .A2(mult_73_n196), .ZN(
        mult_73_n133) );
  NOR2_X1 mult_73_U173 ( .A1(mult_73_n182), .A2(mult_73_n196), .ZN(
        mult_73_n134) );
  NOR2_X1 mult_73_U172 ( .A1(mult_73_n185), .A2(mult_73_n196), .ZN(
        mult_73_n135) );
  NOR2_X1 mult_73_U171 ( .A1(mult_73_n187), .A2(mult_73_n196), .ZN(
        mult_73_n136) );
  NAND2_X1 mult_73_U170 ( .A1(u_del_vec[2]), .A2(b0[10]), .ZN(mult_73_n54) );
  NAND2_X1 mult_73_U169 ( .A1(b0[5]), .A2(u_del_vec[6]), .ZN(mult_73_n208) );
  NAND2_X1 mult_73_U168 ( .A1(u_del_vec[2]), .A2(b0[9]), .ZN(mult_73_n207) );
  NAND2_X1 mult_73_U167 ( .A1(mult_73_n208), .A2(mult_73_n207), .ZN(
        mult_73_n63) );
  XNOR2_X1 mult_73_U166 ( .A(mult_73_n207), .B(mult_73_n208), .ZN(mult_73_n64)
         );
  NOR4_X1 mult_73_U165 ( .A1(mult_73_n195), .A2(mult_73_n196), .A3(
        mult_73_n189), .A4(mult_73_n190), .ZN(mult_73_n205) );
  NOR2_X1 mult_73_U164 ( .A1(mult_73_n194), .A2(mult_73_n190), .ZN(
        mult_73_n206) );
  AOI222_X1 mult_73_U163 ( .A1(mult_73_n84), .A2(mult_73_n205), .B1(
        mult_73_n206), .B2(mult_73_n84), .C1(mult_73_n206), .C2(mult_73_n205), 
        .ZN(mult_73_n204) );
  OAI222_X1 mult_73_U162 ( .A1(mult_73_n204), .A2(mult_73_n184), .B1(
        mult_73_n184), .B2(mult_73_n188), .C1(mult_73_n204), .C2(mult_73_n188), 
        .ZN(mult_73_n203) );
  AOI222_X1 mult_73_U161 ( .A1(mult_73_n203), .A2(mult_73_n74), .B1(
        mult_73_n203), .B2(mult_73_n76), .C1(mult_73_n76), .C2(mult_73_n74), 
        .ZN(mult_73_n202) );
  OAI222_X1 mult_73_U160 ( .A1(mult_73_n202), .A2(mult_73_n180), .B1(
        mult_73_n202), .B2(mult_73_n183), .C1(mult_73_n183), .C2(mult_73_n180), 
        .ZN(mult_73_n8) );
  NAND2_X1 mult_73_U159 ( .A1(u_del_vec[5]), .A2(b0[11]), .ZN(mult_73_n86) );
  NAND2_X1 mult_73_U158 ( .A1(u_del_vec[4]), .A2(b0[11]), .ZN(mult_73_n87) );
  NAND2_X1 mult_73_U157 ( .A1(u_del_vec[3]), .A2(b0[11]), .ZN(mult_73_n88) );
  NAND2_X1 mult_73_U156 ( .A1(u_del_vec[2]), .A2(b0[11]), .ZN(mult_73_n89) );
  NAND2_X1 mult_73_U155 ( .A1(u_del_vec[1]), .A2(b0[11]), .ZN(mult_73_n90) );
  NAND2_X1 mult_73_U154 ( .A1(u_del_vec[0]), .A2(b0[11]), .ZN(mult_73_n91) );
  NOR2_X1 mult_73_U153 ( .A1(mult_73_n191), .A2(mult_73_n179), .ZN(mult_73_n93) );
  NOR2_X1 mult_73_U152 ( .A1(mult_73_n191), .A2(mult_73_n181), .ZN(mult_73_n94) );
  NOR2_X1 mult_73_U151 ( .A1(mult_73_n191), .A2(mult_73_n182), .ZN(mult_73_n95) );
  NOR2_X1 mult_73_U150 ( .A1(mult_73_n191), .A2(mult_73_n185), .ZN(mult_73_n96) );
  NOR2_X1 mult_73_U149 ( .A1(mult_73_n191), .A2(mult_73_n189), .ZN(mult_73_n97) );
  NOR2_X1 mult_73_U148 ( .A1(mult_73_n191), .A2(mult_73_n190), .ZN(mult_73_n98) );
  NAND2_X1 mult_73_U147 ( .A1(b0[9]), .A2(u_del_vec[7]), .ZN(mult_73_n99) );
  XNOR2_X1 mult_73_U146 ( .A(mult_73_n2), .B(mult_73_n17), .ZN(mult_73_n201)
         );
  XOR2_X1 mult_73_U145 ( .A(mult_73_n201), .B(mult_73_n15), .Z(mult_73_n197)
         );
  NAND2_X1 mult_73_U144 ( .A1(u_del_vec[7]), .A2(b0[10]), .ZN(mult_73_n199) );
  AND2_X1 mult_73_U143 ( .A1(u_del_vec[6]), .A2(b0[11]), .ZN(mult_73_n200) );
  XOR2_X1 mult_73_U142 ( .A(mult_73_n199), .B(mult_73_n200), .Z(mult_73_n198)
         );
  XOR2_X1 mult_73_U141 ( .A(mult_73_n197), .B(mult_73_n198), .Z(mulb0[12]) );
  INV_X1 mult_73_U140 ( .A(u_del_vec[0]), .ZN(mult_73_n190) );
  INV_X1 mult_73_U139 ( .A(u_del_vec[6]), .ZN(mult_73_n179) );
  INV_X1 mult_73_U138 ( .A(u_del_vec[1]), .ZN(mult_73_n189) );
  INV_X1 mult_73_U137 ( .A(u_del_vec[5]), .ZN(mult_73_n181) );
  INV_X1 mult_73_U136 ( .A(u_del_vec[4]), .ZN(mult_73_n182) );
  INV_X1 mult_73_U135 ( .A(u_del_vec[3]), .ZN(mult_73_n185) );
  INV_X1 mult_73_U134 ( .A(u_del_vec[2]), .ZN(mult_73_n187) );
  INV_X1 mult_73_U133 ( .A(b0[5]), .ZN(mult_73_n196) );
  INV_X1 mult_73_U132 ( .A(b0[9]), .ZN(mult_73_n192) );
  INV_X1 mult_73_U131 ( .A(b0[10]), .ZN(mult_73_n191) );
  INV_X1 mult_73_U130 ( .A(b0[8]), .ZN(mult_73_n193) );
  INV_X1 mult_73_U129 ( .A(b0[7]), .ZN(mult_73_n194) );
  INV_X1 mult_73_U128 ( .A(b0[6]), .ZN(mult_73_n195) );
  INV_X1 mult_73_U127 ( .A(mult_73_n54), .ZN(mult_73_n186) );
  INV_X1 mult_73_U126 ( .A(mult_73_n80), .ZN(mult_73_n184) );
  INV_X1 mult_73_U125 ( .A(mult_73_n66), .ZN(mult_73_n180) );
  INV_X1 mult_73_U124 ( .A(mult_73_n73), .ZN(mult_73_n183) );
  INV_X1 mult_73_U123 ( .A(mult_73_n82), .ZN(mult_73_n188) );
  HA_X1 mult_73_U51 ( .A(mult_73_n129), .B(mult_73_n136), .CO(mult_73_n83), 
        .S(mult_73_n84) );
  HA_X1 mult_73_U50 ( .A(mult_73_n114), .B(mult_73_n121), .CO(mult_73_n81), 
        .S(mult_73_n82) );
  FA_X1 mult_73_U49 ( .A(mult_73_n128), .B(mult_73_n135), .CI(mult_73_n83), 
        .CO(mult_73_n79), .S(mult_73_n80) );
  HA_X1 mult_73_U48 ( .A(mult_73_n106), .B(mult_73_n113), .CO(mult_73_n77), 
        .S(mult_73_n78) );
  FA_X1 mult_73_U47 ( .A(mult_73_n120), .B(mult_73_n134), .CI(mult_73_n127), 
        .CO(mult_73_n75), .S(mult_73_n76) );
  FA_X1 mult_73_U46 ( .A(mult_73_n78), .B(mult_73_n81), .CI(mult_73_n79), .CO(
        mult_73_n73), .S(mult_73_n74) );
  HA_X1 mult_73_U45 ( .A(mult_73_n98), .B(mult_73_n105), .CO(mult_73_n71), .S(
        mult_73_n72) );
  FA_X1 mult_73_U44 ( .A(mult_73_n112), .B(mult_73_n133), .CI(mult_73_n119), 
        .CO(mult_73_n69), .S(mult_73_n70) );
  FA_X1 mult_73_U43 ( .A(mult_73_n77), .B(mult_73_n126), .CI(mult_73_n72), 
        .CO(mult_73_n67), .S(mult_73_n68) );
  FA_X1 mult_73_U42 ( .A(mult_73_n70), .B(mult_73_n75), .CI(mult_73_n68), .CO(
        mult_73_n65), .S(mult_73_n66) );
  FA_X1 mult_73_U39 ( .A(mult_73_n97), .B(mult_73_n125), .CI(mult_73_n111), 
        .CO(mult_73_n61), .S(mult_73_n62) );
  FA_X1 mult_73_U38 ( .A(mult_73_n91), .B(mult_73_n118), .CI(mult_73_n71), 
        .CO(mult_73_n59), .S(mult_73_n60) );
  FA_X1 mult_73_U37 ( .A(mult_73_n69), .B(mult_73_n64), .CI(mult_73_n62), .CO(
        mult_73_n57), .S(mult_73_n58) );
  FA_X1 mult_73_U36 ( .A(mult_73_n60), .B(mult_73_n67), .CI(mult_73_n58), .CO(
        mult_73_n55), .S(mult_73_n56) );
  FA_X1 mult_73_U34 ( .A(mult_73_n103), .B(mult_73_n110), .CI(mult_73_n124), 
        .CO(mult_73_n51), .S(mult_73_n52) );
  FA_X1 mult_73_U33 ( .A(mult_73_n131), .B(mult_73_n117), .CI(mult_73_n90), 
        .CO(mult_73_n49), .S(mult_73_n50) );
  FA_X1 mult_73_U32 ( .A(mult_73_n63), .B(mult_73_n54), .CI(mult_73_n61), .CO(
        mult_73_n47), .S(mult_73_n48) );
  FA_X1 mult_73_U31 ( .A(mult_73_n52), .B(mult_73_n59), .CI(mult_73_n50), .CO(
        mult_73_n45), .S(mult_73_n46) );
  FA_X1 mult_73_U30 ( .A(mult_73_n48), .B(mult_73_n57), .CI(mult_73_n46), .CO(
        mult_73_n43), .S(mult_73_n44) );
  FA_X1 mult_73_U29 ( .A(mult_73_n102), .B(mult_73_n186), .CI(mult_73_n96), 
        .CO(mult_73_n41), .S(mult_73_n42) );
  FA_X1 mult_73_U28 ( .A(mult_73_n116), .B(mult_73_n109), .CI(mult_73_n123), 
        .CO(mult_73_n39), .S(mult_73_n40) );
  FA_X1 mult_73_U27 ( .A(mult_73_n51), .B(mult_73_n89), .CI(mult_73_n49), .CO(
        mult_73_n37), .S(mult_73_n38) );
  FA_X1 mult_73_U26 ( .A(mult_73_n40), .B(mult_73_n42), .CI(mult_73_n47), .CO(
        mult_73_n35), .S(mult_73_n36) );
  FA_X1 mult_73_U25 ( .A(mult_73_n38), .B(mult_73_n45), .CI(mult_73_n36), .CO(
        mult_73_n33), .S(mult_73_n34) );
  FA_X1 mult_73_U24 ( .A(mult_73_n95), .B(mult_73_n101), .CI(mult_73_n108), 
        .CO(mult_73_n31), .S(mult_73_n32) );
  FA_X1 mult_73_U23 ( .A(mult_73_n88), .B(mult_73_n115), .CI(mult_73_n41), 
        .CO(mult_73_n29), .S(mult_73_n30) );
  FA_X1 mult_73_U22 ( .A(mult_73_n32), .B(mult_73_n39), .CI(mult_73_n37), .CO(
        mult_73_n27), .S(mult_73_n28) );
  FA_X1 mult_73_U21 ( .A(mult_73_n35), .B(mult_73_n30), .CI(mult_73_n28), .CO(
        mult_73_n25), .S(mult_73_n26) );
  FA_X1 mult_73_U20 ( .A(mult_73_n94), .B(mult_73_n100), .CI(mult_73_n107), 
        .CO(mult_73_n23), .S(mult_73_n24) );
  FA_X1 mult_73_U19 ( .A(mult_73_n31), .B(mult_73_n87), .CI(mult_73_n24), .CO(
        mult_73_n21), .S(mult_73_n22) );
  FA_X1 mult_73_U18 ( .A(mult_73_n27), .B(mult_73_n29), .CI(mult_73_n22), .CO(
        mult_73_n19), .S(mult_73_n20) );
  FA_X1 mult_73_U17 ( .A(mult_73_n99), .B(mult_73_n93), .CI(mult_73_n86), .CO(
        mult_73_n17), .S(mult_73_n18) );
  FA_X1 mult_73_U16 ( .A(mult_73_n18), .B(mult_73_n23), .CI(mult_73_n21), .CO(
        mult_73_n15), .S(mult_73_n16) );
  FA_X1 mult_73_U8 ( .A(mult_73_n56), .B(mult_73_n65), .CI(mult_73_n8), .CO(
        mult_73_n7), .S(mulb0[6]) );
  FA_X1 mult_73_U7 ( .A(mult_73_n44), .B(mult_73_n55), .CI(mult_73_n7), .CO(
        mult_73_n6), .S(mulb0[7]) );
  FA_X1 mult_73_U6 ( .A(mult_73_n34), .B(mult_73_n43), .CI(mult_73_n6), .CO(
        mult_73_n5), .S(mulb0[8]) );
  FA_X1 mult_73_U5 ( .A(mult_73_n26), .B(mult_73_n33), .CI(mult_73_n5), .CO(
        mult_73_n4), .S(mulb0[9]) );
  FA_X1 mult_73_U4 ( .A(mult_73_n20), .B(mult_73_n25), .CI(mult_73_n4), .CO(
        mult_73_n3), .S(mulb0[10]) );
  FA_X1 mult_73_U3 ( .A(mult_73_n19), .B(mult_73_n16), .CI(mult_73_n3), .CO(
        mult_73_n2), .S(mulb0[11]) );
  NOR2_X1 mult_68_U203 ( .A1(mult_68_n179), .A2(mult_68_n192), .ZN(
        mult_68_n100) );
  NOR2_X1 mult_68_U202 ( .A1(mult_68_n192), .A2(mult_68_n181), .ZN(
        mult_68_n101) );
  NOR2_X1 mult_68_U201 ( .A1(mult_68_n192), .A2(mult_68_n182), .ZN(
        mult_68_n102) );
  NOR2_X1 mult_68_U200 ( .A1(mult_68_n192), .A2(mult_68_n185), .ZN(
        mult_68_n103) );
  NOR2_X1 mult_68_U199 ( .A1(mult_68_n192), .A2(mult_68_n189), .ZN(
        mult_68_n105) );
  NOR2_X1 mult_68_U198 ( .A1(mult_68_n192), .A2(mult_68_n190), .ZN(
        mult_68_n106) );
  NAND2_X1 mult_68_U197 ( .A1(a1[8]), .A2(u_del_vec[7]), .ZN(mult_68_n107) );
  NOR2_X1 mult_68_U196 ( .A1(mult_68_n179), .A2(mult_68_n193), .ZN(
        mult_68_n108) );
  NOR2_X1 mult_68_U195 ( .A1(mult_68_n181), .A2(mult_68_n193), .ZN(
        mult_68_n109) );
  NOR2_X1 mult_68_U194 ( .A1(mult_68_n182), .A2(mult_68_n193), .ZN(
        mult_68_n110) );
  NOR2_X1 mult_68_U193 ( .A1(mult_68_n185), .A2(mult_68_n193), .ZN(
        mult_68_n111) );
  NOR2_X1 mult_68_U192 ( .A1(mult_68_n187), .A2(mult_68_n193), .ZN(
        mult_68_n112) );
  NOR2_X1 mult_68_U191 ( .A1(mult_68_n189), .A2(mult_68_n193), .ZN(
        mult_68_n113) );
  NOR2_X1 mult_68_U190 ( .A1(mult_68_n190), .A2(mult_68_n193), .ZN(
        mult_68_n114) );
  NAND2_X1 mult_68_U189 ( .A1(a1[7]), .A2(u_del_vec[7]), .ZN(mult_68_n115) );
  NOR2_X1 mult_68_U188 ( .A1(mult_68_n179), .A2(mult_68_n194), .ZN(
        mult_68_n116) );
  NOR2_X1 mult_68_U187 ( .A1(mult_68_n181), .A2(mult_68_n194), .ZN(
        mult_68_n117) );
  NOR2_X1 mult_68_U186 ( .A1(mult_68_n182), .A2(mult_68_n194), .ZN(
        mult_68_n118) );
  NOR2_X1 mult_68_U185 ( .A1(mult_68_n185), .A2(mult_68_n194), .ZN(
        mult_68_n119) );
  NOR2_X1 mult_68_U184 ( .A1(mult_68_n187), .A2(mult_68_n194), .ZN(
        mult_68_n120) );
  NOR2_X1 mult_68_U183 ( .A1(mult_68_n189), .A2(mult_68_n194), .ZN(
        mult_68_n121) );
  NAND2_X1 mult_68_U182 ( .A1(a1[6]), .A2(u_del_vec[7]), .ZN(mult_68_n123) );
  NOR2_X1 mult_68_U181 ( .A1(mult_68_n179), .A2(mult_68_n195), .ZN(
        mult_68_n124) );
  NOR2_X1 mult_68_U180 ( .A1(mult_68_n181), .A2(mult_68_n195), .ZN(
        mult_68_n125) );
  NOR2_X1 mult_68_U179 ( .A1(mult_68_n182), .A2(mult_68_n195), .ZN(
        mult_68_n126) );
  NOR2_X1 mult_68_U178 ( .A1(mult_68_n185), .A2(mult_68_n195), .ZN(
        mult_68_n127) );
  NOR2_X1 mult_68_U177 ( .A1(mult_68_n187), .A2(mult_68_n195), .ZN(
        mult_68_n128) );
  NOR2_X1 mult_68_U176 ( .A1(mult_68_n189), .A2(mult_68_n195), .ZN(
        mult_68_n129) );
  NAND2_X1 mult_68_U175 ( .A1(a1[5]), .A2(u_del_vec[7]), .ZN(mult_68_n131) );
  NOR2_X1 mult_68_U174 ( .A1(mult_68_n181), .A2(mult_68_n196), .ZN(
        mult_68_n133) );
  NOR2_X1 mult_68_U173 ( .A1(mult_68_n182), .A2(mult_68_n196), .ZN(
        mult_68_n134) );
  NOR2_X1 mult_68_U172 ( .A1(mult_68_n185), .A2(mult_68_n196), .ZN(
        mult_68_n135) );
  NOR2_X1 mult_68_U171 ( .A1(mult_68_n187), .A2(mult_68_n196), .ZN(
        mult_68_n136) );
  NAND2_X1 mult_68_U170 ( .A1(u_del_vec[2]), .A2(a1[10]), .ZN(mult_68_n54) );
  NAND2_X1 mult_68_U169 ( .A1(a1[5]), .A2(u_del_vec[6]), .ZN(mult_68_n208) );
  NAND2_X1 mult_68_U168 ( .A1(u_del_vec[2]), .A2(a1[9]), .ZN(mult_68_n207) );
  NAND2_X1 mult_68_U167 ( .A1(mult_68_n208), .A2(mult_68_n207), .ZN(
        mult_68_n63) );
  XNOR2_X1 mult_68_U166 ( .A(mult_68_n207), .B(mult_68_n208), .ZN(mult_68_n64)
         );
  NOR4_X1 mult_68_U165 ( .A1(mult_68_n195), .A2(mult_68_n196), .A3(
        mult_68_n189), .A4(mult_68_n190), .ZN(mult_68_n205) );
  NOR2_X1 mult_68_U164 ( .A1(mult_68_n194), .A2(mult_68_n190), .ZN(
        mult_68_n206) );
  AOI222_X1 mult_68_U163 ( .A1(mult_68_n84), .A2(mult_68_n205), .B1(
        mult_68_n206), .B2(mult_68_n84), .C1(mult_68_n206), .C2(mult_68_n205), 
        .ZN(mult_68_n204) );
  OAI222_X1 mult_68_U162 ( .A1(mult_68_n204), .A2(mult_68_n184), .B1(
        mult_68_n184), .B2(mult_68_n188), .C1(mult_68_n204), .C2(mult_68_n188), 
        .ZN(mult_68_n203) );
  AOI222_X1 mult_68_U161 ( .A1(mult_68_n203), .A2(mult_68_n74), .B1(
        mult_68_n203), .B2(mult_68_n76), .C1(mult_68_n76), .C2(mult_68_n74), 
        .ZN(mult_68_n202) );
  OAI222_X1 mult_68_U160 ( .A1(mult_68_n202), .A2(mult_68_n180), .B1(
        mult_68_n202), .B2(mult_68_n183), .C1(mult_68_n183), .C2(mult_68_n180), 
        .ZN(mult_68_n8) );
  NAND2_X1 mult_68_U159 ( .A1(u_del_vec[5]), .A2(a1[11]), .ZN(mult_68_n86) );
  NAND2_X1 mult_68_U158 ( .A1(u_del_vec[4]), .A2(a1[11]), .ZN(mult_68_n87) );
  NAND2_X1 mult_68_U157 ( .A1(u_del_vec[3]), .A2(a1[11]), .ZN(mult_68_n88) );
  NAND2_X1 mult_68_U156 ( .A1(u_del_vec[2]), .A2(a1[11]), .ZN(mult_68_n89) );
  NAND2_X1 mult_68_U155 ( .A1(u_del_vec[1]), .A2(a1[11]), .ZN(mult_68_n90) );
  NAND2_X1 mult_68_U154 ( .A1(u_del_vec[0]), .A2(a1[11]), .ZN(mult_68_n91) );
  NOR2_X1 mult_68_U153 ( .A1(mult_68_n191), .A2(mult_68_n179), .ZN(mult_68_n93) );
  NOR2_X1 mult_68_U152 ( .A1(mult_68_n191), .A2(mult_68_n181), .ZN(mult_68_n94) );
  NOR2_X1 mult_68_U151 ( .A1(mult_68_n191), .A2(mult_68_n182), .ZN(mult_68_n95) );
  NOR2_X1 mult_68_U150 ( .A1(mult_68_n191), .A2(mult_68_n185), .ZN(mult_68_n96) );
  NOR2_X1 mult_68_U149 ( .A1(mult_68_n191), .A2(mult_68_n189), .ZN(mult_68_n97) );
  NOR2_X1 mult_68_U148 ( .A1(mult_68_n191), .A2(mult_68_n190), .ZN(mult_68_n98) );
  NAND2_X1 mult_68_U147 ( .A1(a1[9]), .A2(u_del_vec[7]), .ZN(mult_68_n99) );
  XNOR2_X1 mult_68_U146 ( .A(mult_68_n2), .B(mult_68_n17), .ZN(mult_68_n201)
         );
  XOR2_X1 mult_68_U145 ( .A(mult_68_n201), .B(mult_68_n15), .Z(mult_68_n197)
         );
  NAND2_X1 mult_68_U144 ( .A1(u_del_vec[7]), .A2(a1[10]), .ZN(mult_68_n199) );
  AND2_X1 mult_68_U143 ( .A1(u_del_vec[6]), .A2(a1[11]), .ZN(mult_68_n200) );
  XOR2_X1 mult_68_U142 ( .A(mult_68_n199), .B(mult_68_n200), .Z(mult_68_n198)
         );
  XOR2_X1 mult_68_U141 ( .A(mult_68_n197), .B(mult_68_n198), .Z(mula1[12]) );
  INV_X1 mult_68_U140 ( .A(u_del_vec[0]), .ZN(mult_68_n190) );
  INV_X1 mult_68_U139 ( .A(u_del_vec[6]), .ZN(mult_68_n179) );
  INV_X1 mult_68_U138 ( .A(u_del_vec[1]), .ZN(mult_68_n189) );
  INV_X1 mult_68_U137 ( .A(u_del_vec[5]), .ZN(mult_68_n181) );
  INV_X1 mult_68_U136 ( .A(u_del_vec[4]), .ZN(mult_68_n182) );
  INV_X1 mult_68_U135 ( .A(u_del_vec[3]), .ZN(mult_68_n185) );
  INV_X1 mult_68_U134 ( .A(u_del_vec[2]), .ZN(mult_68_n187) );
  INV_X1 mult_68_U133 ( .A(a1[5]), .ZN(mult_68_n196) );
  INV_X1 mult_68_U132 ( .A(a1[9]), .ZN(mult_68_n192) );
  INV_X1 mult_68_U131 ( .A(a1[10]), .ZN(mult_68_n191) );
  INV_X1 mult_68_U130 ( .A(a1[8]), .ZN(mult_68_n193) );
  INV_X1 mult_68_U129 ( .A(a1[7]), .ZN(mult_68_n194) );
  INV_X1 mult_68_U128 ( .A(a1[6]), .ZN(mult_68_n195) );
  INV_X1 mult_68_U127 ( .A(mult_68_n54), .ZN(mult_68_n186) );
  INV_X1 mult_68_U126 ( .A(mult_68_n80), .ZN(mult_68_n184) );
  INV_X1 mult_68_U125 ( .A(mult_68_n66), .ZN(mult_68_n180) );
  INV_X1 mult_68_U124 ( .A(mult_68_n73), .ZN(mult_68_n183) );
  INV_X1 mult_68_U123 ( .A(mult_68_n82), .ZN(mult_68_n188) );
  HA_X1 mult_68_U51 ( .A(mult_68_n129), .B(mult_68_n136), .CO(mult_68_n83), 
        .S(mult_68_n84) );
  HA_X1 mult_68_U50 ( .A(mult_68_n114), .B(mult_68_n121), .CO(mult_68_n81), 
        .S(mult_68_n82) );
  FA_X1 mult_68_U49 ( .A(mult_68_n128), .B(mult_68_n135), .CI(mult_68_n83), 
        .CO(mult_68_n79), .S(mult_68_n80) );
  HA_X1 mult_68_U48 ( .A(mult_68_n106), .B(mult_68_n113), .CO(mult_68_n77), 
        .S(mult_68_n78) );
  FA_X1 mult_68_U47 ( .A(mult_68_n120), .B(mult_68_n134), .CI(mult_68_n127), 
        .CO(mult_68_n75), .S(mult_68_n76) );
  FA_X1 mult_68_U46 ( .A(mult_68_n78), .B(mult_68_n81), .CI(mult_68_n79), .CO(
        mult_68_n73), .S(mult_68_n74) );
  HA_X1 mult_68_U45 ( .A(mult_68_n98), .B(mult_68_n105), .CO(mult_68_n71), .S(
        mult_68_n72) );
  FA_X1 mult_68_U44 ( .A(mult_68_n112), .B(mult_68_n133), .CI(mult_68_n119), 
        .CO(mult_68_n69), .S(mult_68_n70) );
  FA_X1 mult_68_U43 ( .A(mult_68_n77), .B(mult_68_n126), .CI(mult_68_n72), 
        .CO(mult_68_n67), .S(mult_68_n68) );
  FA_X1 mult_68_U42 ( .A(mult_68_n70), .B(mult_68_n75), .CI(mult_68_n68), .CO(
        mult_68_n65), .S(mult_68_n66) );
  FA_X1 mult_68_U39 ( .A(mult_68_n97), .B(mult_68_n125), .CI(mult_68_n111), 
        .CO(mult_68_n61), .S(mult_68_n62) );
  FA_X1 mult_68_U38 ( .A(mult_68_n91), .B(mult_68_n118), .CI(mult_68_n71), 
        .CO(mult_68_n59), .S(mult_68_n60) );
  FA_X1 mult_68_U37 ( .A(mult_68_n69), .B(mult_68_n64), .CI(mult_68_n62), .CO(
        mult_68_n57), .S(mult_68_n58) );
  FA_X1 mult_68_U36 ( .A(mult_68_n60), .B(mult_68_n67), .CI(mult_68_n58), .CO(
        mult_68_n55), .S(mult_68_n56) );
  FA_X1 mult_68_U34 ( .A(mult_68_n103), .B(mult_68_n110), .CI(mult_68_n124), 
        .CO(mult_68_n51), .S(mult_68_n52) );
  FA_X1 mult_68_U33 ( .A(mult_68_n131), .B(mult_68_n117), .CI(mult_68_n90), 
        .CO(mult_68_n49), .S(mult_68_n50) );
  FA_X1 mult_68_U32 ( .A(mult_68_n63), .B(mult_68_n54), .CI(mult_68_n61), .CO(
        mult_68_n47), .S(mult_68_n48) );
  FA_X1 mult_68_U31 ( .A(mult_68_n52), .B(mult_68_n59), .CI(mult_68_n50), .CO(
        mult_68_n45), .S(mult_68_n46) );
  FA_X1 mult_68_U30 ( .A(mult_68_n48), .B(mult_68_n57), .CI(mult_68_n46), .CO(
        mult_68_n43), .S(mult_68_n44) );
  FA_X1 mult_68_U29 ( .A(mult_68_n102), .B(mult_68_n186), .CI(mult_68_n96), 
        .CO(mult_68_n41), .S(mult_68_n42) );
  FA_X1 mult_68_U28 ( .A(mult_68_n116), .B(mult_68_n109), .CI(mult_68_n123), 
        .CO(mult_68_n39), .S(mult_68_n40) );
  FA_X1 mult_68_U27 ( .A(mult_68_n51), .B(mult_68_n89), .CI(mult_68_n49), .CO(
        mult_68_n37), .S(mult_68_n38) );
  FA_X1 mult_68_U26 ( .A(mult_68_n40), .B(mult_68_n42), .CI(mult_68_n47), .CO(
        mult_68_n35), .S(mult_68_n36) );
  FA_X1 mult_68_U25 ( .A(mult_68_n38), .B(mult_68_n45), .CI(mult_68_n36), .CO(
        mult_68_n33), .S(mult_68_n34) );
  FA_X1 mult_68_U24 ( .A(mult_68_n95), .B(mult_68_n101), .CI(mult_68_n108), 
        .CO(mult_68_n31), .S(mult_68_n32) );
  FA_X1 mult_68_U23 ( .A(mult_68_n88), .B(mult_68_n115), .CI(mult_68_n41), 
        .CO(mult_68_n29), .S(mult_68_n30) );
  FA_X1 mult_68_U22 ( .A(mult_68_n32), .B(mult_68_n39), .CI(mult_68_n37), .CO(
        mult_68_n27), .S(mult_68_n28) );
  FA_X1 mult_68_U21 ( .A(mult_68_n35), .B(mult_68_n30), .CI(mult_68_n28), .CO(
        mult_68_n25), .S(mult_68_n26) );
  FA_X1 mult_68_U20 ( .A(mult_68_n94), .B(mult_68_n100), .CI(mult_68_n107), 
        .CO(mult_68_n23), .S(mult_68_n24) );
  FA_X1 mult_68_U19 ( .A(mult_68_n31), .B(mult_68_n87), .CI(mult_68_n24), .CO(
        mult_68_n21), .S(mult_68_n22) );
  FA_X1 mult_68_U18 ( .A(mult_68_n27), .B(mult_68_n29), .CI(mult_68_n22), .CO(
        mult_68_n19), .S(mult_68_n20) );
  FA_X1 mult_68_U17 ( .A(mult_68_n99), .B(mult_68_n93), .CI(mult_68_n86), .CO(
        mult_68_n17), .S(mult_68_n18) );
  FA_X1 mult_68_U16 ( .A(mult_68_n18), .B(mult_68_n23), .CI(mult_68_n21), .CO(
        mult_68_n15), .S(mult_68_n16) );
  FA_X1 mult_68_U8 ( .A(mult_68_n56), .B(mult_68_n65), .CI(mult_68_n8), .CO(
        mult_68_n7), .S(mula1[6]) );
  FA_X1 mult_68_U7 ( .A(mult_68_n44), .B(mult_68_n55), .CI(mult_68_n7), .CO(
        mult_68_n6), .S(mula1[7]) );
  FA_X1 mult_68_U6 ( .A(mult_68_n34), .B(mult_68_n43), .CI(mult_68_n6), .CO(
        mult_68_n5), .S(mula1[8]) );
  FA_X1 mult_68_U5 ( .A(mult_68_n26), .B(mult_68_n33), .CI(mult_68_n5), .CO(
        mult_68_n4), .S(mula1[9]) );
  FA_X1 mult_68_U4 ( .A(mult_68_n20), .B(mult_68_n25), .CI(mult_68_n4), .CO(
        mult_68_n3), .S(mula1[10]) );
  FA_X1 mult_68_U3 ( .A(mult_68_n19), .B(mult_68_n16), .CI(mult_68_n3), .CO(
        mult_68_n2), .S(mula1[11]) );
endmodule

