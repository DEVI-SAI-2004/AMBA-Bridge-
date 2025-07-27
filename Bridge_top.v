module Bridge_top(input Hclk,Hresetn,Hwrite,Hreadyin,
input [31:0]Hwdata,Haddr,Prdata,
input [1:0]Htrans,
output Pwrite,Penable,Hreadyout,
output [2:0]Psel,
output [31:0]Paddr,Pwdata,Hrdata);
wire valid,Hwritereg,Hwritereg1;
wire [31:0]Hwdata1,Hwdata2,Haddr1,Haddr2;
wire [2:0]tempselx;
wire [1:0]Hresp;

AHB_slave_interface ahb_S(Hclk,Hresetn,Hwrite,Hreadyin,Htrans,Haddr,Hwdata,Prdata,Hresp,
Hrdata,valid,Haddr1,Haddr2,Hwdata1,Hwdata2,Hwritereg,Hwritereg1,tempselx);

APB_Controller apb_C(Hclk,Hresetn,Hwrite,Hwrite_reg,valid,Haddr,Haddr1,Haddr2,Hwdata,Hwdata1,Hwdata2,Prdata,tempselx,Penable,Pwrite,Hreadyout,Paddr,Pwdata,Psel);
endmodule
