`timescale 1ns/1ps
module tb_scan_dff;
	reg clk;
	reg rst;
	reg d;
	reg scan_in;
	reg scan_enable;
	wire q;
	
	//實例化待測模組
	scan_dff uut(
		.clk(clk),
		.rst(rst),
		.d(d),
		.scan_in(scan_in),
		.scan_enable(scan_enable),
		.q(q)
	);
	
	//產生時脈:10ns週期(50MHz)
	always #5 clk = ~clk;
	
	initial begin
		 //初始直
		 clk = 0;
		 rst = 1;
		 d =0;
		 scan_in =0;
		 scan_enable =0;
		 
		 //重置
		 #10 rst =0;
		 
		 //=====正常模式測試============
		 d =1;
		 #10 d =0;
		 #10 d =1;
		 
		 //=====進入scan模式==========
		 scan_enable =1;
		 scan_in =1;
		 #10 scan_in =0;
		 #10 scan_in =1;
		 
		 //=====回到正常模式==========
		 scan_enable =0;
		 d =0;
		 #10 d =1;
		 #10 d =1;
		 #10;
		 
		 $stop;
	end
endmodule
