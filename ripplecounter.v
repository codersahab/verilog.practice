/*
Name - Siddhant Jain
ID - 2018A7PS0282P
*/

module rsff(q, qbar, s, r, clk);

	input s,r,clk; 
	output q, qbar;

	wire nand1_out;
	wire nand2_out;


	nand n0(nand1_out,clk,s); 
	nand n1(nand2_out,clk,r); 
	nand n2(q,nand1_out,qbar);
	nand n3(qbar,nand2_out,q);

endmodule


module dff (input d,  
               input clk,  
               input rstn,  
               output reg q,  
               output qn);  
    wire r , s;
    assign r =d;
    assign s = ~d;
    rsff(q,qn,s,r,clk)  ;    
endmodule  
  
module ripple ( input clk,  
                input rstn,  
                output [3:0] out);  
   wire  q0;  
   wire  qn0;  
   wire  q1;  
   wire  qn1;  
   wire  q2;  
   wire  qn2;  
   wire  q3;  
   wire  qn3;  
  
   dff   dff0 ( .d (qn0),  
                .clk (clk),  
                .rstn (rstn),  
                .q (q0),  
                .qn (qn0));  
  
   dff   dff1 ( .d (qn1),  
                .clk (q0),  
                .rstn (rstn),  
                .q (q1),  
                .qn (qn1));  
   dff   dff2 ( .d (qn2),  
                .clk (q1),  
                .rstn (rstn),  
                .q (q2),  
                .qn (qn2));  
   dff   dff3 ( .d (qn3),  
                .clk (q2),  
                .rstn (rstn),  
                .q (q3),  
                .qn (qn3));  
   assign out = {qn3, qn2, qn1, qn0};  
endmodule

module mem1(
    input [2:0] sel,
    output [7:0] data
    output par);
    
    reg [7:0] mem[0:7];
    reg parity[0:7];          


        
    always @(reset) begin
        if(reset) begin
            
            //initialization
            mem[0] = 8'b00011111;
            mem[1] = 8'b00110001;
            mem[2] = 8'b01010011;
            mem[3] = 8'b01110101;
            mem[4] = 8'b10010111;
            mem[5] = 8'b10111001;
            mem[6] = 8'b11011011;
            mem[7] = 8'b11111101;
            par[0] = 1'b1;
            par[1] = 1'b1;
            par[2] = 1'b1;
            par[3] = 1'b1;
            par[4] = 1'b1;
            par[5] = 1'b1;
            par[6] = 1'b1;
            par[7] = 1'b1;
        end
    end 


    always @ (sel)
        begin
        case(sel)
            3’b000: 
                begin
                    par_out = par[0];
                    data = mem[0];
                end
            3’b001: 
                begin
                        par_out = par[1];
                        data = mem[1];
                end
            3’b010: 
                begin
                        par_out = par[2];
                        data = mem[2];
                end
            3’b011: 
                begin
                        par_out = par[3];
                        data = mem[3];
                end
            3’b100: 
                begin
                        par_out = par[4];
                        data = mem[4];
                end
            3’b101: 
                begin
                        par_out = par[5];
                     
                       data = mem[5];
                end
            3’b110: 
                begin
                        par_out = par[6];
                        data = mem[6];
                end
            3’b111: 
                begin
                        par_out = par[7];
                        data = mem[7];
                end
        endcase
    end




 
endmodule

module mem2(
    input [2:0] sel,
    output [7:0] data
    output par);
    
    reg [7:0] mem[0:7];
    reg parity[0:7];          


        
    always @(reset) begin
        if(reset) begin
            
            //initialization
            mem[0] = 8'b00000000;
            mem[1] = 8'b00100010;
            mem[2] = 8'b01000100;
            mem[3] = 8'b01100110;
            mem[4] = 8'b10001000;
            mem[5] = 8'b10101010;
            mem[6] = 8'b11001100;
            mem[7] = 8'b11101110;
            par[0] = 1'b0;
            par[1] = 1'b0;
            par[2] = 1'b0;
            par[3] = 1'b0;
            par[4] = 1'b0;
            par[5] = 1'b0;
            par[6] = 1'b0;
            par[7] = 1'b0;
        end
    end 


    always @ (sel)
        begin
        case(sel)
            3’b000: 
                begin
                    par_out = par[0];
                    data = mem[0];
                end
            3’b001: 
                begin
                        par_out = par[1];
                        data = mem[1];
                end
            3’b010: 
                begin
                        par_out = par[2];
                        data = mem[2];
                end
            3’b011: 
                begin
                        par_out = par[3];
                        data = mem[3];
                end
            3’b100: 
                begin
                        par_out = par[4];
                        data = mem[4];
                end
            3’b101: 
                begin
                        par_out = par[5];
                     
                       data = mem[5];
                end
            3’b110: 
                begin
                        par_out = par[6];
                        data = mem[6];
                end
            3’b111: 
                begin
                        par_out = par[7];
                        data = mem[7];
                end
        endcase
    end

endmodule

module mux2to1 (a, b, c, o);
input a, b, c;
output o;
assign o = c?a:b;
endmodule


module MUX16To8(memdata1, memdata2, select, out);
input [7:0] memdata1, memdata2;
input select;
output [7:0]out;

genvar j;
generate for(j=0;j<8;j = j+1) begin: mux__loop
mux2to1 m1(out[j],select,memdata1[j],memdata2[j]);
end
endgenerate
endmodule

module Parity_Checker(data_8bit, parity, parity_out);
input [7:0] data_8bit;
input parity;
output parity_out;
wire temp;

assign temp = (data_8bit[0] ^ data_8bit[1] ^ data_8bit[2] ^ data_8bit[3] ^ data_8bit[4]^ data_8bit[5]^ data_8bit[6]^ data_8bit[7]);
assign parity_out = ~(parity ^ temp);

endmodule