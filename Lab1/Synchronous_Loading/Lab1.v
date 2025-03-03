module Lab1(
	input clk,
	input en,
	input [2:0] value,
	output [2:0] q
);
	
	wire d0, d1, d2;
	assign d0 = q[2]&(~(q[1]^q[0])) | (~q[2]&q[1]&~q[0]);
	assign d1 = ~q[1] | ~(q[2]^q[0]);
	assign d2 = ~q[0] | (~q[2]&~q[1]);

	wire [2:0] next_state;
	mux2_1 mux2(.a({d2,d1,d0}), .b(value), .sel(en), .y(next_state));
	
	d_ff d_ff2(.clk(clk), .d(next_state[2]), .q(q[2]));
	d_ff d_ff1(.clk(clk), .d(next_state[1]), .q(q[1]));
	d_ff d_ff0(.clk(clk), .d(next_state[0]), .q(q[0]));
endmodule

module d_ff(
	input clk,
	input d,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
endmodule

module mux2_1 #(parameter WIDTH = 3)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input sel,
	output [WIDTH-1:0] y
);
	assign y = sel?b:a;
endmodule
