onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/CLK_HALF_PERIOD
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/CLK_PERIOD
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/RESET_DELAY
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/VERBOSE
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_clk_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_rst_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_addr_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_burst_wr_rdy_o
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_latency_1x_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_latency_2x_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_mem_or_reg_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_rd_d_o
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_rd_num_dwords_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_rd_rdy_o
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_busy_o
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_rd_req_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_wr_req_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_wr_d_i
add wave -noupdate -expand -group tb_hyper_xface /tb_hyper_xface/tb_wr_byte_en_i
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/addr
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/burst_wr_rdy
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/busy
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/clk
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/data_pins_in
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/data_pins_out
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_ck
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_cs_l
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_dq
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_dq_oe_l
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_rst_l
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_rwds
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_rwds_in
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_rwds_oe_l
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/dram_rwds_out
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/latency_1x
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/latency_2x
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/mem_or_reg
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/rd_d
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/rd_num_dwords
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/rd_rdy
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/rd_req
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/reset
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/sump_dbg
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/wr_byte_en
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/wr_d
add wave -noupdate -group tb_wrapper /tb_hyper_xface/tb_wrapper_inst/wr_req
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/reset
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/clk
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_req
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/wr_req
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/mem_or_reg
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/wr_byte_en
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_num_dwords
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/addr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/wr_d
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_d
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_rdy
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/busy
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/burst_wr_rdy
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/latency_1x
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/latency_2x
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_dq_in
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_dq_out
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_dq_oe_l
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_rwds_in
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_rwds_out
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_rwds_oe_l
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_ck
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_rst_l
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_cs_l
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/sump_dbg
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/addr_sr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/data_sr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_sr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/ck_phs
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/fsm_reset
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/fsm_addr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/fsm_wait
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/fsm_data
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/run_rd_jk
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/run_jk
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/run_jk_sr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/go_bit
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rw_bit
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/reg_bit
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rwds_in_loc
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rwds_in_loc_p1
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/byte_wr_en
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/sr_data
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/sr_byte_en
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_rd_d
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/addr_shift
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/data_shift
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/wait_shift
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/cs_loc
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/cs_l_reg
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/dram_ck_loc
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_done
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_cnt
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_fsm
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/rd_dwords_cnt
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/sample_now
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/burst_wr_jk
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/burst_wr_jk_clr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/burst_wr_sr
add wave -noupdate -group hyper_xface /tb_hyper_xface/tb_wrapper_inst/controller_ip/burst_wr_d
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/ACT
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Address
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/AddrRANGE
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/ALTERNATE_64
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffInDQ
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffInRWDS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffInRWDSR
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffOutDQ
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffOutRWDS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BuffOutRWDSR
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BurstDelay
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/BurstLength
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/bus_cycle_state
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CA_BITS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/ca_cnt
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/ca_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CK
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CK_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CKDiff
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CKNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CKNeg_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Config_reg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CONTINUOUS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CSNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/CSNeg_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/current_state
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DATA_BITS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/data_cycle
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Data_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Din
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout_Z
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout_zd_latchH
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout_zd_latchL
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Dout_zd_tmp
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPD_ACT
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPD_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPD_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPD_STATE
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPDExt
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPDExt_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DPDExt_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ0
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ0_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ0_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ1
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ1_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ1_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ2
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ2_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ2_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ3
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ3_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ3_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ4
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ4_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ4_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ5
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ5_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ5_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ6
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ6_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ6_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ7
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ7_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQ7_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/DQt_01
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/falling_edge_CKDiff
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/falling_edge_CSNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/falling_edge_RESETNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/found
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/glitch_dq
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/glitch_rwds
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/glitch_rwdsR
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/half_period
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/HiAddrBit
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/HYBRID
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/LByteMask
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/LINEAR
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/MaxData
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/mem_file_name
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/MemSize
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/next_state
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/PartID
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/PO_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/PO_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/POWER_ON
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/PoweredUp
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/prev_CK
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RD_MODE
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RD_WRAP
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RdWrStart
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/REF_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/REF_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/REFCOLL
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/REFCOLL_ACTIV
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RefreshDelay
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RESET_STATE
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RESETNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RESETNeg_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RESETNeg_pullup
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_CKDiff
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_CSNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_DPD_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_DPD_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_PO_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_PoweredUp
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_REF_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_RESETNeg
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/rising_edge_RPH_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RPH_in
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RPH_out
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RW
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDS
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDS_ipd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDS_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDS_zd_latchH
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDS_zd_latchL
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSin
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSout_Z
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSout_zd
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSout_zd_tmp
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSRt_01
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/RWDSt_01
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/SPEED166
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/STAND_BY
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Start_BurstAddr
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/t_RWR_CHK
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Target
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/TimingModel
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/tmp_char1
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/tmp_timing
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/tRWR_CHK
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/UByteMask
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/UserPreload
add wave -noupdate -group hyperRAM /tb_hyper_xface/tb_wrapper_inst/hyperRAM/Viol
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150238000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 325
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {150089413 ps} {150203742 ps}
