//reads a rotar encoder and updates a register

module rotary_encoder(
    //inputs
    input in_a,
    input in_b,
    input rstn,
    input clk,
    //outputs
    output reg [3:0] count_out,
    output out_a,
    output out_b);

wire in_a_db;
wire in_b_db;
wire in_a_rise;

assign out_a = in_a;
assign out_b = in_b;

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
        count_out <= 4'b0000;
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