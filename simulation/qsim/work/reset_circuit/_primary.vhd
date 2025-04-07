library verilog;
use verilog.vl_types.all;
entity reset_circuit is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        enable_PD       : out    vl_logic;
        clr_PC          : out    vl_logic
    );
end reset_circuit;
