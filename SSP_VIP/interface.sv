interface ssp_interface;
    logic PRESETn;
    // APB
    logic [11:2] PADDR;
    logic PCLK;
    logic PENABLE;
    logic [15:0] PRDATA;
    logic PSEL;
    logic [15:0] PWDATA;
    logic PWRITE;
    // APB

    // Clock Generator
    logic UARTCLK;
    // Clock Generator

    // Reset Controller
    logic nUARTRST;
    // Reset Controller

    //Interrupt Controller
    logic UARTMSINTR;
    logic UARTRXINTR;
    logic UARTTXINTR;
    logic UARTRTINTR;
    logic UARTEINTR;
    logic UARTINTR;
    //Interrupt Controller

    //DMA Controller
    logic UARTTXDMASREQ;
    logic UARTRXDMASREQ;
    logic UARTTXDMABREQ;
    logic UARTRXDMABREQ;
    logic UARTTXDMACLR;
    logic UARTRXDMACLR;
    //DMA Controller

    //DFT
    logic SCANENABLE;
    logic SCANINPCLK;
    logic SCANINUCLK;
    logic SCANOUTPCLK;
    logic SCANOUTUCLK;
    //DFT

    //PAD
    logic nUARTCTS;
    logic nUARTDCD;
    logic nUARTDSR;
    logic nUARTRI;
    logic UARTRXD;
    logic SIRIN;
    logic UARTTXD;
    logic nSIROUT;
    logic nUARTDTR;
    logic nUARTRTS;
    logic nUARTOut1;
    logic nUARTOut2;
    //PAD
    
endinterface //interface;