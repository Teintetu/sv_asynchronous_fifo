module top();
    parameter  DSIZE = 8;
    parameter  ADDRSIZE = 4;
    parameter  DEPTH = 1<<ADDRSIZE;

    fifoPorts  #(DSIZE)  itf();
    fifo_top             i0(itf.DUT);
    clockGenerator       w_clkGen;
    clockGenerator       r_clkGen;
    resetGenerator       wrstGen;
    resetGenerator       rrstGen;
    initial begin
        w_clkGen = new(itf);
        r_clkGen = new(itf);
        wrstGen  = new(itf);
        rrstGen  = new(itf);
        w_clkGen.clkGenerator("wclk",10);
        r_clkGen.clkGenerator("rclk",10);
        wrstGen.rstGenerator("wrst",15);
        rrstGen.rstGenerator("rrst",10);
        repeat(10) @(posedge itf.rclk);
        $stop;
    end

endmodule    
