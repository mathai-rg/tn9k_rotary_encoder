//reads a rotar encoder and updates a register

module rotary_encoder(
    //inputs
    input in_a,
    input in_b,
    input rstn,
    input clk,
    //outputs
    output reg [5:0] count_out );

wire in_a_db;
wire in_b_db;
wire in_a_rise;

debounce dbnce_a(
    .sw_in(in_a),
    .clk(clk),
    .rstn(rstn),
    .sw_rise(in_a_rise),
    .sw_fall(),
    .sw_out(in_a_db) );

debounce dbnce_b(
    .sw_in(in_b),
    .clk(clk),
    .rstn(rstn),
    .sw_rise(),
    .sw_fall(),
    .sw_out(in_b_db) );

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        count_out <= 0;
    end
    else begin
        if(in_a_rise) begin
            if(in_b_db == 0) begin
                count_out <= count_out + 1'b1;
            end
            else begin
                count_out <= count_out - 1'b1;
            end
        end
    end
end

endmodule