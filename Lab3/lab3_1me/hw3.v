`timescale 1ns / 1ps

module ac(
    input a,
    input c,
    input clk,
    output reg q
    );
    
    initial begin
        q = 0;
    end

	always@(posedge clk)
	
	begin 
		if(a==c) q=1;
		else if((a==1) && (c==0)) q=q;
		else if((a==0) && (c==1)) q=~q;
	end

endmodule

module ic3031(
    input a0, 
    input c0, 
    input a1, 
    input c1, 
    input clk, 
    output reg q0, 
    output reg q1, 
    output y
    );
    
    initial begin
        q0 = 0;
    end

	always@(posedge clk)
	
	begin 
		if(a0==c0) q0=1;
		else if((a0==1) && (c0==0)) q0=q0;
		else if((a0==0) && (c0==1)) q0=~q0;
	end
    initial begin
        q1 = 0;
    end

	always@(posedge clk)

	begin 
		if(a1==c1) q1=1;
		else if((a1==1) && (c1==0)) q1=q1;
		else if((a1==0) && (c1==1)) q1=~q1;
	end
	
	assign y=(q0==q1);

endmodule
