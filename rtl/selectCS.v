
module selectCS #(
    parameter MODULES = 4,
    parameter RAM_SIZE = 8388608,
    parameter ADDR_WIDTH = 32
) (
    input   wire                    clk,
    input   wire                    rstn,
    input   wire                    cs_i,
    output  reg  [3:0]              cs_mask_o,
    input   wire [ADDR_WIDTH-1:0]   addr_i,
    output  wire [ADDR_WIDTH-1:0]   addr_o
);

localparam log_modules = $clog2(MODULES);
localparam log_ram_size = $clog2(RAM_SIZE);

reg [ADDR_WIDTH-1:0] addr_chk_d, addr_chk_q;
reg [MODULES-1:0] selCS_chk_d, selCS_chk_q;
always @(posedge clk, negedge rstn) begin
    if (!rstn) begin
        addr_chk_d <= 32'b0;
        addr_chk_q <= 32'b0;
        selCS_chk_d <= 4'b0;
        selCS_chk_q <= 4'b0;
    end
    else begin
        addr_chk_q <= addr_chk_d;
        selCS_chk_q <= selCS_chk_d;
    end
end
assign addr_o = addr_chk_q;
assign cs_mask_o = selCS_chk_q;

reg [log_modules-1:0] auxCS;
integer i;
always @(*) begin
    addr_chk_d = {{ADDR_WIDTH-log_ram_size{1'b0}}, addr_chk_i[log_ram_size-1:0]};
    auxCS = addr_chk_i[log_ram_size+log_modules-1:log_ram_size];
    //One Hot encoding
    for (i = 0; i < MODULES; i++) begin
        if (i == {{32-log_modules{1'b0}}, auxCS}) selCS_chk_d[i] = cs_i;
        else selCS_chk_d[i] = 1'b1;
    end
end
    
endmodule