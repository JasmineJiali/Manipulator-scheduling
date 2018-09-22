function state_initial(m)
global state;
global flag;
%[ Pre(1) BufferIn(2) P1(3) P2(4) P3(5) P4(6) P5(7) P6(8) BufferOut(9)
%Post(10) R1_Position(11) R2_Position(12) 剩余C数(13) 剩余D数（14）
% R1_time(1) R2_time(2) Pre_time(3) BufferIn_time(4) P1_time(5) P2_time(6)
%P3_time(7) P4_time(8) P5_time(9) P6_time(10) BufferOut_time(11) Post_time(12) 上一深度状态(13)]
Pre = 60;Post = 100;
P1 = 180;P2 = 300;P3 = 360;P4 = 390;P5 = 200;P6 = 330;
lastnum = 1;
while(~isempty(state{m-1,lastnum}))
    lastnum = lastnum + 1;
    if lastnum >size(state(m-1,:))
        break;
    end
end
lastnum = lastnum-1;
curnum = 1;
for i = 1:lastnum
    for sub = 0:10
        if (sub == 0 && state{m-1,i}(1,1) == 0 && state{m-1,i}(1,13)~=0 && state{m-1,i}(1,14)~=0)%In->Pre
            if flag ==1
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,1) = 1;%%放入一片C
            
            state{m,curnum}(1,13) = state{m-1,i}(1,13)-1;
            state{m,curnum}(1,11) = 1;
            state{m,curnum}(1,12) = state{m-1,i}(1,12);
            
            state{m,curnum}(2,1) = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(11),0)+3;
            state{m,curnum}(2,2) = state{m-1,i}(2,2);
            state{m,curnum}(2,3) = state{m,curnum}(2,1) + Pre;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum +1;
            flag =2;
            end
            
            if flag ==2
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,1) = 2;%放入一片D
            
            state{m,curnum}(1,14) = state{m-1,i}(1,14)-1;
            state{m,curnum}(1,11) = 1;
            
            state{m,curnum}(2,1) = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(11),0)+3;
            state{m,curnum}(2,2) = state{m-1,i}(2,2);
            state{m,curnum}(2,3) = state{m,curnum}(2,1) + Pre;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum +1;
            flag = 1;
            end
        elseif (sub == 0 && state{m-1,i}(1,1) == 0 && state{m-1,i}(1,13)~=0 && state{m-1,i}(1,14)==0)%In->Pre
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,1) = 1;%%放入一片C
            
            state{m,curnum}(1,13) = state{m-1,i}(1,13)-1;
            state{m,curnum}(1,11) = 1;
            
            state{m,curnum}(2,1) = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(11),0)+3;
            state{m,curnum}(2,3) = state{m,curnum}(2,1) + Pre;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum +1;
            flag = 2;
            
