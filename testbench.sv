// Testbench code

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

module tb;
  mul_if mif();
  
  mul dut (.a(mif.a), .b(mif.b), .y(mif.y));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    uvm_config_db #(virtual mul_if)::set(null, "uvm_test_top.e.a*", "mif", mif);
    run_test("test");
  end
  
endmodule
