module yAlu32(z, ex, a, b, op);
output[3:0] z;
output ex;
input[3:0] a, b;
input[2:0] op;

wire[3:0] result0, result1, result23, f1, f2, slt, minus;
wire[15:0] z16;
wire[7:0] z8;
wire[3:0] z4;
wire[1:0] z2;
wire lor;
wire adderCOut;
wire ctrlArith;
wire condition;
wire resultSlt;

/*
0	000	a&b
1	001	a|b
2	010	a+b
3	110	a-b
4	111	slt (set a less than b)
*/

//a&b
and op1[3:0](result0, a, b);

//a|b
or	op[3:0](result1, a, b);

//a +- b
yArith op23[3:0](result23, adderCOuer, a, b, ctrlArith);

//slt
xor op4a(condition, a[3], b[3]);
yArith op4b(minus, null, a, b, 1'b1);
yMux #(.SIZE(1)) op4i(resultSlt, minus[3], a[3], condition);

//ALU
yMux #(.SIZE(4)) fi1(f1, result0, result1, op[0]);
yMux #(.SIZE(4)) fi2(f2, f1, result23, op[1]);
yMux #(.SIZE(4)) fi3(z, f2, slt, op[0]);

//Exception
//or or16[15:0] (z16, z[15:0], z[31:16]);
//or or8[7:0] (z8, z16[7:0], z16[15:8]);
//or or4[3:0] (z4, z8[3:0], z8[7:4]);
//or or2[1:0] (z2, z4[1:0], z4[3:2]);
//or lor (lor, z2[0], z2[1]);
//not (ex, lor);

//Connections
assign ctrlArith = op[2];
assign slt[3:1] = 0;
assign slt[0] = resultSlt;

endmodule


module yArith(z, cout, a, b, ctrl); 

//add if ctrl=0, subtract if ctrl=1
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input ctrl; 
wire[3:0] notB, tmp; 
wire cin; 

assign cin = ctrl;
not myNot[3:0](notB, b);
yMux #(4) mymux(tmp, b, notB, cin);
yAdder myadder(z,cout, a ,tmp , cin);

endmodule 

module yMux(z, a, b, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a, b;
input c;
yMux1 mine[SIZE-1:0](z, a, b, c);
endmodule 

module yAdder(z, cout, a, b, cin); 
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input cin; 
wire[3:0] in, out; 
yAdder1 mine[3:0](z, out, a, b, in); 
assign in[0] = cin; 
assign in[3:1] = out[2:0];
assign cout = out[3];
endmodule

module yMux1(z, a, b, c);
output z;
input a, b, c;
wire notC, upper, lower;
not my_not(notC, c);
and upperAnd(upper, a, notC);
and lowerAnd(lower, c, b);
or my_or(z, upper, lower);
endmodule 

module yAdder1(z, cout, a, b, cin); 
output z, cout; 
input a, b, cin; 
xor left_xor(tmp, a, b); 
xor right_xor(z, cin, tmp); 
and left_and(outL, a, b); 
and right_and(outR, tmp, cin); 
or my_or(cout, outR, outL); 
endmodule 

module ltester;

reg signed [3:0] a, b; 
reg signed [3:0] expect; 
reg [2:0] op; 
wire ex; 
wire signed [3:0] z; 
reg  flag; 

yAlu32 mine(z, ex, a, b, op); 

initial 
begin 
  repeat  (10)  
  begin  
   a  =  $random%100;  
	b  =  $random%100;
	//flag = $value$plusargs("op=%d", op);
	op =  $random%3;	 
	// The oracle: compute "expect" based on "op" 
    	if(op === 3'b000)
		expect = a+b;
	if(op === 3'b001)
		expect = a&b;
	if(op === 3'b010)
		expect = a|b;
	if(op === 3'b110)
		expect = a-b;
	
	#1;  
	// Compare the circuit's output with "expect" 
	// and set "ok" accordingly 	
	// Display ok and the various signals 


	//if(expect === z)
    		$display("RESULT: a=%b b=%b z=%b op=%b", a,b,z,op);
	//else 
		//$display("FAIL\n A ==> %0d\n B ==> %0d\n OPC ==> %0b\n Expect ==> %0d\n Result ==> %0d\n",a,b,op,expect,z);
end
end 
endmodule 





