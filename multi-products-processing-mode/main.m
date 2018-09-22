global state;
global flag;
flag = 2;
state = cell(73,1);
state{1,1} = [0,0,0,0,0,0,0,0,0,0,0,0,4,4;
      0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  depth = 2;
  while(depth<=73)
      depth
      state_initial(depth);
      select(depth);
      depth = depth +1;
  end
disp('程序运行完成，完工时间：');
state{depth-1,2}(2,1)

    

% t = cell(73,1);
% t{73,1} = state{73,5};
% for i = 72:-1:1
%     t{i,1} = state{i,t{i+1,1}(2,13)};
% end
% 
% for i = 1:73
%     i
%     t{i,1}(2,1)
%     t{i,1}(2,2)
% end


global from;
global to;
global time;
global R;
global piece;

from=cell(depth-2,1);
to=cell(depth-2,1);
time=cell(depth-2,1);
R=cell(depth-2,1);
piece=cell(depth-2,1);
track(depth);
