`timescale 1ns / 1ps


module add_checksum(
	input [1:9] acInput,
	output reg [1:12] acOutput
    );
	 
//Write your code below
	always@* 
	begin
	acOutput[1:9] = acInput[1:9];

	acOutput[10] = ((acInput[1]*1 + acInput[2]*2 + acInput[3]*3 + acInput[4]*4 + acInput[5]*5 + acInput[6]*6 + acInput[7]*7 + acInput[9]*9) % 8) / 4;

	acOutput[11] = ((acInput[1]*1 + acInput[2]*2 + acInput[3]*3 + acInput[5]*5 + acInput[6]*6 + acInput[7]*7 + acInput[9]*9) % 4) / 2;

	acOutput[12] = (acInput[1]*1 + acInput[3]*3 + acInput[5]*5 + acInput[7]*7 + acInput[9]*9) % 2;
	end
endmodule


module detect_error(
	input [1:12] decInput,
	output reg [1:9] decOutput
    );

//Write your code below
	always @* begin
	if((decInput[12] == (decInput[1]*1 + decInput[3]*3 + decInput[5]*5 + decInput[7]*7 + decInput[9]*9) % 2) && (decInput[11] == ((decInput[1]*1 + decInput[2]*2 + decInput[3]*3 + decInput[5]*5 + decInput[6]*6 + decInput[7]*7 + decInput[9]*9) % 4) / 2) && (decInput[10] == ((decInput[1]*1 + decInput[2]*2 + decInput[3]*3 + decInput[4]*4 + decInput[5]*5 + decInput[6]*6 + decInput[7]*7 + decInput[9]*9) % 8) / 4))
	begin decOutput[1:9] = decInput[1:9]; end
	else
	begin decOutput[1:9] = 9'b000000000; end
	end
endmodule


module RAM(
	input [8:0] rInput, 
	input CLK,
	input Mode, //0:read, 1:write
	input [3:0] rAddress,
	output reg [8:0] rOutput);

//Write your code below
	reg[8:0]Bnem[0:15];
	always @(posedge CLK) 
	begin
	Bnem[0][8:0] = 9'b111111111;
	Bnem[1][8:0] = 9'b111111111;
	Bnem[2][8:0] = 9'b111111111;
	Bnem[3][8:0] = 9'b111111111;
	Bnem[4][8:0] = 9'b111111111;
	Bnem[5][8:0] = 9'b111111111;
	Bnem[6][8:0] = 9'b111111111;
	Bnem[7][8:0] = 9'b111111111;
	Bnem[8][8:0] = 9'b111111111;
	Bnem[9][8:0] = 9'b111111111;
	Bnem[10][8:0] = 9'b111111111;
	Bnem[11][8:0] = 9'b111111111;
	Bnem[12][8:0] = 9'b111111111;
	Bnem[13][8:0] = 9'b111111111;
	Bnem[14][8:0] = 9'b111111111;
	Bnem[15][8:0] = 9'b111111111;
	if(Mode==1)
	begin
	Bnem[rAddress[3]*8 + rAddress[2]*4 + rAddress[1]*2 + rAddress[0]*1][8:0] = rInput[8:0];
	end
	else if(Mode==0)
	begin
	rOutput[8:0] = Bnem[rAddress[3]*8 + rAddress[2]*4 + rAddress[1]*2 + rAddress[0]*1][8:0];
	end
	end
endmodule	

module ISBN_RAM(
	input [11:0] isbnInput,
	input CLK,
	input Mode, //0:read, 1:write
	input [3:0] isbnAddress,
	output  [11:0] isbnOutput);

wire [1:9] detect_errorToRam;  
wire [1:9] ramToadd_checksum; 

//DO NOT EDIT THIS MODULE
detect_error DC (isbnInput,detect_errorToRam);
RAM RM(detect_errorToRam,CLK,Mode,isbnAddress,ramToadd_checksum);
add_checksum EN (ramToadd_checksum,isbnOutput);
//DO NOT EDIT THIS MODULE
endmodule
