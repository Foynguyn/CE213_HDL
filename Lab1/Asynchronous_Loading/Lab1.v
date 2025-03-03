module Lab1(
	input clk,
	input en,
	input [2:0] value,
	output [2:0] q
);
	
	wire [2:0] clear, preset;
	genvar k;
	generate
		for(k = 0; k < 3; k=k+1) begin: pre_clr
			assign clear[k] = en & ~value[k];
			assign preset[k] = en & value[k];
		end
	endgenerate
	
	wire d0, d1, d2;
	assign d0 = q[2]&(~(q[1]^q[0])) | (~q[2]&q[1]&~q[0]);
	assign d1 = ~q[1] | ~(q[2]^q[0]);
	assign d2 = ~q[0] | (~q[2]&~q[1]);
	
	d_ff d_ff2(.clk(clk), .d(d2), .clr(clear[2]), .pre(preset[2]), .q(q[2]));
	d_ff d_ff1(.clk(clk), .d(d1), .clr(clear[1]), .pre(preset[1]), .q(q[1]));
	d_ff d_ff0(.clk(clk), .d(d0), .clr(clear[0]), .pre(preset[0]), .q(q[0]));
endmodule

module d_ff(
	input clk,
	input d,
	input clr,
	input pre,
	output reg q
);
	always @(posedge clk or posedge clr or posedge pre) begin
		if(clr) q <= 0;
		else if(pre) q <= 1;
		else q <= d;
	end
endmodule
