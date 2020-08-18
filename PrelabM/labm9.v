module labM;
reg [31:0] PCin;
reg RegDst, RegWrite, clk, ALUSrc, MemRead, MemWrite, Mem2Reg ;
reg [2:0] op;
wire [31:0] wd,wb, rd1, rd2, imm, ins, PCp4, z, memOut;
wire [25:0] jTarget;
wire zero;

yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

initial

begin
	//------------------------------------Entry point
	PCin = 128;
	//------------------------------------Run program
	repeat (11)
		begin
		//---------------------------------Fetch an ins
		clk = 1; #1;
		//---------------------------------Set control signals
		RegDst = 0; RegWrite = 0; ALUSrc = 1; op = 3'b010;
		// Add statements to adjust the above defaults
		if (ins[31:26] === 0) //add only. other R-type is not configured in this program
			begin
			
			RegDst = 1; RegWrite = 1; ALUSrc = 0;op = 3'b010;
			Mem2Reg = 0; MemRead = 1; MemWrite = 0;
		end
		else if(ins [31:26] === 35)//lw
		begin
			RegDst = 0; RegWrite = 1; ALUSrc = 1; op = 3'b010;	
			Mem2Reg = 1; MemRead = 1; MemWrite = 1;	
		end
		else if(ins[31:26] ===4) //beq
		begin
			RegWrite = 0; ALUSrc = 0; op = 3'b110;
			Mem2Reg = 0; MemRead = 0; MemWrite = 0;
		end
		else 
		begin
			RegWrite = 0; ALUSrc = 1; op = 3'b010;
			MemRead = 0; MemWrite = 0;
		end
		
		//---------------------------------Execute the ins
		clk = 0; #1;
		//---------------------------------View results


if (ins[31:0] === 'hac100020 )
begin 
end
 else if(ins[5:0] === 32)
		$display("add instruction: rd1=%h rd2=%h z=%h ",ins, rd1, rd2, z);

 if(ins[5:0] === 37)
		$display("or instruction: rd1=%h rd2=%h z=%h",ins, rd1, rd2, z);

 if(ins[31:26] === 2)

		$display("J instruction:",jTarget );
		//---------------------------------Prepare for the next ins
		PCin = PCp4;
	end
	$finish;
end
endmodule
