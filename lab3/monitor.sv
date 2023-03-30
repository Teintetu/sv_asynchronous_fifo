class monitor #(parameter DSIZE = 8);
    virtual fifoPorts         itf;
    logic   [DSIZE-1:0]       data; 

    function new(virtual fifoPorts itf);
        this.itf = itf;
    endfunction

    task Read(input int readNumber);
        int i=0;
        $display("%0t:INFO:Read.Read task,Start Reading...readNumber=%0d",$time,readNumber);
        do begin
            this.itf.rinc = 1'b1;
            @(posedge itf.rclk);
            this.data = itf.rdata;
            i++;
        end while (i < readNumber);
        this.itf.rinc = 1'b0;
        $display("%0t:INFO:Monitor.Read task:End Reading",$time);
    endtask
endclass
