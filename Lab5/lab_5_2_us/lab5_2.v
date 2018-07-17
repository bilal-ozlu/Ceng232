`timescale 1ns / 1ps

module VBEncoder(input CLK,
			input [7:0] INT4,input [7:0] INT3, input [7:0] INT2, input [7:0] INT1,
            input START,
            output reg READY, 
			output reg [7:0] STREAM);

//Write your code below
reg [31:0] G;
integer x=0, y=0, z3=0, z4=0, z5=0;

always @(posedge CLK) begin
		if(x==0 && y==0 && START==0) begin
		STREAM[7:0] = 8'b00000000;
		READY = 1;		
		end
		
		else if(x==0 && START==1) begin
		G[31:24]=INT4[7:0];
		G[23:16]=INT3[7:0];
		G[15:8]=INT2[7:0];
		G[7:0]=INT1[7:0];
		READY = 0;
		y=1;
		end
		
		else if(G>=128*128*128*128 && READY==0) begin
			STREAM[3:0] = INT4[7:4];
			STREAM[7:4] = 4'b0000;
			G = G - STREAM[3:0]*128*128*128*128;
			x=1;
			z5=1;
		end
		
		else if(G<128*128*128*128 && G>=128*128*128 && READY==0 || z5==1 && INT3[7:5]==3'b000 && INT4[3:0]==4'b0000 && READY==0) begin
			STREAM[2:0] = INT3[7:5];
			STREAM[6:3] = INT4[3:0];
			STREAM[7] = 0;
			G = G - STREAM[6:0]*128*128*128;
			x=1;
			z5=0;
			z4=1;	
		end
		
		else if(G<128*128*128 && G>=128*128 && READY==0 || z4==1 && INT2[7:6]==2'b00 && INT3[4:0]==5'b00000 && READY==0) begin
			STREAM[1:0] = INT2[7:6];
			STREAM[6:2] = INT3[4:0];
			STREAM[7] = 0;
			G = G - STREAM[6:0]*128*128;
			x=1;
			z4=0;
			z3=1;
		end
		
		else if(G<128*128 && G>=128 && READY==0 || z3==1 && INT1[7]==0 && INT2[5:0]==6'b000000 && READY==0) begin
			STREAM[0] = INT1[7];
			STREAM[6:1] = INT2[5:0];
			STREAM[7] = 0;
			G = G - STREAM[6:0]*128;
			x=1;
			z3=0;	
		end
		
		else if(G<128 && READY==0) begin
			STREAM[6:0] = INT1[6:0];
			STREAM[7] = 1;
			x=0;
			y=0;
		end		 
	end			
endmodule
