`ifndef ENV_SV
`define ENV_SV

class environment;
    virtual fifoPorts   itf;

    clockGenerator       w_clkGen;
    clockGenerator       r_clkGen;
    resetGenerator       wrstGen;
    resetGenerator       rrstGen;
    driver      #(DSIZE) drv;
    monitor     #(DSIZE) mon;

    function new(virtual fifoPorts  itf);
        this.itf = itf;
        w_clkGen = new(itf);
        r_clkGen = new(itf);
        wrstGen  = new(itf);
        rrstGen  = new(itf);
        drv      = new(itf);
        mon      = new(itf);
    endfunction

    extern task wcgu(string msg = "wclk",int clk_p = 10);
    extern task rcgu(string msg = "rclk",int clk_p = 10);
    extern task wrgu(string msg = "wrst",int rst_p = 10);
    extern task rrgu(string msg = "rrst",int rst_p = 10);
    extern task fifoWrite(int writeNumber = 16);
    extern task fifoRead(int readNumber = 16);
endclass


task environment::wcgu(string msg = "wclk",int clk_p = 10);
    w_clkGen.clkGenerator(msg,clk_p);
endtask

task environment::rcgu(string msg = "rclk",int clk_p = 10);
    r_clkGen.clkGenerator(msg,clk_p);
endtask

task environment::wrgu(string msg = "wrst",int rst_p = 10);
    wrstGen.rstGenerator(msg,rst_p);
endtask

task environment::rrgu(string msg = "rrst",int rst_p = 10);
    rrstGen.rstGenerator(msg,rst_p);
endtask

task environment::fifoWrite(int writeNumber = 16);
    drv.Write(writeNumber);
endtask

task environment::fifoRead(int readNumber = 16);
    mon.Read(readNumber);
endtask

`endif


