`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:49:17 03/26/2018 
// Design Name: 
// Module Name:    fieldgenerator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fieldgenerator1(m,clk,,prim_poly,field);
input [2:0] m;
input clk;
input [0:4] prim_poly;
output [0:3] field;

reg [0:3] field;
reg [0:3] count;
reg [0:3] fvec;
reg [0:3] state1;
reg [0:4] state;
reg [0:3] alpha_m;
initial 
begin
	count<=3'b000;
end

always@(posedge clk)
begin
if(m==3)
begin
	alpha_m<=prim_poly[0:2];
	if(count==4'b0000)
		begin
			field<=count;
			count<=count+1'b1;
		end
	else if(count<=m)
		begin
			field<=4'b0000;
			field[count]<=1'b1;
			count<=count+1'b1;
		end
	else if(count<((2**m)-1))
		begin
			state1={1'b0,field[1:3]};
			if(state1[m]>0)
				begin
				fvec[0:2]=state1[0:2]^alpha_m[1:3];
				end
			else 
				begin
				fvec[0:2]=state1[0:2];
				end
			field<=fvec[0:2];
			count<=count+1'b1;
		end
	else if(count==3'b111)
		begin
			state1={1'b0,{field[1:3]}};
			if(state1[m]>0)
				begin
				fvec[0:2]=state1[0:2]^alpha_m;
				end
			else 
				begin
				fvec[0:2]=state1[0:2];
				end
			field<=fvec[0:2];
			count<=3'b000;
		end
end
else if(m==4)
begin
	alpha_m[0:3]<=prim_poly[0:3];
	if(count==4'b0000)
		begin
			field<=count;
			count<=count+1'b1;
		end
	else if(count<=m)
		begin
			field<=4'b0000;
			field[count-1]<=1'b1;
			count<=count+1'b1;
		end
	else if(count<((2**m)-1))
		begin
			state={1'b0,field};
			if(state[m]>0)
				begin
				fvec[0:3]=state[0:3]^alpha_m;
				end
			else 
				begin
				fvec[0:3]=state[0:3];
				end
			field<=fvec[0:3];
			count<=count+1'b1;
		end
	else if(count==4'b1111)
		begin
			state={1'b0,{field}};
			if(state[m]>0)
				begin
				fvec[0:3]=state[0:3]^alpha_m;
				end
			else 
				begin
				fvec[0:3]=state[0:3];
				end
			field<=fvec[0:3];
			count<=4'b0000;
		end
end
end
endmodule 