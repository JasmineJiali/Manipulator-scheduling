%[ Pre(1) BufferIn(2) P1(3) P2(4) P3(5) P4(6) P5(7) P6(8) BufferOut(9)
%Post(10) R1_Position(11) R2_Position(12) 剩余C数(13) 剩余D数（14）
% R1_time(1) R2_time(2) Pre_time(3) BufferIn_time(4) P1_time(5) P2_time(6)
%P3_time(7) P4_time(8) P5_time(9) P6_time(10) BufferOut_time(11) Post_time(12) 上一深度状态(13)]

function track(depth)
global state;
global from;
global to;
global time;
global R;
global piece;
%分别用于储存出发位置，到达位置，动作时刻，R1/R2动作

state_next=zeros(1,10);
state_pre=zeros(1,10);

m=depth-1;
for m=depth-1:-1:2
    if m==depth-1 %最开始选第一个状态
        state_next=state{m,2}(1,1:10);%当前状态变量
        num=state{m,2}(2,13);%父节点
        state_pre=state{m-1,num}(1,1:10);%前一状态变量
        R{m-1,1}=get_r(m,1,num);
        if(R{m-1,1}==1)
            time{m-1,1}=state{m,2}(2,1);
        elseif(R{m-1,1}==2)
            time{m-1,1}=state{m,2}(2,2);
        end
           
    else
        state_next=state{m,num}(1,1:10);%当前状态变量
        num1=state{m,num}(2,13);%父节点
        R{m-1,1}=get_r(m,num,num1);
        if(R{m-1,1}==1)
            time{m-1,1}=state{m,num}(2,1);
        elseif(R{m-1,1}==2)
            time{m-1,1}=state{m,num}(2,2);
        end
        num=num1;
        state_pre=state{m-1,num}(1,1:10);%前一状态变量    

    end
    
    a=state_next(1:10);
    b=state_pre(1:10);
    value=a(1:10)-b(1:10);
    
    ffrom=find(value==-1);
    tto=find(value==1);
    ffrom2=find(value==-2);
    tto2=find(value==2);
    statenum={'pre','buffer','P1','P2','P3','P4','P5','P6','buffer','post'};
    if(isempty(ffrom)&&isempty(ffrom2))
        from{m-1,1}='In';
        to{m-1,1}='pre';
        if(value(1)==1)
            piece{m-1,1}='C';
        else
            piece{m-1,1}='D';
        end
    elseif(isempty(tto)&&isempty(tto2))
        from{m-1,1}='Post';
        to{m-1,1}='Out';
        if(value(10)==-1)
            piece{m-1,1}='C';
        else
            piece{m-1,1}='D';
        end
    else
        if(isempty(ffrom))
            from{m-1,1}=statenum(ffrom2);
            piece{m-1,1}='D';
        else
            from{m-1,1}=statenum(ffrom);
            piece{m-1,1}='C';
        end
        if(isempty(tto))
            to{m-1,1}=statenum(tto2);
            piece{m-1,1}='D';
        else
            to{m-1,1}=statenum(tto);
            piece{m-1,1}='C';
        end
        
    end
end
end


function r=get_r(m,num1,num2)%计算R1/R2动作
%num2表示前一深度的状态标号
global state;
r1=state{m,num1}(1,11);
pos_r1=state{m-1,num2}(1,11);
if(r1~=pos_r1)
    r=1;
else
    r=2;
end

end
