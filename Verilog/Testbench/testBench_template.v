module Template_Instantiation_Module(clock,reset,A,B,Q); //Template INSTANTIATION MODULE
	input clock, reset;
	input [15:0] A;
	input B;
	output [15:0] Q;

  Template_PC_implementation_Module pc ((reset ? 16'b0 : A), (reset | B), 1, clock, Q); 
endmodule

module Template_PC_implementation_Module (R, L, incr_pc, Clock, Q); //Template IMPLEMENTATION MODULE
input [15:0] R;
input L, incr_pc, Clock;
output reg [15:0] Q;

initial
begin
  Q <= 16'b0;
end

always @(posedge Clock)
if (L)
	Q <= R;
else
	if (incr_pc)
		Q <= Q + 1'b1;
endmodule

module Template_TestBench; //Template TESTBENCH for the instatiation module
	reg clock, reset;
	reg [15:0] A;
	reg B;
	wire [15:0] Q;
	
   parameter timeDelay = 100; //Delay time(ps) parameter
   
	 MODULE MODULE_OBJECT(A, reset, B, clock, Q);
	 
	initial begin
		clock = 0; reset = 0; B = 0; A = 0;  //Setting variables initial values
		forever begin
		    #50 clock = ~clock; //Defining clock pulse delay time
		end 
	end 
	initial begin
		#(timeDelay) reset = 1;  //Value changing example routine
		#(timeDelay) reset = 0;
		#(timeDelay) B = 1; A = 16'b0;
		#50 B = 0;
	end 

endmodule // testBench_template


