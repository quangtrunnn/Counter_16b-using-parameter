module counter # (
	parameter CNT_W=16
)(
	input clk,
	input rst_n,
	input count_en,
	input count_clr,
	output wire overflow,
	output reg [CNT_W-1:0] count
);
wire [CNT_W-1:0] MAX_VAL ={CNT_W{1'b1}};
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		count <={CNT_W{1'b0}};
		end
	       	else  begin
			if(count_clr ==1'b1) begin
				count <= {CNT_W{1'b0}};
			end
		       	else if(count_en ==1'b1) begin 
				count <= count +1;  
			end
		end 
	end
	assign overflow =(count== MAX_VAL);
		
endmodule
