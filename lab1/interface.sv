interface fifoPorts #(parameter DSIZE = 8);
    logic             wclk;
    logic             rclk;
    logic [DSIZE-1:0] rdata;
    logic [DSIZE-1:0] wdata;
    logic             wfull;
    logic             rempty;
    logic             winc,wrst_n;
    logic             rinc,rrst_n;

    clocking wcb @(posedge wclk);
        output        winc;
        output        wdata;
    endclocking:wcb

    clocking rcb @(posedge rclk);
        output        rinc;
    endclocking:rcb

    modport TB(
        output wclk,rclk,wdata,winc,wrst_n,rinc,rrst_n,
        input  rdata,wfull,rempty
    );

    modport DUT(
        output rdata,wfull,rempty,
        input  wclk,rclk,wdata,winc,wrst_n,rinc,rrst_n
    );

endinterface    

