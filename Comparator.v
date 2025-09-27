//Rawand Radi 
//1221054 
// section 1

module DFF(input D, clk, output Q);
     
	assign Q=D;

endmodule

 
module Six_Bit_Reg(A,CLK,Q);
	input [5:0] A;
	input CLK;
	output [5:0] Q;
	
	DFF dff1(A[0],CLK,Q[0]);
	DFF dff2(A[1],CLK,Q[1]);
	DFF dff3(A[2],CLK,Q[2]);
	DFF dff4(A[3],CLK,Q[3]);
	DFF dff5(A[4],CLK,Q[4]);
	DFF dff6(A[5],CLK,Q[5]);
	
endmodule



module Three_Bit_Reg(A,CLK,Q);
	input [2:0] A;
	input CLK;
	output [2:0] Q;
	
	DFF dff1(A[0],CLK,Q[0]);
	DFF dff2(A[1],CLK,Q[1]);
	DFF dff3(A[2],CLK,Q[2]);

	
endmodule


module SelectUsingAMux(A,B,sel,GT,LT,EQ);
	input [5:0] A,B; 
	input sel;
	output GT,LT,EQ;
	
	wire[2:0] Signed,Unsigned;
	wire[2:0] And1,And2;
	wire NotSel;
	
	N_Bit_Comp UnsignedM(A,B,Unsigned);
	signed_comp_signed_subtraction SignedM(A,B,Signed[0],Signed[2],Signed[1]);
	 not #(3) (NotSel,sel);
	 and #(6) (And1[0],Unsigned[0],NotSel);
	 and #(6) (And1[1],Unsigned[1],NotSel);
	 and #(6) (And1[2],Unsigned[2],NotSel);
	
	 and #(6) (And2[0],Signed[0],sel);
	 and #(6) (And2[1],Signed[1],sel);
	 and #(6) (And2[2],Signed[2],sel);
	
	 or #(6) (GT,And1[0],And2[0]);
	 or #(6) (EQ,And1[1],And2[1]);
	 or #(6) (LT,And1[2],And2[2]);
	

endmodule

module FA(X,Y,Cin,sum,Cout); 
	input X,Y,Cin;
	output sum,Cout;
	wire Xor1,And1,And2;
	 xor #(9) (Xor1,X,Y);
	 and #(6) (And1,X,Y);
	 xor #(9) (sum , Xor1,Cin);
	 and #(6) (And2,Cin,Xor1);
	 or  #(6) (Cout,And1,And2);
	
endmodule
	


