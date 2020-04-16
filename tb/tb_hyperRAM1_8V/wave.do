onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group top /top/clk
add wave -noupdate -group top /top/reset
add wave -noupdate -group top /top/mem_or_reg
add wave -noupdate -group top /top/rd_num_dwords
add wave -noupdate -group top /top/latency_1x
add wave -noupdate -group top /top/latency_2x
add wave -noupdate -group top /top/data_pins_in
add wave -noupdate -group top /top/data_pins_out
add wave -noupdate -group top /top/dram_dq
add wave -noupdate -group top /top/dram_dq_oe_l
add wave -noupdate -group top /top/dram_rwds_in
add wave -noupdate -group top /top/dram_rwds_out
add wave -noupdate -group top /top/dram_rwds_oe_l
add wave -noupdate -group top /top/dram_ck
add wave -noupdate -group top /top/dram_rst_l
add wave -noupdate -group top /top/dram_cs_l
add wave -noupdate -group top /top/dram_rwds
add wave -noupdate -expand -group controller /top/controller_ip/reset
add wave -noupdate -expand -group controller /top/controller_ip/clk
add wave -noupdate -expand -group controller /top/controller_ip/rd_req
add wave -noupdate -expand -group controller /top/controller_ip/wr_req
add wave -noupdate -expand -group controller /top/controller_ip/mem_or_reg
add wave -noupdate -expand -group controller /top/controller_ip/wr_byte_en
add wave -noupdate -expand -group controller /top/controller_ip/rd_num_dwords
add wave -noupdate -expand -group controller /top/controller_ip/addr
add wave -noupdate -expand -group controller /top/controller_ip/wr_d
add wave -noupdate -expand -group controller /top/controller_ip/rd_d
add wave -noupdate -expand -group controller /top/controller_ip/rd_rdy
add wave -noupdate -expand -group controller /top/controller_ip/busy
add wave -noupdate -expand -group controller /top/controller_ip/latency_2x
add wave -noupdate -expand -group controller /top/controller_ip/dram_dq_in
add wave -noupdate -expand -group controller /top/controller_ip/dram_dq_out
add wave -noupdate -expand -group controller /top/controller_ip/dram_dq_oe_l
add wave -noupdate -expand -group controller /top/controller_ip/dram_rwds_in
add wave -noupdate -expand -group controller /top/controller_ip/dram_rwds_out
add wave -noupdate -expand -group controller /top/controller_ip/dram_rwds_oe_l
add wave -noupdate -expand -group controller /top/controller_ip/dram_ck
add wave -noupdate -expand -group controller /top/controller_ip/dram_rst_l
add wave -noupdate -expand -group controller /top/controller_ip/dram_cs_l
add wave -noupdate -expand -group controller /top/controller_ip/sump_dbg
add wave -noupdate -expand -group controller /top/controller_ip/addr_sr
add wave -noupdate -expand -group controller /top/controller_ip/data_sr
add wave -noupdate -expand -group controller /top/controller_ip/rd_sr
add wave -noupdate -expand -group controller -radix binary /top/controller_ip/ck_phs
add wave -noupdate -expand -group controller /top/controller_ip/fsm_addr
add wave -noupdate -expand -group controller /top/controller_ip/fsm_wait
add wave -noupdate -expand -group controller /top/controller_ip/fsm_data
add wave -noupdate -expand -group controller /top/controller_ip/run_rd_jk
add wave -noupdate -expand -group controller /top/controller_ip/run_jk
add wave -noupdate -expand -group controller /top/controller_ip/run_jk_sr
add wave -noupdate -expand -group controller /top/controller_ip/go_bit
add wave -noupdate -expand -group controller /top/controller_ip/rw_bit
add wave -noupdate -expand -group controller /top/controller_ip/reg_bit
add wave -noupdate -expand -group controller /top/controller_ip/rwds_in_loc
add wave -noupdate -expand -group controller /top/controller_ip/rwds_in_loc_p1
add wave -noupdate -expand -group controller /top/controller_ip/byte_wr_en
add wave -noupdate -expand -group controller /top/controller_ip/sr_data
add wave -noupdate -expand -group controller /top/controller_ip/sr_byte_en
add wave -noupdate -expand -group controller /top/controller_ip/dram_rd_d
add wave -noupdate -expand -group controller /top/controller_ip/addr_shift
add wave -noupdate -expand -group controller /top/controller_ip/data_shift
add wave -noupdate -expand -group controller /top/controller_ip/wait_shift
add wave -noupdate -expand -group controller /top/controller_ip/cs_loc
add wave -noupdate -expand -group controller /top/controller_ip/cs_l_reg
add wave -noupdate -expand -group controller /top/controller_ip/dram_ck_loc
add wave -noupdate -expand -group controller /top/controller_ip/rd_done
add wave -noupdate -expand -group controller /top/controller_ip/rd_cnt
add wave -noupdate -expand -group controller /top/controller_ip/rd_fsm
add wave -noupdate -expand -group controller /top/controller_ip/rd_dwords_cnt
add wave -noupdate -expand -group controller /top/controller_ip/sample_now
add wave -noupdate -group intf /top/intf/clk
add wave -noupdate -group intf /top/intf/reset
add wave -noupdate -group intf /top/intf/addr
add wave -noupdate -group intf /top/intf/wr_req
add wave -noupdate -group intf /top/intf/rd_req
add wave -noupdate -group intf /top/intf/wdata
add wave -noupdate -group intf /top/intf/rdata
add wave -noupdate -group intf /top/intf/busy
add wave -noupdate -group intf /top/intf/rd_rdy
add wave -noupdate -group driver_intf /top/intf/driver_cb/rd_rdy
add wave -noupdate -group driver_intf /top/intf/driver_cb/busy
add wave -noupdate -group driver_intf /top/intf/driver_cb/rdata
add wave -noupdate -group driver_intf /top/intf/driver_cb/wdata
add wave -noupdate -group driver_intf /top/intf/driver_cb/wr_byte_en
add wave -noupdate -group driver_intf /top/intf/driver_cb/rd_req
add wave -noupdate -group driver_intf /top/intf/driver_cb/wr_req
add wave -noupdate -group driver_intf /top/intf/driver_cb/addr
add wave -noupdate -group driver_intf /top/intf/driver_cb/driver_cb_event
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/rd_rdy
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/busy
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/rdata
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/wdata
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/wr_byte_en
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/rd_req
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/wr_req
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/addr
add wave -noupdate -group monitor_intf /top/intf/monitor_cb/monitor_cb_event
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/POWER_ON
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RESET_STATE
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DPD_STATE
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/STAND_BY
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/CA_BITS
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DATA_BITS
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ7
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ6
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ5
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ4
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ3
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ2
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ1
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ0
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDS
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/CSNeg
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/CK
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/CKNeg
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/CKDiff
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/rising_edge_CKDiff
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/PoweredUp
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RESETNeg
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Din
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout
add wave -noupdate -expand -group HyperRAM -radix decimal /top/hyperRAM/data_cycle
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Address
add wave -noupdate -expand -group HyperRAM -radix symbolic /top/hyperRAM/ca_cnt
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/ca_in
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSin
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Data_in
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/UByteMask
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/LByteMask
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Target
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/bus_cycle_state
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/current_state
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQt_01
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSt_01
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSRt_01
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/half_period
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/prev_CK
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/glitch_dq
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/glitch_rwds
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/glitch_rwdsR
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Viol
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSout_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ7_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ6_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ5_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ4_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ3_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ2_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ1_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/DQ0_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDS_zd
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout_zd_tmp
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSout_zd_tmp
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout_zd_latchH
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout_zd_latchL
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDS_zd_latchH
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDS_zd_latchL
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RESETNeg_pullup
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RW
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/REFCOLL
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/REFCOLL_ACTIV
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/t_RWR_CHK
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Dout_Z
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RWDSout_Z
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/tRWR_CHK
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RD_WRAP
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/Start_BurstAddr
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/RdWrStart
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/ALTERNATE_64
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/HYBRID
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffInDQ
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffOutDQ
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffInRWDS
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffOutRWDS
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffInRWDSR
add wave -noupdate -expand -group HyperRAM /top/hyperRAM/BuffOutRWDSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150295278 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
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
configure wave -timelineunits ns
update
WaveRestoreZoom {150227290 ps} {150358458 ps}
