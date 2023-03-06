//to debounce encoder input pins

module debounce(
    //inputs
    input sw_in,
    input clk,
    input rstn,
    //outputs
    output reg sw_rise,
    output reg sw_fall,
    output reg sw_out );

reg [1:0] sw_shift;
reg [15:0] bounce_count;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        sw_shift <= 2'b00;
    end
    else begin
        sw_shift <= {sw_shift[0], sw_in};
    end
end

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        sw_rise <= 0;
        sw_fall <= 0;
        sw_out <= 0;
    end
    else begin
        if(bounce_count == 0) begin
            sw_rise <= sw_shift == 2'b01;
            sw_fall <= sw_shift == 2'b10;
            sw_out <= sw_shift[0];

            if(sw_shift[1] != sw_shift[0]) begin
                bounce_count <= 16'd65535;
            end
        end
        else begin
            sw_rise <= 0;
            sw_fall <= 0;
            bounce_count <= bounce_count-1'b1;
        end
    end
end

endmodule