module full_adder_Nb #(
parameter N=2
)(
 input wire [N-1:0] a,
 input wire [N-1:0] b,
 input wire  cin,
 output wire [N-1:0] sum,
 output wire carry
);
wire [N:0] c;
assign c[0] =cin;

genvar i;
generate
	for(i=0; i<N;i=i+1) begin: full_adder_chain
	   full_adder fa(
		.a(a[i]),
		.b(b[i]),
		.c(c[i]),
		.sum(sum[i]),
		.carry(c[i+1])
);
end
endgenerate
assign carry =c[N];
endmodule

