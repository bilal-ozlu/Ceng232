`timescale 1ns / 1ps
module lab4_2(
			input[2:0] studentID,
			input[2:0] credit,
			input [1:0] mode,
			input  incTime,
			input CLK, 
			output reg [4:0]  stime,
			output reg  [2:0] idOutput,
			output reg endOfListWar,
			output reg  [3:0] studentCount,
			output reg  [6:0] totalCredits
			
	);
	
	reg [0:14]students[1:7];
	//students[0:2]=ID
	//students[3:8]=remaining credit
	//student[9]=output is ok
	//student[10:14]=spent credit in last hour
	always @(posedge CLK) 
	begin
	
	if (incTime == 1)
	begin
		if(stime < 24)
		begin
		stime = stime +1;
		end
		if(stime == 24)
		begin
		stime = 0;
		end
		if (students[1][0:2] == 3'b001)
		begin
		students[1][10:14] = 5'b00000;
		end
		if (students[2][0:2] == 3'b010)
		begin
		students[2][10:14] = 5'b00000;
		end
		if (students[3][0:2] == 3'b011)
		begin
		students[3][10:14] = 5'b00000;
		end
		if (students[4][0:2] == 3'b100)
		begin
		students[4][10:14] = 5'b00000;
		end
		if (students[5][0:2] == 3'b101)
		begin
		students[5][10:14] = 5'b00000;
		end
		if (students[6][0:2] == 3'b110)
		begin
		students[6][10:14] = 5'b00000;
		end
		if (students[7][0:2] == 3'b111)
		begin
		students[7][10:14] = 5'b00000;
		end
	end
	
	else if (mode==0)
	begin
		if (students[studentID[2]*4 + studentID[1]*2 + studentID[0]][0:2] != studentID && studentID[2]*4 + studentID[1]*2 + studentID[0] != 0)
		begin
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][0:2] = studentID;
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][3:8] = 6'b000000;
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][9] = 0;
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][10:14] = 5'b00000;
		studentCount = studentCount + 1;
		end
		idOutput = 0;
		endOfListWar = 0;
		students[1][9] = 0;
		students[2][9] = 0;
		students[3][9] = 0;
		students[4][9] = 0;
		students[5][9] = 0;
		students[6][9] = 0;
		students[7][9] = 0;
	end

	else if (mode==1)
	begin
		if (students[studentID[2]*4 + studentID[1]*2 + studentID[0]][0:2] == studentID && students[studentID[2]*4 + studentID[1]*2 + studentID[0]][8] + students[studentID[2]*4 + studentID[1]*2 + studentID[0]][7]*2 + students[studentID[2]*4 + studentID[1]*2 + studentID[0]][6]*4 + students[studentID[2]*4 + studentID[1]*2 + studentID[0]][5]*8 + students[studentID[2]*4 + studentID[1]*2 + studentID[0]][4]*16 + students[studentID[2]*4 + studentID[1]*2 + studentID[0]][3]*32 > credit[2]*4 + credit[1]*2 + credit[0])
		begin
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][3:8] = students[studentID[2]*4 + studentID[1]*2 + studentID[0]][3:8] - credit;
		totalCredits = totalCredits - credit;
		students[studentID[2]*4 + studentID[1]*2 + studentID[0]][10:14] = students[studentID[2]*4 + studentID[1]*2 + studentID[0]][10:14] + credit;
		end
		idOutput = 0;
		endOfListWar = 0;
		students[1][9] = 0;
		students[2][9] = 0;
		students[3][9] = 0;
		students[4][9] = 0;
		students[5][9] = 0;
		students[6][9] = 0;
		students[7][9] = 0;
	end

	else if (mode==2)
	begin
		if (students[1][0:2] == 3'b001 && students[1][14] + students[1][13]*2 + students[1][12]*4 + students[1][11]*8 + students[1][10]*16 < 5)
		begin
		students[1][3:8] = students[1][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[1][14] + students[1][13]*2 + students[1][12]*4 + students[1][11]*8 + students[1][10]*16 > 4)
		begin
		students[1][10:14] = 5'b00000;
		end
		if (students[2][0:2] == 3'b010 && students[2][14] + students[2][13]*2 + students[2][12]*4 + students[2][11]*8 + students[2][10]*16 < 5)
		begin
		students[2][3:8] = students[2][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[2][14] + students[2][13]*2 + students[2][12]*4 + students[2][11]*8 + students[2][10]*16 > 4)
		begin
		students[2][10:14] = 5'b00000;
		end
		if (students[3][0:2] == 3'b011 && students[3][14] + students[3][13]*2 + students[3][12]*4 + students[3][11]*8 + students[3][10]*16 < 5)	
		begin
		students[3][3:8] = students[3][3:8] +  credit;
		totalCredits = totalCredits + credit;
		end
		if(students[3][14] + students[3][13]*2 + students[3][12]*4 + students[3][11]*8 + students[3][10]*16 > 4)
		begin
		students[3][10:14] = 5'b00000;
		end
		if (students[4][0:2] == 3'b100 && students[4][14] + students[4][13]*2 + students[4][12]*4 + students[4][11]*8 + students[4][10]*16 < 5)	
		begin
		students[4][3:8] = students[4][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[4][14] + students[4][13]*2 + students[4][12]*4 + students[4][11]*8 + students[4][10]*16 > 4)
		begin
		students[4][10:14] = 5'b00000;
		end
		if (students[5][0:2] == 3'b101 && students[5][14] + students[5][13]*2 + students[5][12]*4 + students[5][11]*8 + students[5][10]*16 < 5)	
		begin
		students[5][3:8] = students[5][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[5][14] + students[5][13]*2 + students[5][12]*4 + students[5][11]*8 + students[5][10]*16 > 4)
		begin
		students[5][10:14] = 5'b00000;
		end
		if (students[6][0:2] == 3'b110 && students[6][14] + students[6][13]*2 + students[6][12]*4 + students[6][11]*8 + students[6][10]*16 < 5)	
		begin
		students[6][3:8] = students[6][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[6][14] + students[6][13]*2 + students[6][12]*4 + students[6][11]*8 + students[6][10]*16 > 4)
		begin
		students[6][10:14] = 5'b00000;
		end
		if (students[7][0:2] == 3'b111 && students[7][14] + students[7][13]*2 + students[7][12]*4 + students[7][11]*8 + students[7][10]*16 < 5)	
		begin
		students[7][3:8] = students[7][3:8] + credit;
		totalCredits = totalCredits + credit;
		end
		if(students[7][14] + students[7][13]*2 + students[7][12]*4 + students[7][11]*8 + students[7][10]*16 > 4)
		begin
		students[7][10:14] = 5'b00000;
		end
		idOutput = 0;
		endOfListWar = 0;
		students[1][9] = 0;
		students[2][9] = 0;
		students[3][9] = 0;
		students[4][9] = 0;
		students[5][9] = 0;
		students[6][9] = 0;
		students[7][9] = 0;
	end

	else if (mode==3)
	begin
		if (((students[1][8] + students[1][7]*2 + students[1][6]*4 + students[1][5]*8 + students[1][4]*16 + students[1][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[1][0:2] == 3'b001) && students[1][9] == 0)
		begin
		idOutput[2:0] = students[1][0:2];
		students[1][9] = 1;
		end
		else if (((students[2][8] + students[2][7]*2 + students[2][6]*4 + students[2][5]*8 + students[2][4]*16 + students[2][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[2][0:2] == 3'b010) && students[2][9] == 0)
		begin
		idOutput[2:0] = students[2][0:2];
		students[2][9] = 1;
		end
		else if (((students[3][8] + students[3][7]*2 + students[3][6]*4 + students[3][5]*8 + students[3][4]*16 + students[3][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[3][0:2] == 3'b011) && students[3][9] == 0)
		begin
		idOutput[2:0] = students[3][0:2];
		students[3][9] = 1;
		end
		else if (((students[4][8] + students[4][7]*2 + students[4][6]*4 + students[4][5]*8 + students[4][4]*16 + students[4][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[4][0:2] == 3'b100) && students[4][9] == 0)
		begin
		idOutput[2:0] = students[4][0:2];
		students[4][9] = 1;
		end
		else if (((students[5][8] + students[5][7]*2 + students[5][6]*4 + students[5][5]*8 + students[5][4]*16 + students[5][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[5][0:2] == 3'b101) && students[5][9] == 0)
		begin
		idOutput[2:0] = students[5][0:2];
		students[5][9] = 1;
		end
		else if (((students[6][8] + students[6][7]*2 + students[6][6]*4 + students[6][5]*8 + students[6][4]*16 + students[6][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[6][0:2] == 3'b110) && students[6][9] == 0)
		begin
		idOutput[2:0] = students[6][0:2];
		students[6][9] = 1;
		end
		else if (((students[7][8] + students[7][7]*2 + students[7][6]*4 + students[7][5]*8 + students[7][4]*16 + students[7][3]*32) < (credit[2]*4 + credit[1]*2 + credit[0])) && (students[7][0:2] == 3'b111) && students[7][9] == 0)
		begin
		idOutput[2:0] = students[7][0:2];
		students[7][9] = 1;
		end
		else
		begin
		idOutput = 0;
		endOfListWar = 1;
		end
	end
	end
endmodule
