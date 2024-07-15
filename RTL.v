MODULE OVEN(CLK , IN, TEMP , TEMP_TIME,OUT, TT);
  input clk , in ;
 input [1:0] tt;
  output reg [1:0] temp ;
  output reg [1:0] temp_time;
  output reg out;
  localparam idle = 3'b000 , temp_sel =3'b001 , easy_sel = 3'b010, time_sel= 3'b011, check = 3'b100 ;   
  reg [2:0] state ;
  always @(posedge clk )
   begin
    case(state)
     //idle
     idle: begin
      out<=in?0:0;
      state<=in?temp_sel:idle;
     end
     //temp_sel
     temp_sel : begin
      out<=in?0:0;
      state<=in?time_sel:easy_sel;
     end
     //easy_sel
     easy_sel : begin
      out<=in?0:0;
      state<=in?check:temp_sel;
     end
     //time_sel
     time_sel : begin
      out<=in?0:0;
      state<=in?check:temp_sel;    
     end
     //check
     check: begin
      out<=in?1:0;
      state<=in?idle:temp_sel;
     end
     // default
     default: begin
      out<=0;
      state<=idle;
     end
    endcase
end
  ALWAYS @(POSEDGE TT,STATE) BEGIN
   //ideal
    if ( state==3'b000) begin
      temp<=0;
   temp_time<=0;
      end
   //check
   else if (state==3'b100) begin
      temp<=temp;
   temp_time<=temp_time;
      end
   //temp seltion
   else if (tt==0 & state==1) begin
      temp<=0;
   temp_time<=0;
      end
   else if (tt== 1 & state==1) begin
      temp<=1;
   temp_time<=0;
      end
   else if (tt== 2 & state==1) begin
      temp<=2;
   temp_time<=0;
      end
   else if (tt== 3 & state==1) begin
      temp<=3;
   temp_time<=0;
      end
      // EASY MODE
   else if (tt==0 & state==2) begin
      temp<=0;
   temp_time<=0;
      end
   else if (tt== 1 & state==2) begin
     temp<=1;
   temp_time<=1;
      end
   else if (tt== 2 & state==2) begin
      temp<=2;
   temp_time<=2;
      end
   else if (tt== 3 & state==2) begin
     temp<=3;
   temp_time<=3;
      end
  //TIME SELETION
   else if (tt==0 & state==3) begin
      temp<=temp;
   temp_time<=0;
      end
   else if (tt== 1 & state==3) begin
      temp<=temp;
   temp_time<=1;
      end
   else if (tt== 2 & state==3) begin
      temp<=temp;
   temp_time<=2;
      end
   else if (tt== 3 & state==3) begin  
   temp<=temp;
   temp_time<=3;   
   end
   else begin
    temp<=2'b00;
   temp_time<=2'b00;    
   end
  end
   endmodule
// final code 
