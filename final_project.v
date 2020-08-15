module final_project(output reg[7:0] R, G, B,output reg [3:0] A,output reg [3:0] light,output reg voice,output reg[3:0] com, output[0:6] S,input clk,up,down,left,right,reset,ready, input[2:0] level);

                                      //7 y
parameter logic [7:0] maze1 [0:7] = '{8'b00000000,//0		level1
												  8'b00111100,
												  8'b01111110,
												  8'b01111110,
												  8'b01111110,
												  8'b01111110,
												  8'b00111110,
												  8'b00000000};
												  
parameter logic [7:0] maze2 [0:7] = '{8'b00000000,//		level2
												  8'b00000000,
												  8'b01111100,
												  8'b01101000,
												  8'b01111100,
												  8'b01011100,
												  8'b00000000,
												  8'b00000000};
												  
parameter logic [7:0] maze3 [0:7] = '{8'b00000000,//		level3
												  8'b00111110,
												  8'b00000110,
												  8'b01110110,
												  8'b01011110,
												  8'b01011110,
												  8'b00001100,
												  8'b00000000};
												 
parameter logic [7:0] box1 [0:7] = '{8'b11111111,//		box of level1
												 8'b11111111,
												 8'b11101111,
												 8'b11111111,
												 8'b11010111,
												 8'b11111111,
												 8'b11111111,
												 8'b11111111};
												 
parameter logic [7:0] box2 [0:7] = '{8'b11111111,//		box of level2
												 8'b11111111,
												 8'b11101111,
												 8'b11011111,
												 8'b11111111,
												 8'b11110111,
												 8'b11111111,
												 8'b11111111};
									  
parameter logic [7:0] box3 [0:7] = '{8'b11111111,//		box of level3
												 8'b11111111,
												 8'b11111011,
												 8'b11111111,
												 8'b11101111,
												 8'b11111011,
												 8'b11111111,
												 8'b11111111};
												 
parameter logic [7:0] player1 [0:7] = '{8'b11111111,//	player of level1
													 8'b10111101,
													 8'b11111111,
													 8'b11111111,
													 8'b11111111,
													 8'b10111111,
													 8'b10111111,
													 8'b11111111};
													 
parameter logic [7:0] player2 [0:7] = '{8'b11111111,//	player of level2
													 8'b11110111,
													 8'b11111111,
													 8'b11111111,
													 8'b11111101,
													 8'b10111111,
													 8'b11101111,
													 8'b11111111};
													 
parameter logic [7:0] player3 [0:7] = '{8'b11111111,//	player of level3
													 8'b10111111,
													 8'b11111111,
													 8'b11111111,
													 8'b11111111,
													 8'b10111111,
													 8'b11101101,
													 8'b11111111};
				  
parameter logic [7:0] start [0:7] =  '{8'b11100111,//		start picture
													8'b11000011,
													8'b10001101,
													8'b00010110,
													8'b00001110,
													8'b10010101,
													8'b11000011,
													8'b11100111};
									  
parameter logic [7:0] over [0:7] =   '{8'b11011111,//		complete picture
												   8'b10111111,
												   8'b01111111,
												   8'b10111111,
												   8'b11011111,
												   8'b11101111,
												   8'b11110111,
												   8'b11111011};		  
												 
divfreq F0(clk, CLK_div1000);
divfre F1(clk, CLK_div1);
byte cnt,xindex,yindex,count;
reg[3:0] step1, step2;
logic [7:0] player [0:7];
logic [7:0] box [0:7];
logic [7:0] maze [0:7];

initial
begin
	cnt=0;
	xindex=5;
	yindex=6;
	count=0;
	step1 <= 4'b0000;
	step2 <= 4'b0000;
	com <= 4'b1110;
	voice <= 1'b0;
end

