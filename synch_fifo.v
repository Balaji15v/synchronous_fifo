module synch_fifo #(parameter depth=8, parameter width=16)
(input rst,clk,wr_en,rd_en, input[width-1:0]d_in,output reg [width-1:0]d_out,output full,empty);
reg [$clog2(depth)-1:0]rd_ptr,wr_ptr;
reg [width-1:0] mem[0:depth-1];
always @(posedge clk) begin
    if(rst)
    wr_ptr<=0;
    else begin
        if(wr_en && !full) begin
        mem[wr_ptr]<=d_in;
        wr_ptr<=wr_ptr+1;
        end
    end
end

always @(posedge clk) begin
    if(rst)
    rd_ptr<=0;
    else begin
        if(rd_en && !empty) begin
            d_out<=mem[rd_ptr];
            rd_ptr<=rd_ptr+1;
        end
    end
end
assign full = ((wr_ptr+1)==rd_ptr);
assign empty = (wr_ptr==rd_ptr);
endmodule
