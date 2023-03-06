module FIFO_tb();
reg rst,wr_en,rd_en,clk;
reg [7:0]data_in;
wire [7:0]data_out;
wire full,empty;
FIFO DUT(data_in,wr_en,clk,rst,data_out,rd_en,full,empty);
always
begin
    clk <= 0;
    #10;
    clk <= 1;
    #10;
end
task initialize();
begin
    rst <= 0;
    wr_en <= 0;
    rd_en <= 0;
end
endtask
task write_en(input a);
begin
    @(negedge clk)
    wr_en <= a;
end
endtask
task read_en(input b);
begin
    @(negedge clk)
    rd_en <= b;
end
endtask
task reset();
begin
    @(negedge clk)
    begin
        rst <= 1;
    end
    @(negedge clk)
    begin
        rst <= 0;
        #10;
    end
end
endtask
task data_input(input [7:0]c);
begin
    @(negedge clk)
    begin
        data_in <= c;
    end
end
endtask
initial 
begin
    initialize;
    reset;
    write_en(1);
    repeat (16)
    begin
        data_input($random %256);
    end
    write_en(0);
    read_en(1);
    #20;
    read_en(0);
    reset;
end
endmodule


