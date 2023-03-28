`ifndef ENV_SV
`define ENV_SV

class environment #(parameter DSIZE = 8);
    virtual fifoPorts   itf;
    logic [DSIZE-1:0]   data;

    clockGenerator       w_clkGen;
    clockGenerator       r_clkGen;
    resetGenerator       wrstGen;
    resetGenerator       rrstGen;

    function new(virtual fifoPorts  itf);
        this.itf = itf;
        w_clkGen = new(itf);
        r_clkGen = new(itf);
        wrstGen  = new(itf);
        rrstGen  = new(itf);
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
    int i=0;
    $display("%0t:INFO:Driver.Write task,Start Writing...writeNumber=%0d",$time,writeNumber);
    do begin
        this.itf.wcb.winc <= 1'b1;
        this.itf.wcb.wdata <= i;
        @(posedge itf.wclk);
        i++;
    end while(i < writeNumber);
    this.itf.wcb.winc <= 1'b0;
    $display("%0t:INFO:Driver.Write task,End Writing",$time);
endtask

task environment::fifoRead(int readNumber = 16);
    int i=0;
    $display("%0t:INFO:Read.Read task,Start Reading...readNumber=%0d",$time,readNumber);
    do begin
        this.itf.rinc = 1'b1;
        @(posedge itf.rclk);
        this.data = itf.rdata;
        i++;
    end while (i < readNumber);
    this.itf.rinc = 1'b0;
    $display("%0t:INFO:Read.Read task:End Reading",$time);
endtask

`endif