module signed_comp_signed_subtraction(A,B,GT,LT,EQ);
	input[5:0] A,B;
	output GT,EQ,LT;
	
	wire[5:0] S;
	wire [6:0] Cout;
	wire GT_Wire;
	wire[5:0] INV_B;
	
	genvar i;
	
	generate
	for(i=0;i<6;i++)
		 not #(3) NOT(INV_B[i],B[i]);
		endgenerate
	
	
	FA FA1(A[0],INV_B[0],1'b1,S[0],Cout[0]);
	FA FA2(A[1],INV_B[1],Cout[0],S[1],Cout[1]);
	FA FA3(A[2],INV_B[2],Cout[1],S[2],Cout[2]);
	FA FA4(A[3],INV_B[3],Cout[2],S[3],Cout[3]);
	FA FA5(A[4],INV_B[4],Cout[3],S[4],Cout[4]);
	FA FA6(A[5],INV_B[5],Cout[4],S[5],Cout[5]);
	FA FA7(A[5],INV_B[5],Cout[5],LT,Cout[6]);
	
	
	 not #(3) (GT_Wire,LT);
	 nor #(3) (EQ,S[0],S[1],S[2],S[3],S[4],S[5]);
	 xor #(9) (GT,GT_Wire,EQ);
	

endmodule


module N_Bit_Comp(A,B,Answer);
	parameter n=6;
	input [n-1:0] A,B;
	output[2:0] Answer;
	wire [n-1:0] GTi,LTi,EQi;
	
	genvar i;
	
	generate 
	for(i=0;i<n;i++)begin 

	    One_Bit_Comp comp(A[i],B[i],GTi[i],LTi[i],EQi[i]); 
		end
		
	endgenerate
	
	EQ eq(EQi,Answer[1]);
	GT gt(GTi,EQi,Answer[0]);
	LT lt(LTi,EQi,Answer[2]);
	
	endmodule
	
	
module One_Bit_Comp(A,B,GTi,LTi,Ei); 
	input A,B;
	output GTi,LTi,Ei;
	
	wire And1,And2,Ei,Not_A,Not_B;	
	not #(3) (Not_A,A);
	not #(3) (Not_B,B);
	and #(6) notAnotB(And1,Not_A,Not_B);
    and #(6) AandB(And2,A,B);
	or 	#(6) E(Ei,And1,And2);
	and #(6) (GTi,A,Not_B);	
	and #(6) (LTi,Not_A,B);
	
	
endmodule


module LT(input [5:0] LT, E, output LT_New);
    wire [4:0] And1;
and #(6) And0(And1[4],E[5],LT[4]);  
and #(6) And(And1[3],E[5],E[4],LT[3]);
and #(6) And2(And1[2],E[5],E[4],E[3],LT[2]);
and #(6) And3(And1[1],E[5],E[4],E[3],E[2],LT[1]);
and #(6) And4(And1[0],E[5],E[4],E[3],E[2],E[1],LT[0]);

or #(6) OR(LT_New,And1[0],And1[1],And1[2],And1[3],And1[4],LT[5]);

	
endmodule


module GT(input [5:0] GT, E, output GT_New);
    wire [4:0] And1;
and #(6) And0(And1[4],E[5],GT[4]);  
and #(6) And(And1[3],E[5],E[4],GT[3]);
and #(6) And2(And1[2],E[5],E[4],E[3],GT[2]);
and #(6) And3(And1[1],E[5],E[4],E[3],E[2],GT[1]);
and #(6) And4(And1[0],E[5],E[4],E[3],E[2],E[1],GT[0]);

or #(6) OR(GT_New,And1[0],And1[1],And1[2],And1[3],And1[4],GT[5]);

endmodule

module EQ(E,E_New);
	input[5:0] E;
	output E_New;

	and #(6) a(E_New,E[0],E[1],E[2],E[3],E[4],E[5]);
	
	
endmodule

module comparator(A,B,Sel,CLK,GT,LT,EQ);
	input [5:0] A,B;
	input Sel,CLK;
	output GT,LT,EQ;
	wire[5:0] Sync_A,Sync_B; 
	wire Sync_Sel;
	wire GT_temp,LT_temp,EQ_temp;
	
	Six_Bit_Reg reg1(A,CLK,Sync_A);
	Six_Bit_Reg reg2(B,CLK,Sync_B);
	DFF reg3(Sel,CLK,Sync_Sel);
	SelectUsingAMux comp(Sync_A,Sync_B,Sync_Sel,GT_temp,LT_temp,EQ_temp);
	Three_Bit_Reg reg4({GT_temp,EQ_temp,LT_temp},CLK,{GT,EQ,LT});
	
endmodule

  
module comparator_tb;

    
    reg [5:0] A; 
    reg [5:0] B; 
    reg Sel;
    reg CLK;
    wire GT; 
    wire LT; 
    wire EQ; 

   
 comparator comp (.A(A),.B(B),.Sel(Sel),.CLK(CLK),.GT(GT),.LT(LT),.EQ(EQ));

  
 initial begin
     CLK = 0;
     forever #55 CLK = ~CLK;  
 end	   
	
 initial begin
     integer i,j,S;
	 integer pass;
	 pass=1;
	 	   for(S=0;S<2;S=S+1)begin
              for (i = 0; i < 64; i = i + 1) begin
		         for (j=0;j<64;j++)begin
                    @(posedge CLK)begin 
					   
				      if(i==0 && j==0);

			          else begin
					
			              if(Sel==0 && ((A == B && EQ==1) || (A > B && GT==1) || (A < B && LT==1)))begin
				               pass = 1;
			              end
			  
		                  else if(Sel==1 && ((A == B && EQ == 1) || ($signed(A) > $signed(B) && GT == 1) || ($signed(A) < $signed(B) && LT == 1))) begin 
			                pass = 1;
			              end
						  
		                  else begin 
			                pass=0;
			               $display("Test case failed! A = %0b, B = %0b, Sel = %b, GT = %b, LT = %b, EQ = %b", A, B, Sel, GT, LT, EQ);
                           $finish; 
		                   end  
				      end
					 
					A = i ; 
                    B = j;
                    Sel = S;
					
		          end
		  		end
            end
		end
	if (pass == 1)
       $display("All test cases passed successfully!");
	  
        $stop; 
   end	

endmodule