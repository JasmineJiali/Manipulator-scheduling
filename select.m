%[ Pre(1) BufferIn(2) P1(3) P2(4) P3(5) P4(6) P5(7) P6(8) BufferOut(9) 
%Post(10) R1_Position(11) R2_Position(12) 剩余工件数(13)
% R1_time(1) R2_time(2) Pre_time(3) BufferIn_time(4) P1_time(5) 
%P2_time(6) P3_time(7) P4_time(8) P5_time(9) P6_time(10) 
%BufferOut_time(11) Post_time(12) 上一深度状态(13)]

function select(m)%参数：深度
%每一深度做一次筛选，选出时间较短状态
global state;
newstate=cell(1);
newstate{1}=state{m,1};
c = 1;
while(~isempty(state{m,c}))
    c = c + 1;
    if c >size(state(m,:))
        break;
    end
end
c = c-1;%当前深度下总状态数
for i=1:c
    if(m<=30)
        if(state{m,i}(2,1)>400||state{m,i}(2,2)>1800)
            continue;
        end
    end
    if(m<=45)
        if(state{m,i}(2,1)>2100||state{m,i}(2,2)>2200)
            continue;
        end
    end
    if (state{m,i}(2,1)>5000||state{m,i}(2,2)>5000||state{m,i}(2,10)>5000|| ...
            state{m,i}(2,11)>5000||state{m,i}(2,12)>5000)
        continue;
    end
    flag=0;
    for j=1:size(newstate,2)
        [same,b]=judge(state{m,i},newstate{j});%%
        if same==1%%当前状态相同
            flag=1;
            if b==1
                newstate{j}=state{m,i};
            end
        end
    end
    if flag==0
        newstate{j+1}=state{m,i};
    end
end
newsnum = size(newstate,2);
state(m,1:newsnum) = newstate;
t = c-newsnum;
state(m,newsnum+1:c) = cell(1,t);

end

         
function [same,b]=judge(state1,state2)
%a判断是否相同，b判断R1/R2
pos1 = state1(1,1:10);
pos2 = state2(1,1:10);
time1 = state1(2,3:12);
time2 = state2(2,3:12);
same=0;
if(isequal(pos1,pos2))
    same=1;
    if sum(time1<=time2)==10
        b=1;%1完工时间短
    elseif sum(time2<=time1)==10
        b=2;
    else
        same=0;
        b=-1;
    end
else
    b=-1;
end
end
