class clockGenerator;
    logic               wclk,rclk;
    int                 period;
    virtual  fifoPorts  itf;
    event               wclkKill,rclkKill;

    function new(virtual fifoPorts itf);
        this.itf = itf;
    endfunction

    task automatic clkActivate(input string clkName);
        if(clkName == "wclk") begin
            $display("%0t:INFO:Calling task wclkActivate",$time);
            this.itf.wclk = 1'b0;
            fork:clkgen
                wait(this.wclkKill.triggered) begin:killclock
                    $display("%t INFO:Killing the clk",$time);
                end:killclock

                forever begin:startclock
                    #this.period  this.itf.wclk++;
                end:startclock
            join_any:clkgen
            disable fork;
        end
        else begin 
            $display("%0t:INFO:Calling task rclkActivate",$time);
            this.itf.rclk = 1'b0;
            fork:clkgen2
                wait(this.rclkKill.triggered) begin:killclock
                    $display("%t INFO:Killing the clk",$time);
                end:killclock

                forever begin:startclock
                    #this.period  this.itf.rclk++;
                end:startclock
            join_any:clkgen2
            disable fork;
        end
    endtask

    task automatic clkGenerator(input string clkName,input int wclkPeriod);
        $display ("%0t :INFO:Calling task clkGenerator for %s",$time,clkName);
        this.period = wclkPeriod/2;
        fork
            clkActivate(clkName);
        join_none
    endtask

    task clkStop(input string clkName);
        $display("%0t:INFO:Stopping clock %s",$time,clkName);
        if(clkName == "wclk")
            ->wclkKill;
        else
            ->rclkKill;
    endtask
endclass
