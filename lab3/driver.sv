class driver #(parameter DSIZE = 8);
    virtual    fifoPorts    itf;
    rand logic [DSIZE-1:0]  wdata;

    function new(virtual fifoPorts itf);
        this.itf = itf;
    endfunction

    task Write(input int writeNumber);
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
endclass
