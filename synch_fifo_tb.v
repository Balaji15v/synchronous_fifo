module synch_fifo_tb;
parameter depth=8; parameter width=16;
reg rst,clk,wr_en,rd_en;
reg [width-1:0]d_in;
wire [width-1:0]d_out;
wire full,empty;
reg stop;
synch_fifo #(.depth(8),.width(16)) dut (.rst(rst),.clk(clk),.wr_en(wr_en),.rd_en(rd_en),.d_in(d_in),.d_out(d_out),.full(full),.empty(empty));
always #5 clk=~clk;
initial begin
    {clk,wr_en,rd_en,d_in,stop}<=0;
    rst<=1;
    #10 rst<=0;
end
integer i;
initial begin
    @(posedge clk)
    for(i=0;i<25;i=i+1) begin
        wr_en<=1;
        d_in<=$random;
        #15 d_in<=$random;
    end
    stop<=1;
end
initial begin
    @(posedge clk)
    if(!stop) begin
        rd_en<=1;
    end
    #250 $finish;
end
initial begin
    $monitor("time=%d wr_en=%0b rd_en= %b d_in=%0b d_out=%0b",$time,wr_en,rd_en,d_in,d_out);
end
endmodule
