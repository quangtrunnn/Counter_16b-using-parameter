
`timescale 1ns/1ns

module test_bench;
    reg clk,rst_n;
    reg count_en, count_clr;
    wire [15:0] count;
    wire overflow;

    //-----------------------//
    //Write your code here
    //-----------------------//
    //1.instatiate the dut
	counter #(.CNT_W(16)) uut (
		.clk(clk),
		.rst_n(rst_n),
		.count_en(count_en),
		.count_clr(count_clr),
		.overflow(overflow),
		.count(count)
);
    //2.override the CNT_W = 16

    initial begin 
  	  clk = 0;
  	  forever #25 clk = ~clk;
  	end

  	initial begin
  	    rst_n = 1'b0;
 	    count_en=0;
	    count_clr=0;
	    #50;
	    rst_n =1'b1;
   	end
	
	initial begin
	@(posedge rst_n);
        @(posedge clk)
        #1;
        if( count !== 16'h0 ) begin
			    $display("------------------------------------------------");
			    $display("t=%10d FAIL: the init value of counter is not 16'h0",$time);
			    $display("------------------------------------------------");
                #100;
                $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: the init value of counter is 16'h0.", $stime);
			$display("------------------------------------------------");

		end
        
        #10;

       

        count_en=1;
		
        repeat (16'hffff) begin
			@(posedge clk);
		end
        #1;
		if( count !== 16'hffff ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not correct, count = %2h , expect: 16'hffff",$stime,count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is correct,16'hffff",$stime);
			$display("------------------------------------------------");
		end
		
        if( overflow !== 1'b1) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: overflow is not asserted",$stime);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: overflow is asserted",$stime);
			$display("------------------------------------------------");
		end
		@(posedge clk);
        #1;
		if( overflow == 1'b1) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: overflow is not negated",$stime);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: overflow is negated",$stime);
			$display("------------------------------------------------");
		end
		if( count !== 16'h0 ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not init to 16'h0 after overflow. count = %2h , expect: 16'h0",$stime, count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is 16'h0 after overflow",$stime);
			$display("------------------------------------------------");
		end

		repeat (10) begin
			@(posedge clk);
		end
        #1;
		if( count !== 16'ha ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not correct, count = %2h , expect: 16'ha",$stime,count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is correct - 16'ha",$stime);
			$display("------------------------------------------------");
		end
        

		count_clr =1'b1;
		@(posedge clk); #1;
		count_clr =0;

		if(count !== 16'h0000) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter not cleared by count_clr, got = %2h",$stime,count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter cleared to 0 by count_clr ",$stime);
			$display("------------------------------------------------");
		end

		count_en=0;
		repeat(5) @(posedge clk);
	
		if(count !== 16'h0000) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter changed even when count_en=0, got = %2h ",$stime,count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter held value when count_en=0",$stime);
			$display("------------------------------------------------");
		end
        		$display("-----------------------ALL TEST PASSED-------------------------");
        $finish;
  	end




endmodule
