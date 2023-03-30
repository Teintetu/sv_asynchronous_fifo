module fifo_top #(parameter DSIZE = 8,parameter ADDRSIZE = 4) (fifoPorts.DUT itf);
    reg  wclk_tmp;

    always@(*)  begin
        #1 wclk_tmp = itf.wclk;
    end

    fifo1  #(.DSIZE(DSIZE),.ASIZE(ADDRSIZE))  i0(
             .rdata(itf.rdata),
             .rinc(itf.rinc),
             .rempty(itf.rempty),
             .rclk(itf.rclk),
             .rrst_n(itf.rrst_n),
             .wdata(itf.wdata),
             .winc(itf.winc),
             .wclk(wclk_tmp),
             .wrst_n(itf.wrst_n),
             .wfull(itf.wfull)
    );

endmodule
