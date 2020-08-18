module labK;

reg [31:0] x; // a 32 -bit register
reg [0:0]  one;
reg [1:0]  two;
reg [2:0]  three;

initial
begin
    x = 32'd53234656;
    $display("time = %5d, x = %d",$time, x);
    x = 0;
    $display("time = %5d, x = %d",$time, x);
    x = x + 2;
    $display("time = %5d, x = %d",$time, x);
    one = &x;            // and reduction
    two = x[1:0];        // part-select
    three = {one, two};  // concatenate
    $display("time = %5d, one = %d",$time, one);
    $display("time = %5d, two = %d",$time, two);
    $display("time = %5d, three = %d",$time, three);
    $finish;
end
endmodule 
