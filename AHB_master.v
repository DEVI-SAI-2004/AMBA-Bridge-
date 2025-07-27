module AHB_master(input Hclk,Hresetn,Hreadyout,
input [31:0]Hresp,
input [31:0] Hrdata,
output reg Hwrite,Hreadyin,
output reg [31:0] Htrans,
output reg [31:0] Haddr,Hwdata);

reg [2:0] Hburst;
reg [2:0] Hsize;

integer i,j;



task single_write();
 begin
  @(posedge Hclk)
  #2;
   begin
    Hwrite=1;
    Htrans=2'b10;
    Hsize=3'b000;
    Hburst=3'b000;
    Hreadyin=1;
    Haddr=32'h8000_0001;
   end
  
  @(posedge Hclk)
  #2;
   begin
    Htrans=2'b00;
    Hwdata=8'h80;
   end 
 end
endtask


task single_read();
 begin
  @(posedge Hclk)
  #2;
   begin
    Hwrite=0;
    Htrans=2'b10;
    Hsize=3'b000;
    Hburst=3'b000;
    Hreadyin=1;
    Haddr=32'h8000_0001;
   end
  
  @(posedge Hclk)
  #2;
   begin
    Htrans=2'b00;
   end 
 end
endtask

task burst_write();
 begin
  @(posedge Hclk)
  #2;
   begin
    Hwrite=1'b1;
    Htrans=2'b10;
    Hsize=3'b000;
    Hburst=3'b011;
    Hreadyin=1;
    Haddr=32'h8000_0001;
   end
  
  @(posedge Hclk)
  #2;
   begin
    Haddr=Haddr+1'b1;
    Hwdata={$random}%256;
    Htrans=2'd3;
   end 
for(i=0;i<2;i=i+1)
begin
@(posedge Hclk);
#2;
    Haddr=Haddr+1;
    Hwdata={$random}%256;
    Htrans=2'd3;
end 

@(posedge Hclk);
#2;
    Hwdata={$random}%256;
    Htrans=2'd0;
end

endtask

endmodule
