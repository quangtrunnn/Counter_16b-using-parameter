module half_adder (
	input wire a_in,
	input wire b_in,
	output wire sum_out,
	output wire carry_out
);

assign sum_out=a_in^b_in;
assign carry_out=a_in&b_in;
endmodule
