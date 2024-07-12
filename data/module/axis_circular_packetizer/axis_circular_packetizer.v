module axis_circular_packetizer #
(
  parameter integer AXIS_TDATA_WIDTH = 32,
  parameter integer AXIS_TDATA_PHASE_WIDTH = 32,
  parameter integer CNTR_WIDTH = 32,
  parameter         CONTINUOUS = "FALSE",
  parameter         NON_BLOCKING = "FALSE"
)
(
  input  wire                        aclk,
  input  wire                        aresetn,
  input  wire [CNTR_WIDTH-1:0]       cfg_data,
  output wire [CNTR_WIDTH-1:0]       trigger_pos,
  input  wire                        trigger,
  output wire                        enabled,
  output wire                        complete,
  output wire [AXIS_TDATA_PHASE_WIDTH-1:0]   phase,
  output wire                        s_axis_tready,
  input  wire [AXIS_TDATA_WIDTH+AXIS_TDATA_PHASE_WIDTH-1:0] s_axis_tdata,
  input  wire                        s_axis_tvalid,
  input  wire                        m_axis_tready,
  output wire [AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire                        m_axis_tvalid,
  output wire                        m_axis_tlast
);
  reg [CNTR_WIDTH-1:0] int_cntr_reg, int_cntr_next, int_trigger_pos, int_trigger_pos_next;
  reg int_enbl_reg, int_enbl_next;
  reg [AXIS_TDATA_PHASE_WIDTH-1:0] int_phase_reg, int_phase_next;
  reg int_complete_reg, int_complete_next;
  wire int_comp_wire, int_tvalid_wire, int_tlast_wire;
  always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_cntr_reg <= {(CNTR_WIDTH){1'b0}};
      int_trigger_pos <= {(CNTR_WIDTH){1'b0}};
      int_enbl_reg <= 1'b0;
      int_complete_reg <= 1'b0;
      int_phase_reg <= {(AXIS_TDATA_PHASE_WIDTH){1'b0}};
    end
    else
    begin
      int_cntr_reg <= int_cntr_next;
      int_trigger_pos <= int_trigger_pos_next;
      int_enbl_reg <= int_enbl_next;
      int_complete_reg <= int_complete_next;
      int_phase_reg <= int_phase_next;
    end
  end
  assign int_comp_wire = int_cntr_reg < cfg_data;
  assign int_tvalid_wire = int_enbl_reg & s_axis_tvalid;
  assign int_tlast_wire = ~int_comp_wire;
  generate
    if(CONTINUOUS == "TRUE")
    begin : CONTINUOUS_LABEL
      always @*
        begin
          int_cntr_next = int_cntr_reg;
          int_enbl_next = int_enbl_reg;
          int_complete_next = int_complete_reg;
          int_trigger_pos_next = int_trigger_pos;
          if(~int_enbl_reg & int_comp_wire)
            begin
              int_enbl_next = 1'b1;
            end
          if(m_axis_tready & int_tvalid_wire & int_comp_wire)
            begin
              int_cntr_next = int_cntr_reg + 1'b1;
            end
          if(m_axis_tready & int_tvalid_wire & int_tlast_wire)
            begin
              int_cntr_next = {(CNTR_WIDTH){1'b0}};
            end
        end
      end
    else
      begin : STOP
        always @*
          begin
            int_cntr_next = int_cntr_reg;
            int_trigger_pos_next = int_trigger_pos;
            int_enbl_next = int_enbl_reg;
            int_complete_next = int_complete_reg;
            int_phase_next = int_phase_reg;
            if(~int_enbl_reg & int_comp_wire)
              begin
                int_enbl_next = 1'b1;
              end
            if(m_axis_tready & int_tvalid_wire & int_comp_wire)
              begin
                if(trigger)
                  int_cntr_next = int_cntr_reg + 1'b1;
                else
                  begin
                     int_trigger_pos_next = int_trigger_pos + 1'b1;
                     int_phase_next = s_axis_tdata[(AXIS_TDATA_WIDTH+AXIS_TDATA_PHASE_WIDTH-1):AXIS_TDATA_WIDTH];
                  end   
              end
            if(m_axis_tready & int_tvalid_wire & int_tlast_wire)
              begin
                int_enbl_next = 1'b0;
                int_complete_next = 1'b1;
              end
         end
       end
  endgenerate
  if(NON_BLOCKING == "TRUE")  
    assign s_axis_tready = ~int_enbl_reg | m_axis_tready;
  else 
    assign s_axis_tready = int_enbl_reg & m_axis_tready;
  assign m_axis_tdata = s_axis_tdata[AXIS_TDATA_WIDTH-1:0];
  assign m_axis_tvalid = int_tvalid_wire;
  assign m_axis_tlast = int_enbl_reg & int_tlast_wire;
  assign trigger_pos = int_trigger_pos;
  assign enabled = int_enbl_reg;
  assign complete = int_complete_reg;
  assign phase = int_phase_reg;
endmodule