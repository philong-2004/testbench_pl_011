`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
    ssp_interface vif();


    apb_interface dut(
    .PRESETn(PRESETn),
    // APB
    .PADDR(PADDR),
    .PCLK(PCLK),
    .PENABLE(PENABLE),
    .PRDATA(PRDATA),
    .PSEL(PSEL),
    .PWDATA(PWDATA),
    .PWRITE(PWRITE),
    // APB

    // Clock Generator
    .UARTCLK(UARTCLK),
    // Clock Generator

    // Reset Controller
    .nUARTRST(nUARTRST),
    // Reset Controller

    //Interrupt Controller
    .UARTMSINTR(UARTMSINTR),
    .UARTRXINTR(UARTRXINTR),
    .UARTTXINTR(UARTTXINTR),
    .UARTRTINTR(UARTRTINTR),
    .UARTEINTR(UARTEINTR),
    .UARTINTR(UARTINTR),
    //Interrupt Controller

    //DMA Controller
    .UARTTXDMASREQ(UARTTXDMASREQ),
    .UARTRXDMASREQ(UARTRXDMASREQ),
    .UARTTXDMABREQ(UARTTXDMABREQ),
    .UARTRXDMABREQ(UARTRXDMABREQ),
    .UARTTXDMACLR(UARTTXDMACLR),
    .UARTRXDMACLR(UARTRXDMACLR),
    //DMA Controller

    //DFT
    .SCANENABLE(SCANENABLE),
    .SCANINPCLK(SCANINPCLK),
    .SCANINUCLK(SCANINUCLK),
    .SCANOUTPCLK(SCANOUTPCLK),
    .SCANOUTUCLK(SCANOUTUCLK),
    //DFT

    //PAD
    .nUARTCTS(nUARTCTS),
    .nUARTDCD(nUARTDCD),
    .nUARTDSR(nUARTDSR),
    .nUARTRI(nUARTRI),
    .UARTRXD(UARTRXD),
    .SIRIN(SIRIN),
    .UARTTXD(UARTTXD),
    .nSIROUT(nSIROUT),
    .nUARTDTR(nUARTDTR),
    .nUARTRTS(nUARTRTS),
    .nUARTOut1(nUARTOut1),
    .nUARTOut2(nUARTOut2)
 
    );

    initial begin
        vif.PCLK = 0;
        forever #20 vif.PCLK = ~vif.PCLK;
    end

    initial begin
        vif.UARTCLK = 0;
        forever #10 vif.UARTCLK = ~vif.UARTCLK ;
    end

    initial begin
        vif.PRESETn = 0;
        repeat(2) @(posedge vif.PCLK);
        #1ps;
        vif.PRESETn = 1;
    end


    initial begin
        uvm_config_db#(virtual ssp_interface)::set(null, "*", "vif",vif);

        
        run_test("pclk_test");
        // run_test("uart_clk_test");
        //run_test("uart_glitch_test"); // clk đã khởi tạo trong testcase, tắt khởi tạo clk để run
        // run_test("freq_ratio_test"); // clk đã khởi tạo trong testcase, tắt khởi tạo clk để run
        // run_test("uart_stop_clk_test"); // clk đã khởi tạo trong testcase, tắt khởi tạo clk để run
        // run_test("baud_gen_test"); // clk đã khởi tạo trong testcase, tắt khởi tạo clk để run 
        // run_test("loopback_test");
        // run_test("parity_error_test");
        // run_test("pulseW_irDA_test"); //check pulse width data = (3/16) baudrate (baudrate = 230400)
        // run_test("data_size_test");
        // run_test("reset_test");
        // run_test("sir_en_test"); 
        // run_test("lowpwr_irDA_test"); // clk đã khởi tạo trong testcase, tắt khởi tạo clk để run 
        
        #10000;
        $finish;
    end
endmodule
