`timescale 1ns / 1ps

module testbench_ac;

	// Inputs
	reg a;
	reg c;
	reg clk;

	// Outputs
	wire q;

	// Instantiate the Unit Under Test (UUT)
	ac uut (
		.a(a), 
		.c(c), 
		.clk(clk), 
		.q(q)
	);
    
    // At 5, 15, 25, .. clk will change 1->0 
    // At 10, 20, 30, .. clk will change 0->1
    initial clk = 1;
	always #5 clk = ~clk;

	initial begin
        // set monitor to inputs and outputs
		$monitor("Time=%t | a=%b c=%b | q=%b", $time, a, c, q);
        
		// Initialize Inputs
		a = 0;
		c = 0;

		// Wait 5 ns for global reset to finish
		#5;
        
		// Add stimulus here
        
        a = 1; c = 1;
		#10; // Wait for clock edge
		if (q != 1) $display("Value of q after a=1 c=1 is wrong");
		else $display("Successful");
		a = 0; c = 1;
		#10; // Wait for clock
		if (q != 0) $display("Value of q after a=1 c=0 is wrong");
      else $display("Successful");  
        a = 1; c = 0;
		#10; // Wait for clock edge
		if (q != 0) $display("Value of q after a=0 c=0 is wrong");
		else $display("Successful");
		a = 1; c = 0;
		#40; // Wait for 4 clocks. q will toggle 4 times.
		
		a = 1; c= 1;
		#40; // Wait for 4 clocks. q will not change.
		
		 a= 0; c = 0;
		#10; // Wait for clock
		if (q != 1) $display("Value of q after a=0 c=0 is wrong");
		else $display("Successful");
		$finish;
        
	end
      
endmodule

