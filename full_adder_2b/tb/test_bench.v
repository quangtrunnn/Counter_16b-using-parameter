module test_bench;
  
  	reg [1:0]  a,b;
  	wire [1:0] sum;
  	reg [2:0] res;
	wire carry;
	
    	integer i;

  	full_adder_Nb #(.N(2)) dut(
		.a(a), 
		.b(b), 
		.cin(1'b0),	
		.sum(sum), 
		.carry(carry)
	);

  	initial begin
  		for( i = 0; i < 50; i=i+1 ) begin
  	  			a = $urandom_range(0,3);
  	  			b = $urandom_range(0,3);
				
			
			res = a+b;
  	  		#5;
  	  		$display("====================================");	
  	  		$display("==== Case:%d a = %d, b = %d, cin= 0 =======",i,a,b);
  	  		$display("====================================");	
  	  		$display("Expected sum= %b, carry = %b", res[1:0], res[2]);
			$display("Actual  sum=%b, carry =%b",sum, carry);
  	  		
  	  		if((sum=== res[1:0]) && (carry === res[2])) begin 
  	  			$display(">>>>>>>>>>>  PASS <<<<<<<<<<<<<\n");
  	  		end else begin
  	  			$display(">>>>>>>>>>>  FAIL <<<<<<<<<<<<<\n");
  	  			$finish;
  	  		end
  	  end
  	  	$finish;
end
  	
  	

  //initial
  //begin
  //  //$monitor("%t: a = %d, b = %d, c = %0b. Expected value = %d, Actual Value = %d",$time,a,b,cin,exp,res);
  //  //$monitor("%t: a = %d, b = %d. Expected value = %d, Actual Value = %d",$time,a,b,exp,res);
  //end

  //always @* begin
  //  res = sum + (carry << 2);
  //  exp = a + b;
  //end

endmodule
