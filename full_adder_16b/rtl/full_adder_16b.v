module full_adder_Nb #(
 parameter N=16
)(
 	input wire [N-1:0] a,
 	input wire [N-1:0] b,
 	output wire [N-1:0] sum,
 	output wire carry,
 	input wire cin
);
wire [N:0] c;
assign c[0]=cin;
genvar i;
generate
	for(i=0; i<N; i=i+1) begin : adder_loop
		full_adder fa (
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







