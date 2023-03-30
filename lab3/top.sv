module top();
import fifo_params::*;

    fifoPorts  #(DSIZE)  itf();
    fifo_top             i0(itf.DUT);
    
    environment  env;

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
