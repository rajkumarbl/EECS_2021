
   module fulladder(S, Cout, A, B, cin);
   output S, Cout;
   input A, B, cin;
   assign S = (A^B)^cin; // sum bit
   assign Cout = (A & B) | (B & cin) | (cin & A); //carry bit
   

endmodule
    
    
module adder4(S, Cout, A, B, cin);
//input output port declarations
   output [3:0] S;
   output Cout;
   input [3:0] A, B;
   input cin;
   wire c1, c2, c3;
// Instantiate four 1-bit full adders
   fulladder f0 (S[0], c1, A[0], B[0], cin);
   fulladder f1 (S[1], c2, A[1], B[1], c1);
   fulladder f2 (S[2], c3, A[2], B[2], c2);
   fulladder f3 (S[3], Cout, A[3], B[3], c3);
endmodule

module t_adder;

reg cin; // input
reg[3:0] A, B;

wire Cout; //output
wire[3:0] S;

wire c1, c2, c3;
adder4 myadder(S,Cout,A,B,cin);
initial 
	begin 
		cin = 0;
		A = 0;
		B = 0;
		repeat(7)
		begin
			#5 $display("%5d: A=%b B=%b S=%b Cout=%b", $time, A, B, S, Cout);
			A = A+1;
			B = B+2;	 
			end
 end 
 endmodule
