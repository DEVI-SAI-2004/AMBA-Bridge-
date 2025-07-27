module test_bench ();
reg Hclk,Hresetn;
wire [31:0]Haddr,Hwdata,Hrdata,Paddr,Pwdata,Pwdataout,Paddrout,Prdata;
wire [1:0] Hresp,Htrans;
wire [2:0]Pselx,Pselout;
wire Hreadyout,Hwrite,Hreadyin,Penable,Pwriteout,Penableout;

AHB_master ahb(Hclk,Hresetn,Hreadyout,Hrdata,Haddr,Hwrite,Hreadyin,Htrans,Hwdata);

APB_Interface apb(Pwrite,Penable,Pselx,Paddr,Pwdata,Pwriteout,Penableout,Pselout,Paddrout,Pwdataout,Prdata);

Bridge_top bridge(Hclk,Hresetn,Hwrite,Hreadyin,Hwdata,Haddr,Prdata,Htrans,Pwrite,Penable,Hreadyout,Pselx,Paddr,Pwdata,Hrdata);

initial
begin
 Hclk=1'b0;
 forever #10 Hclk=~Hclk;
 end
  
 task reset();
 begin
	@(negedge Hclk);
	  Hresetn=1'b0;
	@(negedge Hclk);
	  Hresetn=1'b1;
 end 
 endtask

initial
 begin
  reset;
  //ahb.single_write();
  //ahb.burst_write();
  ahb.single_read();
#200 $finish;
 end
endmodule
