module mdio_1to2
    (input  wire mdio_mdc,
     input  wire mdio_o,
     input  wire mdio_t,
     output wire mdio_i,
     output wire phy0_mdc,
     output wire phy0_mdio_o,
     output wire phy0_mdio_t,
     input  wire phy0_mdio_i,
     output wire phy1_mdc,
     output wire phy1_mdio_o,
     output wire phy1_mdio_t,
     input  wire phy1_mdio_i
     );
    assign phy0_mdc    = mdio_mdc;
    assign phy0_mdio_t = mdio_t;
    assign phy0_mdio_o = mdio_o;
    assign phy1_mdc    = mdio_mdc;
    assign phy1_mdio_t = mdio_t;
    assign phy1_mdio_o = mdio_o;
    assign mdio_i      = phy0_mdio_i & phy1_mdio_i;
endmodule