module top();
    parameter  DSIZE = 8;
    parameter  ADDRSIZE = 4;
    parameter  DEPTH = 1<<ADDRSIZE;

    fifoPorts  #(DSIZE)  itf();
    fifo_top             i0(itf.DUT);
    
    environment #(DSIZE) env;

    initial begin
        env = new(itf);
        env.wcgu("wclk",10);
        env.rcgu("rclk",10);
        fork
            env.wrgu("wrst",10);
            env.rrgu("rrst",10);
        join
        repeat(5) @(posedge itf.rclk);
        env.fifoWrite(26);
        repeat(50) @(posedge itf.rclk);
        env.fifoRead(26);
        repeat(10) @(posedge itf.rclk);
        $stop;
    end

endmodule    
