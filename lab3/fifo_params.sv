package fifo_params;
    parameter DSIZE = 8;
    parameter ADDRSIZE = 4;
    parameter DEPTH = 1<<ADDRSIZE;

    `include "clockGenerator.sv"
    `include "resetGenerator.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "environment.sv"

endpackage    