%         elseif (sub == 0 && state{m-1,i}(1,1) == 0 && state{m-1,i}(1,13)==0 && state{m-1,i}(1,14)~=0)%In->Pre
%             state{m,curnum} = state{m-1,i};
%             state{m,curnum}(1,1) = 2;%%放入一片D
%             
%             state{m,curnum}(1,14) = state{m-1,i}(1,14)-1;
%             state{m,curnum}(1,11) = 1;
%             
%             state{m,curnum}(2,1) = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(11),0)+3;
%             state{m,curnum}(2,3) = state{m,curnum}(2,1) + Pre;
%             state{m,curnum}(2,13) = i;
%             
%             curnum = curnum +1;
%             flag = 1;
           
        elseif (sub == 1 && state{m-1,i}(1,1) ~=0 && state{m-1,i}(1,2) ==0 && state{m-1,i}(1,9) == 0 &&  sum(state{m-1,i}(1,3:8)~=0)~=6 )%Pre->BufferIn
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,1) = 0;
            state{m,curnum}(1,2) = state{m-1,i}(1,1);
            
            state{m,curnum}(1,11) = 2;
            
            time1 = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(1,11),1) + 3;
            time2 = state{m-1,i}(2,3) + 3;
            state{m,curnum}(2,1) = max(time1,time2);
            state{m,curnum}(2,3) = state{m,curnum}(2,1) - 3;
            state{m,curnum}(2,4) = state{m,curnum}(2,1);
            state{m,curnum}(2,11) = state{m,curnum}(2,4);
            state{m,curnum}(2,13) = i;
            
            curnum = curnum +1;
        elseif ( sub == 2 && state{m-1,i}(1,2) ~=0 && state{m-1,i}(1,3) == 0)%BufferIn->P1
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,2) = 0;
            state{m,curnum}(1,3) = state{m-1,i}(1,2);
            
            state{m,curnum}(1,12) = 1;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),0) + 3;
            time2 = state{m-1,i}(2,4) + 3; 
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,4) = state{m,curnum}(2,2)-3;
            state{m,curnum}(2,5) = state{m,curnum}(2,2)+P1;
            state{m,curnum}(2,11) = state{m,curnum}(2,4)+1;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 3 && state{m-1,i}(1,3) == 2 && state{m-1,i}(1,4) == 0) %P1 ->P2  D
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,3) = 0;
            state{m,curnum}(1,4) = 2;
            
            state{m,curnum}(1,12) = 2;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),1) +3;
            time2 = state{m-1,i}(2,5) + 3;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,5) = state{m,curnum}(2,2) - 3;
            state{m,curnum}(2,6) = state{m,curnum}(2,2) + P2;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum +1;
        elseif ( sub == 3 && state{m-1,i}(1,3) == 1 && state{m-1,i}(1,5) == 0)%P1->P3  C
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,3) = 0;
            state{m,curnum}(1,5) = 1;
            
            state{m,curnum}(1,12) = 3;
            
            state{m,curnum}(2,1) = state{m-1,i}(2,1);
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),1) + 4;
            time2 = state{m-1,i}(2,5) + 4;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,5) = state{m,curnum}(2,2) - 4;
            state{m,curnum}(2,7) = state{m,curnum}(2,2) + P3;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 4 && state{m-1,i}(1,4) == 2 && state{m-1,i}(1,6) == 0)%P2->P4  D
            state{m, curnum} = state{m-1,i};
            state{m,curnum}(1,4) = 0;
            state{m,curnum}(1,6) = 2;
            
            state{m,curnum}(1,12) = 4;
         
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),2) + 4;
            time2 = state{m-1,i}(2,6) + 4;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,6) = state{m,curnum}(2,2) - 4;
            state{m,curnum}(2,8) = state{m,curnum}(2,2) + P4;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 5 && state{m-1,i}(1,5) == 1 && state{m-1,i}(1,7) == 0)%P3 ->P5 C
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[5 7]) = [0 1];
           
            state{m,curnum}(1,12) = 5;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),3) + 4;
            time2 = state{m-1,i}(2,7) + 4;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,7) = state{m,curnum}(2,2) - 4;
            state{m,curnum}(2,9) = state{m,curnum}(2,2) + P5;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 6 && state{m-1,i}(1,6) == 2 && state{m-1,i}(1,7) == 0)%P4->P5 D
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[6 7]) = [0 2];
           
            state{m,curnum}(1,12) = 5;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),4) + 3;
            time2 = state{m-1,i}(2,8) + 3;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,8) = state{m,curnum}(2,2) - 3;
            state{m,curnum}(2,9) = state{m,curnum}(2,2) + P5;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 7 && state{m-1,i}(1,7) == 1 && state{m-1,i}(1,8) == 0)%P5->P6  C
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[7 8]) = [0 1];
           
            state{m,curnum}(1,12) = 6;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),5) + 3;
            time2 = state{m-1,i}(2,9) + 3;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,9) = state{m,curnum}(2,2) - 3;
            state{m,curnum}(2,10) = state{m,curnum}(2,2) + P6;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 7 && state{m-1,i}(1,7) == 2 && state{m-1,i}(1,9) == 0 && state{m-1,i}(1,2) == 0)%P5->BufferOut D
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[7 9]) = [0 2];
        
            state{m,curnum}(1,12) = 0;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),5) + 4;
            time2 = state{m-1,i}(2,9) + 4;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,9) = state{m,curnum}(2,2) - 4;
            state{m,curnum}(2,11) = state{m,curnum}(2,2) ;
            state{m,curnum}(2,4) = state{m,curnum}(2,11);
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
            
        elseif (sub == 8 && state{m-1,i}(1,8) == 1 && state{m-1,i}(1,9) == 0 && state{m-1,i}(1,2) == 0)%P6->BufferOut  C
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[8 9]) = [0 1];
           
            state{m,curnum}(1,12) = 0;
            
            time1 = state{m-1,i}(2,2) + rotate(2,state{m-1,i}(1,12),6) + 3;
            time2 = state{m-1,i}(2,10) + 3;
            state{m,curnum}(2,2) = max(time1,time2);
            state{m,curnum}(2,10) = state{m,curnum}(2,2) - 3;
            state{m,curnum}(2,11) = state{m,curnum}(2,2) ;
            state{m,curnum}(2,4) = state{m,curnum}(2,11);
            state{m,curnum}(2,13) = i;
            
            curnum = curnum+1;
        elseif (sub == 9 && state{m-1,i}(1,9) ~= 0 && state{m-1,i}(1,10) == 0)%BufferOut -> Post
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,[9 10]) = [0 state{m-1,i}(1,9)];
            
            state{m,curnum}(1,11) = 3;
            
            time1 = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(1,11),2)+3;
            time2 = state{m-1,i}(2,11) + 3;
            state{m,curnum}(2,1) = max(time1,time2);
            state{m,curnum}(2,11) = state{m,curnum}(2,1)-3;
            state{m,curnum}(2,12) = state{m,curnum}(2,1) + Post;
            state{m,curnum}(2,13) = i;
            
            curnum = curnum + 1;
        elseif (sub == 10 && state{m-1,i}(1,10) ~= 0)%Post -> Out
            state{m,curnum} = state{m-1,i};
            state{m,curnum}(1,10) = 0;
            state{m,curnum}(1,11) = 0;
            
            time1 = state{m-1,i}(2,1) + rotate(1,state{m-1,i}(1,11),3) +3;
            time2 = state{m-1,i}(2,12) + 3;
            state{m,curnum}(2,1) = max(time1,time2);
            state{m,curnum}(2,12) = state{m,curnum}(2,1)-3;
            state{m,curnum}(2,13) =i;
            curnum = curnum+1;
        end
    end
end
end
    
           
            
         
            
            
            
            
       
            
            
            
            
            
            
            

