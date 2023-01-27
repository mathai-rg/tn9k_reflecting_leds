module led (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

reg [22:0] counter;
reg flag;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 23'd0;
    else if (counter < 23'd1349_999)       // 0.5s delay
        counter <= counter + 1'd1;
    else
        counter <= 23'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin        //flag control
    if (!sys_rst_n)
        flag <= 1'd0;
    else if (led[5:0] == 6'b011111)
        flag <= 1'd1;
    else if (led[5:0] == 6'b111110)
        flag <= 1'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 6'b011111;
    else if (counter == 23'd1349_999 && flag == 0)       // 0.5s delay
//        led[5:0] <= {led[0],led[5:1]};
        led[5:0] <= {led[4:0],led[5]};
    else if (counter == 23'd1349_999 && flag == 1)       // 0.5s delay
//        led[5:0] <= {led[4:0],led[5]};
        led[5:0] <= {led[0],led[5:1]};
    else
        led <= led;
end

endmodule