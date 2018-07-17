`timescale 1ns / 1ps 
module lab3_2(
			input[4:0] ticketID,
			input CLK, 
			input gate,
			input mode,
			output reg [7:0] numOfFanInH,
			output reg [7:0] numOfFanInA,
			output reg gateWar
    );
	initial begin
		numOfFanInH=0;
		numOfFanInA=0;
		gateWar=0;
	end
   //Modify the lines below to implement your design
	always @(posedge CLK) 
	begin
	
	if(((ticketID[0]+ticketID[1]+ticketID[2]+ticketID[3]+ticketID[4])<3) && (gate == 0) && (mode == 1))
	begin gateWar = 1; end 
	
	else if(((ticketID[0]+ticketID[1]+ticketID[2]+ticketID[3]+ticketID[4])>2) && (gate == 1) && (mode == 1))
	begin gateWar = 1; end
	
	else if(((ticketID[0]+ticketID[1]+ticketID[2]+ticketID[3]+ticketID[4])<3) && (gate == 1))
	begin
		if(mode == 1 && numOfFanInA < 4'hF)
		begin numOfFanInA = numOfFanInA + 1; end
		else if(mode == 0 && numOfFanInA > 1'h0)
		begin numOfFanInA = numOfFanInA - 1; end
		gateWar = 0; 
	end
	
	else if(((ticketID[0]+ticketID[1]+ticketID[2]+ticketID[3]+ticketID[4])>2) && (gate == 0))
	begin
		if(mode ==1 && numOfFanInH < 4'hF)
		begin numOfFanInH = numOfFanInH + 1; end
		else if(mode == 0 && numOfFanInH > 1'h0)
		begin numOfFanInH = numOfFanInH - 1; end
		gateWar = 0;
	end
	
	else
		begin
		if(gate == 1) begin
			if(mode ==1 && numOfFanInA < 4'hF)
			begin numOfFanInA = numOfFanInA + 1; end
			else if(mode == 0 && numOfFanInA > 1'h0)
			begin numOfFanInA = numOfFanInA - 1; end 
			gateWar = 0;
			end	
		else if(gate == 0)begin
			if(mode ==1 && numOfFanInH < 4'hF)
			begin numOfFanInH = numOfFanInH + 1; end
			else if(mode == 0 && numOfFanInH > 1'h0)
			begin numOfFanInH = numOfFanInH - 1; end
			gateWar = 0;
		end
	end
	end
	
endmodule

