module labM;
reg clk, INT;
reg [2:0] op;
reg [31:0] entryPoint;

wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb, PCin;
wire [25:0] jTarget;
wire zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, Mem2Reg, jump, branch, rtype, lw, sw;
wire [5:0] opCode;

integer i;

//Get pointer
yIF myIF(ins, PCp4, PCin, clk);

//Get instruction  
//{
//	RegDst: write to a location, 0-IJ, 1-R; 
//	RegWrite: 0-disable register, 1-will be able to store date in register
//}
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);

//Execute instruction
//{
//	ALUSrc:	0-not imm, 1-imm;
//	op:		do the calculation
//}
yEX myEX(z, zero, rd1, rd2, imm, op, ALUSrc);

//Data Memory
//{MemRead, MemWrite}
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);

//Write Back: from Memory to Register
//{Mem2Reg}
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

//Auto Control Module
yPC myPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);

assign opCode = ins[31:26];
yC1 myC1(rtype, lw, sw, jump, branch, opCode);
yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, jump, branch);

initial
begin
	entryPoint = 32'h80;
	INT = 1'b1;
	#1;
	repeat(43)
	begin
		//Fetch an instruction
		clk = 1'b1;

		//Set Control Signals
		#1;
		INT = 1'b0;

		op = 3'b010;
		if (ins[31:26] == 0)
		begin
			if (ins[5:0] == 6'h24) op = 3'b000;			//and
			else if (ins[5:0] == 6'h25) op = 3'b001;	//or
			else if (ins[5:0] == 6'h20) op = 3'b010;	//add
			else if (ins[5:0] == 6'h22) op = 3'b110;	//sub
			else if (ins[5:0] == 6'h2a) op = 3'b111;	//slt
		end

		//Execute this insturction
		clk = 1'b0;

		//View Results
		#1;
		$display("[0x%h-0x%h]rn1=%d rn2=%d rd1=%d rd2=%d imm=%h jTarget=%h z=%d zero=%h, wb=", PCin, ins, ins[25:21], ins[20:16], rd1, rd2, imm, jTarget, z, zero, wb);

	end

end
endmodule













