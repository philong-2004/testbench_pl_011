module apb_interface (
    PRESETn,
    // APB
    PADDR,
    PCLK,
    PENABLE,
    PRDATA,
    PSEL,
    PWDATA,
    PWRITE,
    // APB

    // Clock Generator
    UARTCLK,
    // Clock Generator

    // Reset Controller
    nUARTRST,
    // Reset Controller

    //Interrupt Controller
    UARTMSINTR,
    UARTRXINTR,
    UARTTXINTR,
    UARTRTINTR,
    UARTEINTR,
    UARTINTR,
    //Interrupt Controller

    //DMA Controller
    UARTTXDMASREQ,
    UARTRXDMASREQ,
    UARTTXDMABREQ,
    UARTRXDMABREQ,
    UARTTXDMACLR,
    UARTRXDMACLR,
    //DMA Controller

    //DFT
    SCANENABLE,
    SCANINPCLK,
    SCANINUCLK,
    SCANOUTPCLK,
    SCANOUTUCLK,
    //DFT

    //PAD
    nUARTCTS,
    nUARTDCD,
    nUARTDSR,
    nUARTRI,
    UARTRXD,
    SIRIN,
    UARTTXD,
    nSIROUT,
    nUARTDTR,
    nUARTRTS,
    nUARTOut1,
    nUARTOut2,
    //PAD
);
    input reg PRESETn;
    // APB
    input reg [11:2] PADDR;
    input reg PCLK;
    input reg PENABLE;
    output reg [15:0] PRDATA;
    input reg PSEL;
    input reg [15:0] PWDATA;
    input reg PWRITE;
    // APB

    // Clock Generator
    input reg UARTCLK;
    // Clock Generator

    // Reset Controller
    input reg nUARTRST;
    // Reset Controller

    //Interrupt Controller
    output wire UARTMSINTR;
    output wire UARTRXINTR;
    output wire UARTTXINTR;
    output wire UARTRTINTR;
    output wire UARTEINTR;
    output wire UARTINTR;
    //Interrupt Controller

    //DMA Controller
    input reg UARTTXDMASREQ;
    input reg UARTRXDMASREQ;
    input reg UARTTXDMABREQ;
    input reg UARTRXDMABREQ;
    output wire UARTTXDMACLR;
    output wire UARTRXDMACLR;
    //DMA Controller

    //DFT
    input reg SCANENABLE;
    input reg SCANINPCLK;
    input reg SCANINUCLK;
    output wire SCANOUTPCLK;
    output wire SCANOUTUCLK;
    //DFT

    //PAD
    input reg nUARTCTS;
    input reg nUARTDCD;
    input reg nUARTDSR;
    input reg nUARTRI;
    input reg UARTRXD;
    input reg SIRIN;
    output wire UARTTXD;
    output wire nSIROUT;
    output wire nUARTDTR;
    output wire nUARTRTS;
    output wire nUARTOut1;
    output wire nUARTOut2;
    //PAD
endmodule