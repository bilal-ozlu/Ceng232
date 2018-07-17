`timescale 1ns / 1ps


module add_checksum(
	input [1:9] acInput,
	output reg [1:12] acOutput
    );
	 
//Write your code below

endmodule


module detect_error(
	input [1:12] decInput,
	output reg [1:9] decOutput
    );


//Write your code below

endmodule


module RAM(
	input [8:0] rInput, 
	input CLK,
	input Mode, //0:read, 1:write
	input [3:0] rAddress,
	output reg [8:0] rOutput);

//Write your code below


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