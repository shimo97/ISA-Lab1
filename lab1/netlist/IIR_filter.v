/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP4
// Date      : Tue Oct 26 14:11:05 2021
/////////////////////////////////////////////////////////////


module IIR_filter ( CLK, RST_n, DIN, VIN, b0, b1, a1, DOUT, VOUT );
  input [11:0] DIN;
  input [11:0] b0;
  input [11:0] b1;
  input [11:0] a1;
  output [11:0] DOUT;
  input CLK, RST_n, VIN;
  output VOUT;
  wire   q1, regX0_n21, regX0_n20, regX0_n19, regX0_n18, regX0_n17, regX0_n16,
         regX0_n15, regX0_n14, regX0_n13, regX0_n12, regX0_n11, regX0_n10,
         regX0_n9, regX0_n8, regX0_n7, regX0_n6, regX0_n5, regX0_n4, regX0_n3,
         regX0_n2, regX0_n1, regU_n26, regU_n25, regU_n24, regU_n23, regU_n22,
         regU_n21, regU_n20, regU_n19, regU_n18, regU_n17, regU_n16, regU_n15,
         regU_n14, regU_n13, regU_n12, regU_n11, regU_n10, regU_n9, regU_n8,
         regU_n7, regU_n6, regU_n5, regU_n4, regU_n3, regU_n2, regU_n1,
         regY_n50, regY_n49, regY_n48, regY_n47, regY_n46, regY_n45, regY_n44,
         regY_n43, regY_n42, regY_n41, regY_n40, regY_n39, regY_n38, regY_n37,
         regY_n36, regY_n35, regY_n34, regY_n33, regY_n32, regY_n31, regY_n30,
         regY_n29, regY_n28, regY_n27, regY_n26, regY_n25, add_72_n2,
         add_56_n1, mult_64_n208, mult_64_n207, mult_64_n206, mult_64_n205,
         mult_64_n204, mult_64_n203, mult_64_n202, mult_64_n201, mult_64_n200,
         mult_64_n199, mult_64_n198, mult_64_n197, mult_64_n196, mult_64_n195,
         mult_64_n194, mult_64_n193, mult_64_n192, mult_64_n191, mult_64_n190,
         mult_64_n189, mult_64_n188, mult_64_n187, mult_64_n186, mult_64_n185,
         mult_64_n184, mult_64_n183, mult_64_n182, mult_64_n181, mult_64_n180,
         mult_64_n179, mult_64_n136, mult_64_n135, mult_64_n134, mult_64_n133,
         mult_64_n131, mult_64_n129, mult_64_n128, mult_64_n127, mult_64_n126,
         mult_64_n125, mult_64_n124, mult_64_n123, mult_64_n121, mult_64_n120,
         mult_64_n119, mult_64_n118, mult_64_n117, mult_64_n116, mult_64_n115,
         mult_64_n114, mult_64_n113, mult_64_n112, mult_64_n111, mult_64_n110,
         mult_64_n109, mult_64_n108, mult_64_n107, mult_64_n106, mult_64_n105,
         mult_64_n103, mult_64_n102, mult_64_n101, mult_64_n100, mult_64_n99,
         mult_64_n98, mult_64_n97, mult_64_n96, mult_64_n95, mult_64_n94,
         mult_64_n93, mult_64_n91, mult_64_n90, mult_64_n89, mult_64_n88,
         mult_64_n87, mult_64_n86, mult_64_n84, mult_64_n83, mult_64_n82,
         mult_64_n81, mult_64_n80, mult_64_n79, mult_64_n78, mult_64_n77,
         mult_64_n76, mult_64_n75, mult_64_n74, mult_64_n73, mult_64_n72,
         mult_64_n71, mult_64_n70, mult_64_n69, mult_64_n68, mult_64_n67,
         mult_64_n66, mult_64_n65, mult_64_n64, mult_64_n63, mult_64_n62,
         mult_64_n61, mult_64_n60, mult_64_n59, mult_64_n58, mult_64_n57,
         mult_64_n56, mult_64_n55, mult_64_n54, mult_64_n52, mult_64_n51,
         mult_64_n50, mult_64_n49, mult_64_n48, mult_64_n47, mult_64_n46,
         mult_64_n45, mult_64_n44, mult_64_n43, mult_64_n42, mult_64_n41,
         mult_64_n40, mult_64_n39, mult_64_n38, mult_64_n37, mult_64_n36,
         mult_64_n35, mult_64_n34, mult_64_n33, mult_64_n32, mult_64_n31,
         mult_64_n30, mult_64_n29, mult_64_n28, mult_64_n27, mult_64_n26,
         mult_64_n25, mult_64_n24, mult_64_n23, mult_64_n22, mult_64_n21,
         mult_64_n20, mult_64_n19, mult_64_n18, mult_64_n17, mult_64_n16,
         mult_64_n15, mult_64_n8, mult_64_n7, mult_64_n6, mult_64_n5,
         mult_64_n4, mult_64_n3, mult_64_n2, mult_68_n208, mult_68_n207,
         mult_68_n206, mult_68_n205, mult_68_n204, mult_68_n203, mult_68_n202,
         mult_68_n201, mult_68_n200, mult_68_n199, mult_68_n198, mult_68_n197,
         mult_68_n196, mult_68_n195, mult_68_n194, mult_68_n193, mult_68_n192,
         mult_68_n191, mult_68_n190, mult_68_n189, mult_68_n188, mult_68_n187,
         mult_68_n186, mult_68_n185, mult_68_n184, mult_68_n183, mult_68_n182,
         mult_68_n181, mult_68_n180, mult_68_n179, mult_68_n136, mult_68_n135,
         mult_68_n134, mult_68_n133, mult_68_n131, mult_68_n129, mult_68_n128,
         mult_68_n127, mult_68_n126, mult_68_n125, mult_68_n124, mult_68_n123,
         mult_68_n121, mult_68_n120, mult_68_n119, mult_68_n118, mult_68_n117,
         mult_68_n116, mult_68_n115, mult_68_n114, mult_68_n113, mult_68_n112,
         mult_68_n111, mult_68_n110, mult_68_n109, mult_68_n108, mult_68_n107,
         mult_68_n106, mult_68_n105, mult_68_n103, mult_68_n102, mult_68_n101,
         mult_68_n100, mult_68_n99, mult_68_n98, mult_68_n97, mult_68_n96,
         mult_68_n95, mult_68_n94, mult_68_n93, mult_68_n91, mult_68_n90,
         mult_68_n89, mult_68_n88, mult_68_n87, mult_68_n86, mult_68_n84,
         mult_68_n83, mult_68_n82, mult_68_n81, mult_68_n80, mult_68_n79,
         mult_68_n78, mult_68_n77, mult_68_n76, mult_68_n75, mult_68_n74,
         mult_68_n73, mult_68_n72, mult_68_n71, mult_68_n70, mult_68_n69,
         mult_68_n68, mult_68_n67, mult_68_n66, mult_68_n65, mult_68_n64,
         mult_68_n63, mult_68_n62, mult_68_n61, mult_68_n60, mult_68_n59,
         mult_68_n58, mult_68_n57, mult_68_n56, mult_68_n55, mult_68_n54,
         mult_68_n52, mult_68_n51, mult_68_n50, mult_68_n49, mult_68_n48,
         mult_68_n47, mult_68_n46, mult_68_n45, mult_68_n44, mult_68_n43,
         mult_68_n42, mult_68_n41, mult_68_n40, mult_68_n39, mult_68_n38,
         mult_68_n37, mult_68_n36, mult_68_n35, mult_68_n34, mult_68_n33,
         mult_68_n32, mult_68_n31, mult_68_n30, mult_68_n29, mult_68_n28,
         mult_68_n27, mult_68_n26, mult_68_n25, mult_68_n24, mult_68_n23,
         mult_68_n22, mult_68_n21, mult_68_n20, mult_68_n19, mult_68_n18,
         mult_68_n17, mult_68_n16, mult_68_n15, mult_68_n8, mult_68_n7,
         mult_68_n6, mult_68_n5, mult_68_n4, mult_68_n3, mult_68_n2,
         mult_66_n208, mult_66_n207, mult_66_n206, mult_66_n205, mult_66_n204,
         mult_66_n203, mult_66_n202, mult_66_n201, mult_66_n200, mult_66_n199,
         mult_66_n198, mult_66_n197, mult_66_n196, mult_66_n195, mult_66_n194,
         mult_66_n193, mult_66_n192, mult_66_n191, mult_66_n190, mult_66_n189,
         mult_66_n188, mult_66_n187, mult_66_n186, mult_66_n185, mult_66_n184,
         mult_66_n183, mult_66_n182, mult_66_n181, mult_66_n180, mult_66_n179,
         mult_66_n136, mult_66_n135, mult_66_n134, mult_66_n133, mult_66_n131,
         mult_66_n129, mult_66_n128, mult_66_n127, mult_66_n126, mult_66_n125,
         mult_66_n124, mult_66_n123, mult_66_n121, mult_66_n120, mult_66_n119,
         mult_66_n118, mult_66_n117, mult_66_n116, mult_66_n115, mult_66_n114,
         mult_66_n113, mult_66_n112, mult_66_n111, mult_66_n110, mult_66_n109,
         mult_66_n108, mult_66_n107, mult_66_n106, mult_66_n105, mult_66_n103,
         mult_66_n102, mult_66_n101, mult_66_n100, mult_66_n99, mult_66_n98,
         mult_66_n97, mult_66_n96, mult_66_n95, mult_66_n94, mult_66_n93,
         mult_66_n91, mult_66_n90, mult_66_n89, mult_66_n88, mult_66_n87,
         mult_66_n86, mult_66_n84, mult_66_n83, mult_66_n82, mult_66_n81,
         mult_66_n80, mult_66_n79, mult_66_n78, mult_66_n77, mult_66_n76,
         mult_66_n75, mult_66_n74, mult_66_n73, mult_66_n72, mult_66_n71,
         mult_66_n70, mult_66_n69, mult_66_n68, mult_66_n67, mult_66_n66,
         mult_66_n65, mult_66_n64, mult_66_n63, mult_66_n62, mult_66_n61,
         mult_66_n60, mult_66_n59, mult_66_n58, mult_66_n57, mult_66_n56,
         mult_66_n55, mult_66_n54, mult_66_n52, mult_66_n51, mult_66_n50,
         mult_66_n49, mult_66_n48, mult_66_n47, mult_66_n46, mult_66_n45,
         mult_66_n44, mult_66_n43, mult_66_n42, mult_66_n41, mult_66_n40,
         mult_66_n39, mult_66_n38, mult_66_n37, mult_66_n36, mult_66_n35,
         mult_66_n34, mult_66_n33, mult_66_n32, mult_66_n31, mult_66_n30,
         mult_66_n29, mult_66_n28, mult_66_n27, mult_66_n26, mult_66_n25,
         mult_66_n24, mult_66_n23, mult_66_n22, mult_66_n21, mult_66_n20,
         mult_66_n19, mult_66_n18, mult_66_n17, mult_66_n16, mult_66_n15,
         mult_66_n8, mult_66_n7, mult_66_n6, mult_66_n5, mult_66_n4,
         mult_66_n3, mult_66_n2;
  wire   [6:0] din_del;
  wire   [7:0] u;
  wire   [7:0] u_del_vec;
  wire   [12:6] mula1;
  wire   [12:6] mulb0;
  wire   [12:6] mulb1;
  wire   [7:0] y;
  wire   [7:2] add_72_carry;
  wire   [7:2] add_56_carry;
  assign DOUT[0] = 1'b0;
  assign DOUT[1] = 1'b0;
  assign DOUT[2] = 1'b0;
  assign DOUT[3] = 1'b0;

  NAND2_X1 regX0_U15 ( .A1(DIN[11]), .A2(VIN), .ZN(regX0_n7) );
  OAI21_X1 regX0_U14 ( .B1(regX0_n14), .B2(VIN), .A(regX0_n7), .ZN(regX0_n21)
         );
  NAND2_X1 regX0_U13 ( .A1(DIN[10]), .A2(VIN), .ZN(regX0_n6) );
  OAI21_X1 regX0_U12 ( .B1(regX0_n13), .B2(VIN), .A(regX0_n6), .ZN(regX0_n20)
         );
  NAND2_X1 regX0_U11 ( .A1(DIN[9]), .A2(VIN), .ZN(regX0_n5) );
  OAI21_X1 regX0_U10 ( .B1(regX0_n12), .B2(VIN), .A(regX0_n5), .ZN(regX0_n19)
         );
  NAND2_X1 regX0_U9 ( .A1(DIN[8]), .A2(VIN), .ZN(regX0_n4) );
  OAI21_X1 regX0_U8 ( .B1(regX0_n11), .B2(VIN), .A(regX0_n4), .ZN(regX0_n18)
         );
  NAND2_X1 regX0_U7 ( .A1(DIN[7]), .A2(VIN), .ZN(regX0_n3) );
  OAI21_X1 regX0_U6 ( .B1(regX0_n10), .B2(VIN), .A(regX0_n3), .ZN(regX0_n17)
         );
  NAND2_X1 regX0_U5 ( .A1(DIN[6]), .A2(VIN), .ZN(regX0_n2) );
  OAI21_X1 regX0_U4 ( .B1(regX0_n9), .B2(VIN), .A(regX0_n2), .ZN(regX0_n16) );
  NAND2_X1 regX0_U3 ( .A1(VIN), .A2(DIN[5]), .ZN(regX0_n1) );
  OAI21_X1 regX0_U2 ( .B1(regX0_n8), .B2(VIN), .A(regX0_n1), .ZN(regX0_n15) );
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
  BUF_X1 regU_U19 ( .A(q1), .Z(regU_n26) );
  BUF_X1 regU_U18 ( .A(q1), .Z(regU_n25) );
  NAND2_X1 regU_U17 ( .A1(u[3]), .A2(regU_n25), .ZN(regU_n4) );
  OAI21_X1 regU_U16 ( .B1(regU_n12), .B2(regU_n25), .A(regU_n4), .ZN(regU_n20)
         );
  NAND2_X1 regU_U15 ( .A1(u[2]), .A2(regU_n25), .ZN(regU_n3) );
  OAI21_X1 regU_U14 ( .B1(regU_n11), .B2(regU_n25), .A(regU_n3), .ZN(regU_n19)
         );
  NAND2_X1 regU_U13 ( .A1(u[1]), .A2(regU_n25), .ZN(regU_n2) );
  OAI21_X1 regU_U12 ( .B1(regU_n10), .B2(regU_n25), .A(regU_n2), .ZN(regU_n18)
         );
  NAND2_X1 regU_U11 ( .A1(regU_n26), .A2(u[0]), .ZN(regU_n1) );
  OAI21_X1 regU_U10 ( .B1(regU_n9), .B2(regU_n26), .A(regU_n1), .ZN(regU_n17)
         );
  NAND2_X1 regU_U9 ( .A1(u[7]), .A2(regU_n25), .ZN(regU_n8) );
  OAI21_X1 regU_U8 ( .B1(regU_n16), .B2(regU_n26), .A(regU_n8), .ZN(regU_n24)
         );
  NAND2_X1 regU_U7 ( .A1(u[6]), .A2(regU_n25), .ZN(regU_n7) );
  OAI21_X1 regU_U6 ( .B1(regU_n15), .B2(regU_n26), .A(regU_n7), .ZN(regU_n23)
         );
  NAND2_X1 regU_U5 ( .A1(u[5]), .A2(regU_n25), .ZN(regU_n6) );
  OAI21_X1 regU_U4 ( .B1(regU_n14), .B2(regU_n25), .A(regU_n6), .ZN(regU_n22)
         );
  NAND2_X1 regU_U3 ( .A1(u[4]), .A2(regU_n25), .ZN(regU_n5) );
  OAI21_X1 regU_U2 ( .B1(regU_n13), .B2(regU_n25), .A(regU_n5), .ZN(regU_n21)
         );
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
  BUF_X1 regY_U19 ( .A(q1), .Z(regY_n26) );
  BUF_X1 regY_U18 ( .A(q1), .Z(regY_n25) );
  NAND2_X1 regY_U17 ( .A1(regY_n26), .A2(y[0]), .ZN(regY_n50) );
  OAI21_X1 regY_U16 ( .B1(regY_n42), .B2(regY_n26), .A(regY_n50), .ZN(regY_n34) );
  NAND2_X1 regY_U15 ( .A1(y[7]), .A2(regY_n25), .ZN(regY_n43) );
  OAI21_X1 regY_U14 ( .B1(regY_n35), .B2(regY_n26), .A(regY_n43), .ZN(regY_n27) );
  NAND2_X1 regY_U13 ( .A1(y[6]), .A2(regY_n25), .ZN(regY_n44) );
  OAI21_X1 regY_U12 ( .B1(regY_n36), .B2(regY_n26), .A(regY_n44), .ZN(regY_n28) );
  NAND2_X1 regY_U11 ( .A1(y[5]), .A2(regY_n25), .ZN(regY_n45) );
  OAI21_X1 regY_U10 ( .B1(regY_n37), .B2(regY_n25), .A(regY_n45), .ZN(regY_n29) );
  NAND2_X1 regY_U9 ( .A1(y[4]), .A2(regY_n25), .ZN(regY_n46) );
  OAI21_X1 regY_U8 ( .B1(regY_n38), .B2(regY_n25), .A(regY_n46), .ZN(regY_n30)
         );
  NAND2_X1 regY_U7 ( .A1(y[3]), .A2(regY_n25), .ZN(regY_n47) );
  OAI21_X1 regY_U6 ( .B1(regY_n39), .B2(regY_n25), .A(regY_n47), .ZN(regY_n31)
         );
  NAND2_X1 regY_U5 ( .A1(y[2]), .A2(regY_n25), .ZN(regY_n48) );
  OAI21_X1 regY_U4 ( .B1(regY_n40), .B2(regY_n25), .A(regY_n48), .ZN(regY_n32)
         );
  NAND2_X1 regY_U3 ( .A1(y[1]), .A2(regY_n25), .ZN(regY_n49) );
  OAI21_X1 regY_U2 ( .B1(regY_n41), .B2(regY_n25), .A(regY_n49), .ZN(regY_n33)
         );
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
  DFFR_X1 ff2_Q_reg ( .D(q1), .CK(CLK), .RN(RST_n), .Q(VOUT) );
  AND2_X1 add_72_U2 ( .A1(mulb1[6]), .A2(mulb0[6]), .ZN(add_72_n2) );
  XOR2_X1 add_72_U1 ( .A(mulb1[6]), .B(mulb0[6]), .Z(y[0]) );
  FA_X1 add_72_U1_1 ( .A(mulb0[7]), .B(mulb1[7]), .CI(add_72_n2), .CO(
        add_72_carry[2]), .S(y[1]) );
  FA_X1 add_72_U1_2 ( .A(mulb0[8]), .B(mulb1[8]), .CI(add_72_carry[2]), .CO(
        add_72_carry[3]), .S(y[2]) );
  FA_X1 add_72_U1_3 ( .A(mulb0[9]), .B(mulb1[9]), .CI(add_72_carry[3]), .CO(
        add_72_carry[4]), .S(y[3]) );
  FA_X1 add_72_U1_4 ( .A(mulb0[10]), .B(mulb1[10]), .CI(add_72_carry[4]), .CO(
        add_72_carry[5]), .S(y[4]) );
  FA_X1 add_72_U1_5 ( .A(mulb0[11]), .B(mulb1[11]), .CI(add_72_carry[5]), .CO(
        add_72_carry[6]), .S(y[5]) );
  FA_X1 add_72_U1_6 ( .A(mulb0[12]), .B(mulb1[12]), .CI(add_72_carry[6]), .CO(
        add_72_carry[7]), .S(y[6]) );
  FA_X1 add_72_U1_7 ( .A(mulb0[12]), .B(mulb1[12]), .CI(add_72_carry[7]), .S(
        y[7]) );
  XOR2_X1 add_56_U2 ( .A(mula1[6]), .B(din_del[0]), .Z(u[0]) );
  AND2_X1 add_56_U1 ( .A1(mula1[6]), .A2(din_del[0]), .ZN(add_56_n1) );
  FA_X1 add_56_U1_1 ( .A(din_del[1]), .B(mula1[7]), .CI(add_56_n1), .CO(
        add_56_carry[2]), .S(u[1]) );
  FA_X1 add_56_U1_2 ( .A(din_del[2]), .B(mula1[8]), .CI(add_56_carry[2]), .CO(
        add_56_carry[3]), .S(u[2]) );
  FA_X1 add_56_U1_3 ( .A(din_del[3]), .B(mula1[9]), .CI(add_56_carry[3]), .CO(
        add_56_carry[4]), .S(u[3]) );
  FA_X1 add_56_U1_4 ( .A(din_del[4]), .B(mula1[10]), .CI(add_56_carry[4]), 
        .CO(add_56_carry[5]), .S(u[4]) );
  FA_X1 add_56_U1_5 ( .A(din_del[5]), .B(mula1[11]), .CI(add_56_carry[5]), 
        .CO(add_56_carry[6]), .S(u[5]) );
  FA_X1 add_56_U1_6 ( .A(din_del[6]), .B(mula1[12]), .CI(add_56_carry[6]), 
        .CO(add_56_carry[7]), .S(u[6]) );
  FA_X1 add_56_U1_7 ( .A(din_del[6]), .B(mula1[12]), .CI(add_56_carry[7]), .S(
        u[7]) );
  NOR2_X1 mult_64_U203 ( .A1(mult_64_n179), .A2(mult_64_n192), .ZN(
        mult_64_n100) );
  NOR2_X1 mult_64_U202 ( .A1(mult_64_n192), .A2(mult_64_n181), .ZN(
        mult_64_n101) );
  NOR2_X1 mult_64_U201 ( .A1(mult_64_n192), .A2(mult_64_n182), .ZN(
        mult_64_n102) );
  NOR2_X1 mult_64_U200 ( .A1(mult_64_n192), .A2(mult_64_n185), .ZN(
        mult_64_n103) );
  NOR2_X1 mult_64_U199 ( .A1(mult_64_n192), .A2(mult_64_n189), .ZN(
        mult_64_n105) );
  NOR2_X1 mult_64_U198 ( .A1(mult_64_n192), .A2(mult_64_n190), .ZN(
        mult_64_n106) );
  NAND2_X1 mult_64_U197 ( .A1(a1[8]), .A2(u_del_vec[7]), .ZN(mult_64_n107) );
  NOR2_X1 mult_64_U196 ( .A1(mult_64_n179), .A2(mult_64_n193), .ZN(
        mult_64_n108) );
  NOR2_X1 mult_64_U195 ( .A1(mult_64_n181), .A2(mult_64_n193), .ZN(
        mult_64_n109) );
  NOR2_X1 mult_64_U194 ( .A1(mult_64_n182), .A2(mult_64_n193), .ZN(
        mult_64_n110) );
  NOR2_X1 mult_64_U193 ( .A1(mult_64_n185), .A2(mult_64_n193), .ZN(
        mult_64_n111) );
  NOR2_X1 mult_64_U192 ( .A1(mult_64_n187), .A2(mult_64_n193), .ZN(
        mult_64_n112) );
  NOR2_X1 mult_64_U191 ( .A1(mult_64_n189), .A2(mult_64_n193), .ZN(
        mult_64_n113) );
  NOR2_X1 mult_64_U190 ( .A1(mult_64_n190), .A2(mult_64_n193), .ZN(
        mult_64_n114) );
  NAND2_X1 mult_64_U189 ( .A1(a1[7]), .A2(u_del_vec[7]), .ZN(mult_64_n115) );
  NOR2_X1 mult_64_U188 ( .A1(mult_64_n179), .A2(mult_64_n194), .ZN(
        mult_64_n116) );
  NOR2_X1 mult_64_U187 ( .A1(mult_64_n181), .A2(mult_64_n194), .ZN(
        mult_64_n117) );
  NOR2_X1 mult_64_U186 ( .A1(mult_64_n182), .A2(mult_64_n194), .ZN(
        mult_64_n118) );
  NOR2_X1 mult_64_U185 ( .A1(mult_64_n185), .A2(mult_64_n194), .ZN(
        mult_64_n119) );
  NOR2_X1 mult_64_U184 ( .A1(mult_64_n187), .A2(mult_64_n194), .ZN(
        mult_64_n120) );
  NOR2_X1 mult_64_U183 ( .A1(mult_64_n189), .A2(mult_64_n194), .ZN(
        mult_64_n121) );
  NAND2_X1 mult_64_U182 ( .A1(a1[6]), .A2(u_del_vec[7]), .ZN(mult_64_n123) );
  NOR2_X1 mult_64_U181 ( .A1(mult_64_n179), .A2(mult_64_n195), .ZN(
        mult_64_n124) );
  NOR2_X1 mult_64_U180 ( .A1(mult_64_n181), .A2(mult_64_n195), .ZN(
        mult_64_n125) );
  NOR2_X1 mult_64_U179 ( .A1(mult_64_n182), .A2(mult_64_n195), .ZN(
        mult_64_n126) );
  NOR2_X1 mult_64_U178 ( .A1(mult_64_n185), .A2(mult_64_n195), .ZN(
        mult_64_n127) );
  NOR2_X1 mult_64_U177 ( .A1(mult_64_n187), .A2(mult_64_n195), .ZN(
        mult_64_n128) );
  NOR2_X1 mult_64_U176 ( .A1(mult_64_n189), .A2(mult_64_n195), .ZN(
        mult_64_n129) );
  NAND2_X1 mult_64_U175 ( .A1(a1[5]), .A2(u_del_vec[7]), .ZN(mult_64_n131) );
  NOR2_X1 mult_64_U174 ( .A1(mult_64_n181), .A2(mult_64_n196), .ZN(
        mult_64_n133) );
  NOR2_X1 mult_64_U173 ( .A1(mult_64_n182), .A2(mult_64_n196), .ZN(
        mult_64_n134) );
  NOR2_X1 mult_64_U172 ( .A1(mult_64_n185), .A2(mult_64_n196), .ZN(
        mult_64_n135) );
  NOR2_X1 mult_64_U171 ( .A1(mult_64_n187), .A2(mult_64_n196), .ZN(
        mult_64_n136) );
  NAND2_X1 mult_64_U170 ( .A1(u_del_vec[2]), .A2(a1[10]), .ZN(mult_64_n54) );
  NAND2_X1 mult_64_U169 ( .A1(a1[5]), .A2(u_del_vec[6]), .ZN(mult_64_n208) );
  NAND2_X1 mult_64_U168 ( .A1(u_del_vec[2]), .A2(a1[9]), .ZN(mult_64_n207) );
  NAND2_X1 mult_64_U167 ( .A1(mult_64_n208), .A2(mult_64_n207), .ZN(
        mult_64_n63) );
  XNOR2_X1 mult_64_U166 ( .A(mult_64_n207), .B(mult_64_n208), .ZN(mult_64_n64)
         );
  NOR4_X1 mult_64_U165 ( .A1(mult_64_n195), .A2(mult_64_n196), .A3(
        mult_64_n189), .A4(mult_64_n190), .ZN(mult_64_n205) );
  NOR2_X1 mult_64_U164 ( .A1(mult_64_n194), .A2(mult_64_n190), .ZN(
        mult_64_n206) );
  AOI222_X1 mult_64_U163 ( .A1(mult_64_n84), .A2(mult_64_n205), .B1(
        mult_64_n206), .B2(mult_64_n84), .C1(mult_64_n206), .C2(mult_64_n205), 
        .ZN(mult_64_n204) );
  OAI222_X1 mult_64_U162 ( .A1(mult_64_n204), .A2(mult_64_n184), .B1(
        mult_64_n184), .B2(mult_64_n188), .C1(mult_64_n204), .C2(mult_64_n188), 
        .ZN(mult_64_n203) );
  AOI222_X1 mult_64_U161 ( .A1(mult_64_n203), .A2(mult_64_n74), .B1(
        mult_64_n203), .B2(mult_64_n76), .C1(mult_64_n76), .C2(mult_64_n74), 
        .ZN(mult_64_n202) );
  OAI222_X1 mult_64_U160 ( .A1(mult_64_n202), .A2(mult_64_n180), .B1(
        mult_64_n202), .B2(mult_64_n183), .C1(mult_64_n183), .C2(mult_64_n180), 
        .ZN(mult_64_n8) );
  NAND2_X1 mult_64_U159 ( .A1(u_del_vec[5]), .A2(a1[11]), .ZN(mult_64_n86) );
  NAND2_X1 mult_64_U158 ( .A1(u_del_vec[4]), .A2(a1[11]), .ZN(mult_64_n87) );
  NAND2_X1 mult_64_U157 ( .A1(u_del_vec[3]), .A2(a1[11]), .ZN(mult_64_n88) );
  NAND2_X1 mult_64_U156 ( .A1(u_del_vec[2]), .A2(a1[11]), .ZN(mult_64_n89) );
  NAND2_X1 mult_64_U155 ( .A1(u_del_vec[1]), .A2(a1[11]), .ZN(mult_64_n90) );
  NAND2_X1 mult_64_U154 ( .A1(u_del_vec[0]), .A2(a1[11]), .ZN(mult_64_n91) );
  NOR2_X1 mult_64_U153 ( .A1(mult_64_n191), .A2(mult_64_n179), .ZN(mult_64_n93) );
  NOR2_X1 mult_64_U152 ( .A1(mult_64_n191), .A2(mult_64_n181), .ZN(mult_64_n94) );
  NOR2_X1 mult_64_U151 ( .A1(mult_64_n191), .A2(mult_64_n182), .ZN(mult_64_n95) );
  NOR2_X1 mult_64_U150 ( .A1(mult_64_n191), .A2(mult_64_n185), .ZN(mult_64_n96) );
  NOR2_X1 mult_64_U149 ( .A1(mult_64_n191), .A2(mult_64_n189), .ZN(mult_64_n97) );
  NOR2_X1 mult_64_U148 ( .A1(mult_64_n191), .A2(mult_64_n190), .ZN(mult_64_n98) );
  NAND2_X1 mult_64_U147 ( .A1(a1[9]), .A2(u_del_vec[7]), .ZN(mult_64_n99) );
  XNOR2_X1 mult_64_U146 ( .A(mult_64_n2), .B(mult_64_n17), .ZN(mult_64_n201)
         );
  XOR2_X1 mult_64_U145 ( .A(mult_64_n201), .B(mult_64_n15), .Z(mult_64_n197)
         );
  NAND2_X1 mult_64_U144 ( .A1(u_del_vec[7]), .A2(a1[10]), .ZN(mult_64_n199) );
  AND2_X1 mult_64_U143 ( .A1(a1[11]), .A2(u_del_vec[6]), .ZN(mult_64_n200) );
  XOR2_X1 mult_64_U142 ( .A(mult_64_n199), .B(mult_64_n200), .Z(mult_64_n198)
         );
  XOR2_X1 mult_64_U141 ( .A(mult_64_n197), .B(mult_64_n198), .Z(mula1[12]) );
  INV_X1 mult_64_U140 ( .A(a1[5]), .ZN(mult_64_n196) );
  INV_X1 mult_64_U139 ( .A(u_del_vec[2]), .ZN(mult_64_n187) );
  INV_X1 mult_64_U138 ( .A(u_del_vec[0]), .ZN(mult_64_n190) );
  INV_X1 mult_64_U137 ( .A(u_del_vec[6]), .ZN(mult_64_n179) );
  INV_X1 mult_64_U136 ( .A(a1[9]), .ZN(mult_64_n192) );
  INV_X1 mult_64_U135 ( .A(a1[10]), .ZN(mult_64_n191) );
  INV_X1 mult_64_U134 ( .A(u_del_vec[1]), .ZN(mult_64_n189) );
  INV_X1 mult_64_U133 ( .A(u_del_vec[5]), .ZN(mult_64_n181) );
  INV_X1 mult_64_U132 ( .A(u_del_vec[4]), .ZN(mult_64_n182) );
  INV_X1 mult_64_U131 ( .A(u_del_vec[3]), .ZN(mult_64_n185) );
  INV_X1 mult_64_U130 ( .A(a1[8]), .ZN(mult_64_n193) );
  INV_X1 mult_64_U129 ( .A(a1[7]), .ZN(mult_64_n194) );
  INV_X1 mult_64_U128 ( .A(a1[6]), .ZN(mult_64_n195) );
  INV_X1 mult_64_U127 ( .A(mult_64_n54), .ZN(mult_64_n186) );
  INV_X1 mult_64_U126 ( .A(mult_64_n80), .ZN(mult_64_n184) );
  INV_X1 mult_64_U125 ( .A(mult_64_n66), .ZN(mult_64_n180) );
  INV_X1 mult_64_U124 ( .A(mult_64_n73), .ZN(mult_64_n183) );
  INV_X1 mult_64_U123 ( .A(mult_64_n82), .ZN(mult_64_n188) );
  HA_X1 mult_64_U51 ( .A(mult_64_n129), .B(mult_64_n136), .CO(mult_64_n83), 
        .S(mult_64_n84) );
  HA_X1 mult_64_U50 ( .A(mult_64_n114), .B(mult_64_n121), .CO(mult_64_n81), 
        .S(mult_64_n82) );
  FA_X1 mult_64_U49 ( .A(mult_64_n128), .B(mult_64_n135), .CI(mult_64_n83), 
        .CO(mult_64_n79), .S(mult_64_n80) );
  HA_X1 mult_64_U48 ( .A(mult_64_n106), .B(mult_64_n113), .CO(mult_64_n77), 
        .S(mult_64_n78) );
  FA_X1 mult_64_U47 ( .A(mult_64_n120), .B(mult_64_n134), .CI(mult_64_n127), 
        .CO(mult_64_n75), .S(mult_64_n76) );
  FA_X1 mult_64_U46 ( .A(mult_64_n78), .B(mult_64_n81), .CI(mult_64_n79), .CO(
        mult_64_n73), .S(mult_64_n74) );
  HA_X1 mult_64_U45 ( .A(mult_64_n98), .B(mult_64_n105), .CO(mult_64_n71), .S(
        mult_64_n72) );
  FA_X1 mult_64_U44 ( .A(mult_64_n112), .B(mult_64_n133), .CI(mult_64_n119), 
        .CO(mult_64_n69), .S(mult_64_n70) );
  FA_X1 mult_64_U43 ( .A(mult_64_n77), .B(mult_64_n126), .CI(mult_64_n72), 
        .CO(mult_64_n67), .S(mult_64_n68) );
  FA_X1 mult_64_U42 ( .A(mult_64_n70), .B(mult_64_n75), .CI(mult_64_n68), .CO(
        mult_64_n65), .S(mult_64_n66) );
  FA_X1 mult_64_U39 ( .A(mult_64_n97), .B(mult_64_n125), .CI(mult_64_n111), 
        .CO(mult_64_n61), .S(mult_64_n62) );
  FA_X1 mult_64_U38 ( .A(mult_64_n91), .B(mult_64_n118), .CI(mult_64_n71), 
        .CO(mult_64_n59), .S(mult_64_n60) );
  FA_X1 mult_64_U37 ( .A(mult_64_n69), .B(mult_64_n64), .CI(mult_64_n62), .CO(
        mult_64_n57), .S(mult_64_n58) );
  FA_X1 mult_64_U36 ( .A(mult_64_n60), .B(mult_64_n67), .CI(mult_64_n58), .CO(
        mult_64_n55), .S(mult_64_n56) );
  FA_X1 mult_64_U34 ( .A(mult_64_n103), .B(mult_64_n110), .CI(mult_64_n124), 
        .CO(mult_64_n51), .S(mult_64_n52) );
  FA_X1 mult_64_U33 ( .A(mult_64_n131), .B(mult_64_n117), .CI(mult_64_n90), 
        .CO(mult_64_n49), .S(mult_64_n50) );
  FA_X1 mult_64_U32 ( .A(mult_64_n63), .B(mult_64_n54), .CI(mult_64_n61), .CO(
        mult_64_n47), .S(mult_64_n48) );
  FA_X1 mult_64_U31 ( .A(mult_64_n52), .B(mult_64_n59), .CI(mult_64_n50), .CO(
        mult_64_n45), .S(mult_64_n46) );
  FA_X1 mult_64_U30 ( .A(mult_64_n48), .B(mult_64_n57), .CI(mult_64_n46), .CO(
        mult_64_n43), .S(mult_64_n44) );
  FA_X1 mult_64_U29 ( .A(mult_64_n102), .B(mult_64_n186), .CI(mult_64_n96), 
        .CO(mult_64_n41), .S(mult_64_n42) );
  FA_X1 mult_64_U28 ( .A(mult_64_n116), .B(mult_64_n109), .CI(mult_64_n123), 
        .CO(mult_64_n39), .S(mult_64_n40) );
  FA_X1 mult_64_U27 ( .A(mult_64_n51), .B(mult_64_n89), .CI(mult_64_n49), .CO(
        mult_64_n37), .S(mult_64_n38) );
  FA_X1 mult_64_U26 ( .A(mult_64_n40), .B(mult_64_n42), .CI(mult_64_n47), .CO(
        mult_64_n35), .S(mult_64_n36) );
  FA_X1 mult_64_U25 ( .A(mult_64_n38), .B(mult_64_n45), .CI(mult_64_n36), .CO(
        mult_64_n33), .S(mult_64_n34) );
  FA_X1 mult_64_U24 ( .A(mult_64_n95), .B(mult_64_n101), .CI(mult_64_n108), 
        .CO(mult_64_n31), .S(mult_64_n32) );
  FA_X1 mult_64_U23 ( .A(mult_64_n88), .B(mult_64_n115), .CI(mult_64_n41), 
        .CO(mult_64_n29), .S(mult_64_n30) );
  FA_X1 mult_64_U22 ( .A(mult_64_n32), .B(mult_64_n39), .CI(mult_64_n37), .CO(
        mult_64_n27), .S(mult_64_n28) );
  FA_X1 mult_64_U21 ( .A(mult_64_n35), .B(mult_64_n30), .CI(mult_64_n28), .CO(
        mult_64_n25), .S(mult_64_n26) );
  FA_X1 mult_64_U20 ( .A(mult_64_n94), .B(mult_64_n100), .CI(mult_64_n107), 
        .CO(mult_64_n23), .S(mult_64_n24) );
  FA_X1 mult_64_U19 ( .A(mult_64_n31), .B(mult_64_n87), .CI(mult_64_n24), .CO(
        mult_64_n21), .S(mult_64_n22) );
  FA_X1 mult_64_U18 ( .A(mult_64_n27), .B(mult_64_n29), .CI(mult_64_n22), .CO(
        mult_64_n19), .S(mult_64_n20) );
  FA_X1 mult_64_U17 ( .A(mult_64_n99), .B(mult_64_n93), .CI(mult_64_n86), .CO(
        mult_64_n17), .S(mult_64_n18) );
  FA_X1 mult_64_U16 ( .A(mult_64_n18), .B(mult_64_n23), .CI(mult_64_n21), .CO(
        mult_64_n15), .S(mult_64_n16) );
  FA_X1 mult_64_U8 ( .A(mult_64_n56), .B(mult_64_n65), .CI(mult_64_n8), .CO(
        mult_64_n7), .S(mula1[6]) );
  FA_X1 mult_64_U7 ( .A(mult_64_n44), .B(mult_64_n55), .CI(mult_64_n7), .CO(
        mult_64_n6), .S(mula1[7]) );
  FA_X1 mult_64_U6 ( .A(mult_64_n34), .B(mult_64_n43), .CI(mult_64_n6), .CO(
        mult_64_n5), .S(mula1[8]) );
  FA_X1 mult_64_U5 ( .A(mult_64_n26), .B(mult_64_n33), .CI(mult_64_n5), .CO(
        mult_64_n4), .S(mula1[9]) );
  FA_X1 mult_64_U4 ( .A(mult_64_n20), .B(mult_64_n25), .CI(mult_64_n4), .CO(
        mult_64_n3), .S(mula1[10]) );
  FA_X1 mult_64_U3 ( .A(mult_64_n19), .B(mult_64_n16), .CI(mult_64_n3), .CO(
        mult_64_n2), .S(mula1[11]) );
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
  NAND2_X1 mult_68_U197 ( .A1(b1[8]), .A2(u_del_vec[7]), .ZN(mult_68_n107) );
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
  NAND2_X1 mult_68_U189 ( .A1(b1[7]), .A2(u_del_vec[7]), .ZN(mult_68_n115) );
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
  NAND2_X1 mult_68_U182 ( .A1(b1[6]), .A2(u_del_vec[7]), .ZN(mult_68_n123) );
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
  NAND2_X1 mult_68_U175 ( .A1(b1[5]), .A2(u_del_vec[7]), .ZN(mult_68_n131) );
  NOR2_X1 mult_68_U174 ( .A1(mult_68_n181), .A2(mult_68_n196), .ZN(
        mult_68_n133) );
  NOR2_X1 mult_68_U173 ( .A1(mult_68_n182), .A2(mult_68_n196), .ZN(
        mult_68_n134) );
  NOR2_X1 mult_68_U172 ( .A1(mult_68_n185), .A2(mult_68_n196), .ZN(
        mult_68_n135) );
  NOR2_X1 mult_68_U171 ( .A1(mult_68_n187), .A2(mult_68_n196), .ZN(
        mult_68_n136) );
  NAND2_X1 mult_68_U170 ( .A1(u_del_vec[2]), .A2(b1[10]), .ZN(mult_68_n54) );
  NAND2_X1 mult_68_U169 ( .A1(b1[5]), .A2(u_del_vec[6]), .ZN(mult_68_n208) );
  NAND2_X1 mult_68_U168 ( .A1(u_del_vec[2]), .A2(b1[9]), .ZN(mult_68_n207) );
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
  NAND2_X1 mult_68_U159 ( .A1(u_del_vec[5]), .A2(b1[11]), .ZN(mult_68_n86) );
  NAND2_X1 mult_68_U158 ( .A1(u_del_vec[4]), .A2(b1[11]), .ZN(mult_68_n87) );
  NAND2_X1 mult_68_U157 ( .A1(u_del_vec[3]), .A2(b1[11]), .ZN(mult_68_n88) );
  NAND2_X1 mult_68_U156 ( .A1(u_del_vec[2]), .A2(b1[11]), .ZN(mult_68_n89) );
  NAND2_X1 mult_68_U155 ( .A1(u_del_vec[1]), .A2(b1[11]), .ZN(mult_68_n90) );
  NAND2_X1 mult_68_U154 ( .A1(u_del_vec[0]), .A2(b1[11]), .ZN(mult_68_n91) );
  NOR2_X1 mult_68_U153 ( .A1(mult_68_n191), .A2(mult_68_n179), .ZN(mult_68_n93) );
  NOR2_X1 mult_68_U152 ( .A1(mult_68_n191), .A2(mult_68_n181), .ZN(mult_68_n94) );
  NOR2_X1 mult_68_U151 ( .A1(mult_68_n191), .A2(mult_68_n182), .ZN(mult_68_n95) );
  NOR2_X1 mult_68_U150 ( .A1(mult_68_n191), .A2(mult_68_n185), .ZN(mult_68_n96) );
  NOR2_X1 mult_68_U149 ( .A1(mult_68_n191), .A2(mult_68_n189), .ZN(mult_68_n97) );
  NOR2_X1 mult_68_U148 ( .A1(mult_68_n191), .A2(mult_68_n190), .ZN(mult_68_n98) );
  NAND2_X1 mult_68_U147 ( .A1(b1[9]), .A2(u_del_vec[7]), .ZN(mult_68_n99) );
  XNOR2_X1 mult_68_U146 ( .A(mult_68_n2), .B(mult_68_n17), .ZN(mult_68_n201)
         );
  XOR2_X1 mult_68_U145 ( .A(mult_68_n201), .B(mult_68_n15), .Z(mult_68_n197)
         );
  NAND2_X1 mult_68_U144 ( .A1(u_del_vec[7]), .A2(b1[10]), .ZN(mult_68_n199) );
  AND2_X1 mult_68_U143 ( .A1(b1[11]), .A2(u_del_vec[6]), .ZN(mult_68_n200) );
  XOR2_X1 mult_68_U142 ( .A(mult_68_n199), .B(mult_68_n200), .Z(mult_68_n198)
         );
  XOR2_X1 mult_68_U141 ( .A(mult_68_n197), .B(mult_68_n198), .Z(mulb1[12]) );
  INV_X1 mult_68_U140 ( .A(u_del_vec[6]), .ZN(mult_68_n179) );
  INV_X1 mult_68_U139 ( .A(u_del_vec[3]), .ZN(mult_68_n185) );
  INV_X1 mult_68_U138 ( .A(u_del_vec[4]), .ZN(mult_68_n182) );
  INV_X1 mult_68_U137 ( .A(u_del_vec[5]), .ZN(mult_68_n181) );
  INV_X1 mult_68_U136 ( .A(b1[5]), .ZN(mult_68_n196) );
  INV_X1 mult_68_U135 ( .A(u_del_vec[2]), .ZN(mult_68_n187) );
  INV_X1 mult_68_U134 ( .A(u_del_vec[0]), .ZN(mult_68_n190) );
  INV_X1 mult_68_U133 ( .A(b1[9]), .ZN(mult_68_n192) );
  INV_X1 mult_68_U132 ( .A(b1[10]), .ZN(mult_68_n191) );
  INV_X1 mult_68_U131 ( .A(u_del_vec[1]), .ZN(mult_68_n189) );
  INV_X1 mult_68_U130 ( .A(b1[8]), .ZN(mult_68_n193) );
  INV_X1 mult_68_U129 ( .A(b1[7]), .ZN(mult_68_n194) );
  INV_X1 mult_68_U128 ( .A(b1[6]), .ZN(mult_68_n195) );
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
        mult_68_n7), .S(mulb1[6]) );
  FA_X1 mult_68_U7 ( .A(mult_68_n44), .B(mult_68_n55), .CI(mult_68_n7), .CO(
        mult_68_n6), .S(mulb1[7]) );
  FA_X1 mult_68_U6 ( .A(mult_68_n34), .B(mult_68_n43), .CI(mult_68_n6), .CO(
        mult_68_n5), .S(mulb1[8]) );
  FA_X1 mult_68_U5 ( .A(mult_68_n26), .B(mult_68_n33), .CI(mult_68_n5), .CO(
        mult_68_n4), .S(mulb1[9]) );
  FA_X1 mult_68_U4 ( .A(mult_68_n20), .B(mult_68_n25), .CI(mult_68_n4), .CO(
        mult_68_n3), .S(mulb1[10]) );
  FA_X1 mult_68_U3 ( .A(mult_68_n19), .B(mult_68_n16), .CI(mult_68_n3), .CO(
        mult_68_n2), .S(mulb1[11]) );
  NOR2_X1 mult_66_U203 ( .A1(mult_66_n179), .A2(mult_66_n192), .ZN(
        mult_66_n100) );
  NOR2_X1 mult_66_U202 ( .A1(mult_66_n192), .A2(mult_66_n181), .ZN(
        mult_66_n101) );
  NOR2_X1 mult_66_U201 ( .A1(mult_66_n192), .A2(mult_66_n182), .ZN(
        mult_66_n102) );
  NOR2_X1 mult_66_U200 ( .A1(mult_66_n192), .A2(mult_66_n185), .ZN(
        mult_66_n103) );
  NOR2_X1 mult_66_U199 ( .A1(mult_66_n192), .A2(mult_66_n189), .ZN(
        mult_66_n105) );
  NOR2_X1 mult_66_U198 ( .A1(mult_66_n192), .A2(mult_66_n190), .ZN(
        mult_66_n106) );
  NAND2_X1 mult_66_U197 ( .A1(b0[8]), .A2(u[7]), .ZN(mult_66_n107) );
  NOR2_X1 mult_66_U196 ( .A1(mult_66_n179), .A2(mult_66_n193), .ZN(
        mult_66_n108) );
  NOR2_X1 mult_66_U195 ( .A1(mult_66_n181), .A2(mult_66_n193), .ZN(
        mult_66_n109) );
  NOR2_X1 mult_66_U194 ( .A1(mult_66_n182), .A2(mult_66_n193), .ZN(
        mult_66_n110) );
  NOR2_X1 mult_66_U193 ( .A1(mult_66_n185), .A2(mult_66_n193), .ZN(
        mult_66_n111) );
  NOR2_X1 mult_66_U192 ( .A1(mult_66_n187), .A2(mult_66_n193), .ZN(
        mult_66_n112) );
  NOR2_X1 mult_66_U191 ( .A1(mult_66_n189), .A2(mult_66_n193), .ZN(
        mult_66_n113) );
  NOR2_X1 mult_66_U190 ( .A1(mult_66_n190), .A2(mult_66_n193), .ZN(
        mult_66_n114) );
  NAND2_X1 mult_66_U189 ( .A1(b0[7]), .A2(u[7]), .ZN(mult_66_n115) );
  NOR2_X1 mult_66_U188 ( .A1(mult_66_n179), .A2(mult_66_n194), .ZN(
        mult_66_n116) );
  NOR2_X1 mult_66_U187 ( .A1(mult_66_n181), .A2(mult_66_n194), .ZN(
        mult_66_n117) );
  NOR2_X1 mult_66_U186 ( .A1(mult_66_n182), .A2(mult_66_n194), .ZN(
        mult_66_n118) );
  NOR2_X1 mult_66_U185 ( .A1(mult_66_n185), .A2(mult_66_n194), .ZN(
        mult_66_n119) );
  NOR2_X1 mult_66_U184 ( .A1(mult_66_n187), .A2(mult_66_n194), .ZN(
        mult_66_n120) );
  NOR2_X1 mult_66_U183 ( .A1(mult_66_n189), .A2(mult_66_n194), .ZN(
        mult_66_n121) );
  NAND2_X1 mult_66_U182 ( .A1(b0[6]), .A2(u[7]), .ZN(mult_66_n123) );
  NOR2_X1 mult_66_U181 ( .A1(mult_66_n179), .A2(mult_66_n195), .ZN(
        mult_66_n124) );
  NOR2_X1 mult_66_U180 ( .A1(mult_66_n181), .A2(mult_66_n195), .ZN(
        mult_66_n125) );
  NOR2_X1 mult_66_U179 ( .A1(mult_66_n182), .A2(mult_66_n195), .ZN(
        mult_66_n126) );
  NOR2_X1 mult_66_U178 ( .A1(mult_66_n185), .A2(mult_66_n195), .ZN(
        mult_66_n127) );
  NOR2_X1 mult_66_U177 ( .A1(mult_66_n187), .A2(mult_66_n195), .ZN(
        mult_66_n128) );
  NOR2_X1 mult_66_U176 ( .A1(mult_66_n189), .A2(mult_66_n195), .ZN(
        mult_66_n129) );
  NAND2_X1 mult_66_U175 ( .A1(b0[5]), .A2(u[7]), .ZN(mult_66_n131) );
  NOR2_X1 mult_66_U174 ( .A1(mult_66_n181), .A2(mult_66_n196), .ZN(
        mult_66_n133) );
  NOR2_X1 mult_66_U173 ( .A1(mult_66_n182), .A2(mult_66_n196), .ZN(
        mult_66_n134) );
  NOR2_X1 mult_66_U172 ( .A1(mult_66_n185), .A2(mult_66_n196), .ZN(
        mult_66_n135) );
  NOR2_X1 mult_66_U171 ( .A1(mult_66_n187), .A2(mult_66_n196), .ZN(
        mult_66_n136) );
  NAND2_X1 mult_66_U170 ( .A1(u[2]), .A2(b0[10]), .ZN(mult_66_n54) );
  NAND2_X1 mult_66_U169 ( .A1(b0[5]), .A2(u[6]), .ZN(mult_66_n208) );
  NAND2_X1 mult_66_U168 ( .A1(u[2]), .A2(b0[9]), .ZN(mult_66_n207) );
  NAND2_X1 mult_66_U167 ( .A1(mult_66_n208), .A2(mult_66_n207), .ZN(
        mult_66_n63) );
  XNOR2_X1 mult_66_U166 ( .A(mult_66_n207), .B(mult_66_n208), .ZN(mult_66_n64)
         );
  NOR4_X1 mult_66_U165 ( .A1(mult_66_n195), .A2(mult_66_n196), .A3(
        mult_66_n189), .A4(mult_66_n190), .ZN(mult_66_n205) );
  NOR2_X1 mult_66_U164 ( .A1(mult_66_n194), .A2(mult_66_n190), .ZN(
        mult_66_n206) );
  AOI222_X1 mult_66_U163 ( .A1(mult_66_n84), .A2(mult_66_n205), .B1(
        mult_66_n206), .B2(mult_66_n84), .C1(mult_66_n206), .C2(mult_66_n205), 
        .ZN(mult_66_n204) );
  OAI222_X1 mult_66_U162 ( .A1(mult_66_n204), .A2(mult_66_n184), .B1(
        mult_66_n184), .B2(mult_66_n188), .C1(mult_66_n204), .C2(mult_66_n188), 
        .ZN(mult_66_n203) );
  AOI222_X1 mult_66_U161 ( .A1(mult_66_n203), .A2(mult_66_n74), .B1(
        mult_66_n203), .B2(mult_66_n76), .C1(mult_66_n76), .C2(mult_66_n74), 
        .ZN(mult_66_n202) );
  OAI222_X1 mult_66_U160 ( .A1(mult_66_n202), .A2(mult_66_n180), .B1(
        mult_66_n202), .B2(mult_66_n183), .C1(mult_66_n183), .C2(mult_66_n180), 
        .ZN(mult_66_n8) );
  NAND2_X1 mult_66_U159 ( .A1(u[5]), .A2(b0[11]), .ZN(mult_66_n86) );
  NAND2_X1 mult_66_U158 ( .A1(u[4]), .A2(b0[11]), .ZN(mult_66_n87) );
  NAND2_X1 mult_66_U157 ( .A1(u[3]), .A2(b0[11]), .ZN(mult_66_n88) );
  NAND2_X1 mult_66_U156 ( .A1(u[2]), .A2(b0[11]), .ZN(mult_66_n89) );
  NAND2_X1 mult_66_U155 ( .A1(u[1]), .A2(b0[11]), .ZN(mult_66_n90) );
  NAND2_X1 mult_66_U154 ( .A1(u[0]), .A2(b0[11]), .ZN(mult_66_n91) );
  NOR2_X1 mult_66_U153 ( .A1(mult_66_n191), .A2(mult_66_n179), .ZN(mult_66_n93) );
  NOR2_X1 mult_66_U152 ( .A1(mult_66_n191), .A2(mult_66_n181), .ZN(mult_66_n94) );
  NOR2_X1 mult_66_U151 ( .A1(mult_66_n191), .A2(mult_66_n182), .ZN(mult_66_n95) );
  NOR2_X1 mult_66_U150 ( .A1(mult_66_n191), .A2(mult_66_n185), .ZN(mult_66_n96) );
  NOR2_X1 mult_66_U149 ( .A1(mult_66_n191), .A2(mult_66_n189), .ZN(mult_66_n97) );
  NOR2_X1 mult_66_U148 ( .A1(mult_66_n191), .A2(mult_66_n190), .ZN(mult_66_n98) );
  NAND2_X1 mult_66_U147 ( .A1(b0[9]), .A2(u[7]), .ZN(mult_66_n99) );
  XNOR2_X1 mult_66_U146 ( .A(mult_66_n2), .B(mult_66_n17), .ZN(mult_66_n201)
         );
  XOR2_X1 mult_66_U145 ( .A(mult_66_n201), .B(mult_66_n15), .Z(mult_66_n197)
         );
  NAND2_X1 mult_66_U144 ( .A1(u[7]), .A2(b0[10]), .ZN(mult_66_n199) );
  AND2_X1 mult_66_U143 ( .A1(b0[11]), .A2(u[6]), .ZN(mult_66_n200) );
  XOR2_X1 mult_66_U142 ( .A(mult_66_n199), .B(mult_66_n200), .Z(mult_66_n198)
         );
  XOR2_X1 mult_66_U141 ( .A(mult_66_n197), .B(mult_66_n198), .Z(mulb0[12]) );
  INV_X1 mult_66_U140 ( .A(b0[5]), .ZN(mult_66_n196) );
  INV_X1 mult_66_U139 ( .A(b0[9]), .ZN(mult_66_n192) );
  INV_X1 mult_66_U138 ( .A(b0[10]), .ZN(mult_66_n191) );
  INV_X1 mult_66_U137 ( .A(b0[8]), .ZN(mult_66_n193) );
  INV_X1 mult_66_U136 ( .A(b0[7]), .ZN(mult_66_n194) );
  INV_X1 mult_66_U135 ( .A(b0[6]), .ZN(mult_66_n195) );
  INV_X1 mult_66_U134 ( .A(u[0]), .ZN(mult_66_n190) );
  INV_X1 mult_66_U133 ( .A(u[2]), .ZN(mult_66_n187) );
  INV_X1 mult_66_U132 ( .A(u[6]), .ZN(mult_66_n179) );
  INV_X1 mult_66_U131 ( .A(mult_66_n54), .ZN(mult_66_n186) );
  INV_X1 mult_66_U130 ( .A(u[1]), .ZN(mult_66_n189) );
  INV_X1 mult_66_U129 ( .A(u[3]), .ZN(mult_66_n185) );
  INV_X1 mult_66_U128 ( .A(u[4]), .ZN(mult_66_n182) );
  INV_X1 mult_66_U127 ( .A(u[5]), .ZN(mult_66_n181) );
  INV_X1 mult_66_U126 ( .A(mult_66_n73), .ZN(mult_66_n183) );
  INV_X1 mult_66_U125 ( .A(mult_66_n80), .ZN(mult_66_n184) );
  INV_X1 mult_66_U124 ( .A(mult_66_n82), .ZN(mult_66_n188) );
  INV_X1 mult_66_U123 ( .A(mult_66_n66), .ZN(mult_66_n180) );
  HA_X1 mult_66_U51 ( .A(mult_66_n129), .B(mult_66_n136), .CO(mult_66_n83), 
        .S(mult_66_n84) );
  HA_X1 mult_66_U50 ( .A(mult_66_n114), .B(mult_66_n121), .CO(mult_66_n81), 
        .S(mult_66_n82) );
  FA_X1 mult_66_U49 ( .A(mult_66_n128), .B(mult_66_n135), .CI(mult_66_n83), 
        .CO(mult_66_n79), .S(mult_66_n80) );
  HA_X1 mult_66_U48 ( .A(mult_66_n106), .B(mult_66_n113), .CO(mult_66_n77), 
        .S(mult_66_n78) );
  FA_X1 mult_66_U47 ( .A(mult_66_n120), .B(mult_66_n134), .CI(mult_66_n127), 
        .CO(mult_66_n75), .S(mult_66_n76) );
  FA_X1 mult_66_U46 ( .A(mult_66_n78), .B(mult_66_n81), .CI(mult_66_n79), .CO(
        mult_66_n73), .S(mult_66_n74) );
  HA_X1 mult_66_U45 ( .A(mult_66_n98), .B(mult_66_n105), .CO(mult_66_n71), .S(
        mult_66_n72) );
  FA_X1 mult_66_U44 ( .A(mult_66_n112), .B(mult_66_n133), .CI(mult_66_n119), 
        .CO(mult_66_n69), .S(mult_66_n70) );
  FA_X1 mult_66_U43 ( .A(mult_66_n77), .B(mult_66_n126), .CI(mult_66_n72), 
        .CO(mult_66_n67), .S(mult_66_n68) );
  FA_X1 mult_66_U42 ( .A(mult_66_n70), .B(mult_66_n75), .CI(mult_66_n68), .CO(
        mult_66_n65), .S(mult_66_n66) );
  FA_X1 mult_66_U39 ( .A(mult_66_n97), .B(mult_66_n125), .CI(mult_66_n111), 
        .CO(mult_66_n61), .S(mult_66_n62) );
  FA_X1 mult_66_U38 ( .A(mult_66_n91), .B(mult_66_n118), .CI(mult_66_n71), 
        .CO(mult_66_n59), .S(mult_66_n60) );
  FA_X1 mult_66_U37 ( .A(mult_66_n69), .B(mult_66_n64), .CI(mult_66_n62), .CO(
        mult_66_n57), .S(mult_66_n58) );
  FA_X1 mult_66_U36 ( .A(mult_66_n60), .B(mult_66_n67), .CI(mult_66_n58), .CO(
        mult_66_n55), .S(mult_66_n56) );
  FA_X1 mult_66_U34 ( .A(mult_66_n103), .B(mult_66_n110), .CI(mult_66_n124), 
        .CO(mult_66_n51), .S(mult_66_n52) );
  FA_X1 mult_66_U33 ( .A(mult_66_n131), .B(mult_66_n117), .CI(mult_66_n90), 
        .CO(mult_66_n49), .S(mult_66_n50) );
  FA_X1 mult_66_U32 ( .A(mult_66_n63), .B(mult_66_n54), .CI(mult_66_n61), .CO(
        mult_66_n47), .S(mult_66_n48) );
  FA_X1 mult_66_U31 ( .A(mult_66_n52), .B(mult_66_n59), .CI(mult_66_n50), .CO(
        mult_66_n45), .S(mult_66_n46) );
  FA_X1 mult_66_U30 ( .A(mult_66_n48), .B(mult_66_n57), .CI(mult_66_n46), .CO(
        mult_66_n43), .S(mult_66_n44) );
  FA_X1 mult_66_U29 ( .A(mult_66_n102), .B(mult_66_n186), .CI(mult_66_n96), 
        .CO(mult_66_n41), .S(mult_66_n42) );
  FA_X1 mult_66_U28 ( .A(mult_66_n116), .B(mult_66_n109), .CI(mult_66_n123), 
        .CO(mult_66_n39), .S(mult_66_n40) );
  FA_X1 mult_66_U27 ( .A(mult_66_n51), .B(mult_66_n89), .CI(mult_66_n49), .CO(
        mult_66_n37), .S(mult_66_n38) );
  FA_X1 mult_66_U26 ( .A(mult_66_n40), .B(mult_66_n42), .CI(mult_66_n47), .CO(
        mult_66_n35), .S(mult_66_n36) );
  FA_X1 mult_66_U25 ( .A(mult_66_n38), .B(mult_66_n45), .CI(mult_66_n36), .CO(
        mult_66_n33), .S(mult_66_n34) );
  FA_X1 mult_66_U24 ( .A(mult_66_n95), .B(mult_66_n101), .CI(mult_66_n108), 
        .CO(mult_66_n31), .S(mult_66_n32) );
  FA_X1 mult_66_U23 ( .A(mult_66_n88), .B(mult_66_n115), .CI(mult_66_n41), 
        .CO(mult_66_n29), .S(mult_66_n30) );
  FA_X1 mult_66_U22 ( .A(mult_66_n32), .B(mult_66_n39), .CI(mult_66_n37), .CO(
        mult_66_n27), .S(mult_66_n28) );
  FA_X1 mult_66_U21 ( .A(mult_66_n35), .B(mult_66_n30), .CI(mult_66_n28), .CO(
        mult_66_n25), .S(mult_66_n26) );
  FA_X1 mult_66_U20 ( .A(mult_66_n94), .B(mult_66_n100), .CI(mult_66_n107), 
        .CO(mult_66_n23), .S(mult_66_n24) );
  FA_X1 mult_66_U19 ( .A(mult_66_n31), .B(mult_66_n87), .CI(mult_66_n24), .CO(
        mult_66_n21), .S(mult_66_n22) );
  FA_X1 mult_66_U18 ( .A(mult_66_n27), .B(mult_66_n29), .CI(mult_66_n22), .CO(
        mult_66_n19), .S(mult_66_n20) );
  FA_X1 mult_66_U17 ( .A(mult_66_n99), .B(mult_66_n93), .CI(mult_66_n86), .CO(
        mult_66_n17), .S(mult_66_n18) );
  FA_X1 mult_66_U16 ( .A(mult_66_n18), .B(mult_66_n23), .CI(mult_66_n21), .CO(
        mult_66_n15), .S(mult_66_n16) );
  FA_X1 mult_66_U8 ( .A(mult_66_n56), .B(mult_66_n65), .CI(mult_66_n8), .CO(
        mult_66_n7), .S(mulb0[6]) );
  FA_X1 mult_66_U7 ( .A(mult_66_n44), .B(mult_66_n55), .CI(mult_66_n7), .CO(
        mult_66_n6), .S(mulb0[7]) );
  FA_X1 mult_66_U6 ( .A(mult_66_n34), .B(mult_66_n43), .CI(mult_66_n6), .CO(
        mult_66_n5), .S(mulb0[8]) );
  FA_X1 mult_66_U5 ( .A(mult_66_n26), .B(mult_66_n33), .CI(mult_66_n5), .CO(
        mult_66_n4), .S(mulb0[9]) );
  FA_X1 mult_66_U4 ( .A(mult_66_n20), .B(mult_66_n25), .CI(mult_66_n4), .CO(
        mult_66_n3), .S(mulb0[10]) );
  FA_X1 mult_66_U3 ( .A(mult_66_n19), .B(mult_66_n16), .CI(mult_66_n3), .CO(
        mult_66_n2), .S(mulb0[11]) );
endmodule

