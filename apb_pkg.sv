`timescale 1ns/10ps

package apb_pkg;

// Import the UVM class library  and UVM automation macros
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_rw.sv"
//`include "apb_monitor.sv"
`include "apb_sequence.sv"
//`include "reg_rst_seq.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"

`include "apb_monitor.sv"
`include "apb_agent.sv"
//`include "apb_scoreboard.sv"
`include "apb_env.sv"
`include "apb_test.sv"
//`include "apb_reg_rst_test.sv"
endpackage : apb_pkg

