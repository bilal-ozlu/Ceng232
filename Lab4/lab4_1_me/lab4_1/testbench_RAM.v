`timescale 1ns / 1ps
module testbench_RAM(
    );
	reg CLK;
	reg  [1:9] rInput;
	reg Mode;
	reg [3:0] rAddress;
	wire [1:9] rOutput;
	integer i;
	integer result=0;
	integer err=0;  
	//instances
	RAM ins( rInput , CLK , Mode , rAddress , rOutput );	
	
	//Set initial values
	initial CLK = 0;	
	always #5 CLK = ~CLK;
  
	initial begin
	$display("Starting Testbench");
		//read initial values
		Mode=1'b0;			
		for(i=0;i<=15;i=i+1)
		begin
			rAddress = i;
			#10
			if (rOutput!==9'b111111111) 
			begin
				$display("time:",$time,":Error in initial value, address %b value %b should be 7'b111111111",rAddress,rOutput);
				err=1;
			end			
		end 
		if (err==0) result=result+5;

		$display("Result is:%d",result);
		$finish;
	end
		
endmodule
