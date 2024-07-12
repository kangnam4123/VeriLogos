module system_top_3 (
  eth_rx_clk,
  eth_rx_cntrl,
  eth_rx_data,
  eth_tx_clk_out,
  eth_tx_cntrl,
  eth_tx_data,
  eth_mdc,
  eth_mdio_i,
  eth_mdio_o,
  eth_mdio_t,
  eth_phy_resetn,
  phy_resetn,
  phy_rx_clk,
  phy_rx_cntrl,
  phy_rx_data,
  phy_tx_clk_out,
  phy_tx_cntrl,
  phy_tx_data,
  phy_mdc,
  phy_mdio);
  output            eth_rx_clk;
  output            eth_rx_cntrl;
  output  [  3:0]   eth_rx_data;
  input             eth_tx_clk_out;
  input             eth_tx_cntrl;
  input   [  3:0]   eth_tx_data;
  input             eth_mdc;
  output            eth_mdio_i;
  input             eth_mdio_o;
  input             eth_mdio_t;
  input             eth_phy_resetn;
  output            phy_resetn;
  input             phy_rx_clk;
  input             phy_rx_cntrl;
  input   [  3:0]   phy_rx_data;
  output            phy_tx_clk_out;
  output            phy_tx_cntrl;
  output  [  3:0]   phy_tx_data;
  output            phy_mdc;
  inout             phy_mdio;
  assign eth_rx_clk = phy_rx_clk;
  assign eth_rx_cntrl = phy_rx_cntrl;
  assign eth_rx_data = phy_rx_data;
  assign phy_tx_clk_out = eth_tx_clk_out;
  assign phy_tx_cntrl = eth_tx_cntrl;
  assign phy_tx_data = eth_tx_data;
  assign phy_mdc = eth_mdc;
  assign phy_mdio = (eth_mdio_t == 1'b0) ? eth_mdio_o : 1'bz;
  assign eth_mdio_i = phy_mdio;
  assign phy_resetn = eth_phy_resetn;
endmodule