always @(posedge CLK_div1000)
	begin
		if (cnt >=7)
			cnt <=0;
		else
			cnt<= cnt+1;
		A <= {cnt,1'b1};
	
	end
	
always @(posedge CLK_div1000)
	begin
		if(com == 4'b1110)	com <= 4'b1101;
		else	com <= 4'b1110;
	end		

always @(posedge CLK_div1000)
	begin
      if(ready) //start game
			begin
				R <= maze[cnt];
				G <= player[cnt];
				B <= box[cnt];
		     case(count)
					4'b0000: light <= 4'b0000;		   
					4'b0001: light[3] <= 1'b1;
					4'b0010: light[2] <= 1'b1;
					4'b0011: light[1] <= 1'b1;
		     endcase
				if(count==3)
					begin
						R <= 8'b11111111;
						G <= 8'b11111111;
						B <= over[cnt];
					end
         end
		else  //start picture
			begin
            B <= 8'b11111111;
				R <= 8'b11111111;
				G <= start[cnt];
			end
				
	end
	
	
always @(posedge CLK_div1)
	begin
		case(step1)	//10^0
			4'b0000: 
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b0;
				S[5] <= 1'b0;
				S[6] <= 1'b1;
			end	
			4'b0001:
			begin
				S[0] <= 1'b1;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b1;
				S[4] <= 1'b1;
				S[5] <= 1'b1;
				S[6] <= 1'b1;
			end	
			4'b0010:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b1;
				S[3] <= 1'b0;
				S[4] <= 1'b0;
				S[5] <= 1'b1;
				S[6] <= 1'b0;
			end	
			4'b0011:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b1;
				S[5] <= 1'b1;
				S[6] <= 1'b0;
			end	
			4'b0100:
			begin
				S[0] <= 1'b1;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b1;
				S[4] <= 1'b1;
				S[5] <= 1'b0;
				S[6] <= 1'b0;
			end	
			4'b0101:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b1;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b1;
				S[5] <= 1'b0;
				S[6] <= 1'b0;
			end	
			4'b0110:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b1;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b0;
				S[5] <= 1'b0;
				S[6] <= 1'b0;
			end	
			4'b0111:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b1;
				S[4] <= 1'b1;
				S[5] <= 1'b1;
				S[6] <= 1'b1;
			end
			4'b1000:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b0;
				S[5] <= 1'b0;
				S[6] <= 1'b0;
			end	
			4'b1001:
			begin
				S[0] <= 1'b0;
				S[1] <= 1'b0;
				S[2] <= 1'b0;
				S[3] <= 1'b0;
				S[4] <= 1'b1;
				S[5] <= 1'b0;
				S[6] <= 1'b0;
			end	
		endcase
		if(step1 == 4'b1010)
			begin
				step1 <= 4'b0000;
				step2 <= step2 + 1'b1;
				case(step2)
				4'b0000: 
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b0;
					S[5] <= 1'b0;
					S[6] <= 1'b1;
				end	
				4'b0001:
				begin
					S[0] <= 1'b1;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b1;
					S[4] <= 1'b1;
					S[5] <= 1'b1;
					S[6] <= 1'b1;
				end	
				4'b0010:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b1;
					S[3] <= 1'b0;
					S[4] <= 1'b0;
					S[5] <= 1'b1;
					S[6] <= 1'b0;
				end	
				4'b0011:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b1;
					S[5] <= 1'b1;
					S[6] <= 1'b0;
				end	
				4'b0100:
				begin
					S[0] <= 1'b1;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b1;
					S[4] <= 1'b1;
					S[5] <= 1'b0;
					S[6] <= 1'b0;
				end	
				4'b0101:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b1;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b1;
					S[5] <= 1'b0;
					S[6] <= 1'b0;
				end	
				4'b0110:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b1;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b0;
					S[5] <= 1'b0;
					S[6] <= 1'b0;
				end	
				4'b0111:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b1;
					S[4] <= 1'b1;
					S[5] <= 1'b1;
					S[6] <= 1'b1;
				end
				4'b1000:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b0;
					S[5] <= 1'b0;
					S[6] <= 1'b0;
				end	
				4'b1001:
				begin
					S[0] <= 1'b0;
					S[1] <= 1'b0;
					S[2] <= 1'b0;
					S[3] <= 1'b0;
					S[4] <= 1'b1;
					S[5] <= 1'b0;
					S[6] <= 1'b0;
				end	
			endcase
			end
		voice <= 1'b0;
      if(reset) //reset and change level
			begin
				if(level==3'b001)
					begin
						player <= player1;
						box <= box1;
						maze <= maze1;
					end
				if(level==3'b010)
					begin
						player <= player2;
						box <= box2;
						maze <= maze2;
					end
				if(level==3'b011)
					begin
						player <= player3;
						box <= box3;
						maze <= maze3;
			      end
				xindex=5;
				yindex=6;
				count=0;	
				step1 <= 4'b0000;
				step2 <= 4'b0000;				
			end
		if(up)//up
			begin
				if(maze[xindex][yindex-1]==1'b0)  // touch wall
					player[xindex] <=player[xindex];
				else if(maze[xindex][yindex-1]==1'b1 && box[xindex][yindex-1]==1'b1) // no wall and box
					begin
						player[xindex][yindex-1]<=1'b0;
						player[xindex][yindex] <= 1'b1;
						yindex--;
						step1 <= step1 + 1'b1;
					end
				else if(box[xindex][yindex-1]==1'b0) //touch box
					begin
						if (maze[xindex][yindex-2]==1'b0 && player[xindex][yindex-2]==1'b0) //enter the mission point
							begin
								if(box[xindex][yindex-2]==1'b1) // enter if there is no box
									begin							
										player[xindex][yindex-1]<=1'b0;
										player[xindex][yindex] <= 1'b1;
										box[xindex][yindex-2] <=1'b0;
										box[xindex][yindex-1] <=1'b1;
										yindex--;
										count++;
										voice <=1'b1;
										step1 <= step1 + 1'b1;
			                  end							
							end
						else if(maze[xindex][yindex-2]==1'b0 || box[xindex][yindex-2]==1'b0) //touch two boxs or wall
							player[xindex] <= player[xindex];
						else //movement of player and box
							begin
								player[xindex][yindex-1]<=1'b0;
								player[xindex][yindex] <= 1'b1;
								box[xindex][yindex-2] <=1'b0;
								box[xindex][yindex-1] <=1'b1;
								yindex--;
								step1 <= step1 + 1'b1;
							end

					end
			end
		if(down)//down
			begin
				if(maze[xindex][yindex+1]==1'b0)
					player[xindex] <=player[xindex];
				else if(maze[xindex][yindex+1]==1'b1 && box[xindex][yindex+1]==1'b1)
					begin
						player[xindex][yindex+1]<=1'b0;
						player[xindex][yindex] <= 1'b1;
						yindex++;
						step1 <= step1 + 1'b1;
					end
				else if(box[xindex][yindex+1]==1'b0)
					begin
						if (maze[xindex][yindex+2]==1'b0 && player[xindex][yindex+2]==1'b0)
							begin
								if(box[xindex][yindex+2]==1'b1)
									begin
										player[xindex][yindex+1]<=1'b0;
										player[xindex][yindex] <= 1'b1;
										box[xindex][yindex+2] <=1'b0;
										box[xindex][yindex+1] <=1'b1;
										yindex++;
										count++;
										voice <=1'b1;
										step1 <= step1 + 1'b1;
			                  end							
							end
						else if(maze[xindex][yindex+2]==1'b0 || box[xindex][yindex+2]==1'b0)
							player[xindex] <= player[xindex];
						else
							begin
								player[xindex][yindex+1]<=1'b0;
								player[xindex][yindex] <= 1'b1;
								box[xindex][yindex+2] <=1'b0;
								box[xindex][yindex+1] <=1'b1;
								yindex++;
								step1 <= step1 + 1'b1;
							end

					end
			end
		if(left)//left
			begin
				if(maze[xindex-1][yindex]==1'b0)
					player[xindex] <=player[xindex];
				else if(maze[xindex-1][yindex]==1'b1 && box[xindex-1][yindex]==1'b1)
					begin
						player[xindex-1][yindex]<=1'b0;
						player[xindex][yindex] <= 1'b1;
						xindex--;
						step1 <= step1 + 1'b1;
					end
				else if(box[xindex-1][yindex]==1'b0)
					begin
						if (maze[xindex-2][yindex]==1'b0 && player[xindex-2][yindex]==1'b0)
							begin
								if(box[xindex-2][yindex]==1'b1)
									begin
										player[xindex-1][yindex]<=1'b0;
										player[xindex][yindex] <= 1'b1;
										box[xindex-2][yindex] <=1'b0;
										box[xindex-1][yindex] <=1'b1;
										xindex--;
										count++;
										voice <=1'b1;
										step1 <= step1 + 1'b1;
			                  end							
							end
						else if(maze[xindex-2][yindex]==1'b0 || box[xindex-2][yindex]==1'b0)
							player[xindex] <= player[xindex];
						else
							begin
								player[xindex-1][yindex]<=1'b0;
								player[xindex][yindex] <= 1'b1;
								box[xindex-2][yindex] <=1'b0;
								box[xindex-1][yindex] <=1'b1;
								xindex--;
								step1 <= step1 + 1'b1;
							end

					end
			 end
		if(right)//right
			begin
				if(maze[xindex+1][yindex]==1'b0)
					player[xindex] <=player[xindex];
				else if(maze[xindex+1][yindex]==1'b1 && box[xindex+1][yindex]==1'b1)
					begin
						player[xindex+1][yindex]<=1'b0;
						player[xindex][yindex] <= 1'b1;
						xindex++;
						step1 <= step1 + 1'b1;
					end
				else if(box[xindex+1][yindex]==1'b0)
					begin
						if (maze[xindex+2][yindex]==1'b0 && player[xindex+2][yindex]==1'b0)
							begin
								if(box[xindex+2][yindex]==1'b1)
								begin
									player[xindex+1][yindex]<=1'b0;
									player[xindex][yindex] <= 1'b1;
									box[xindex+2][yindex] <=1'b0;
									box[xindex+1][yindex] <=1'b1;
									xindex++;
									count++;
									voice <=1'b1;
									step1 <= step1 + 1'b1;
								end
							end
						else if(maze[xindex+2][yindex]==1'b0 || box[xindex+2][yindex]==1'b0)
							player[xindex] <= player[xindex];
						else
							begin
								player[xindex+1][yindex]<=1'b0;
								player[xindex][yindex] <= 1'b1;
								box[xindex+2][yindex] <=1'b0;
								box[xindex+1][yindex] <=1'b1;
								xindex++;
								step1 <= step1 + 1'b1;
							end

					end
			  end
	
	end

endmodule
	
module divfreq(input CLK,output reg CLK_div);
reg [24:0] Count;
always@(posedge CLK)
 begin 
   if(Count>50000) //25000
	  begin
	    Count<=25'b0;
		 CLK_div<=~CLK_div;
	  end
	else
		Count <=Count+1'b1;
	end
endmodule

module divfre(input CLK,output reg CLK_div);
reg [24:0] Count;
always@(posedge CLK)
 begin 
   if(Count>10000000)
	  begin
	    Count<=25'b0;
		 CLK_div<=~CLK_div;
	  end
	else
		Count <=Count+1'b1;
	end
endmodule


