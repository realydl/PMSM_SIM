% FIS_YDL = newfis('FIS','FISType','mamdani','AndMethod','prod','OrMethod','probor',...
%              'ImplicationMethod','prod','AggregationMethod','sum');
% FIS_YDL = addvar(FIS_YDL,'input','E',[-1 1]);                    %声明 输入1，名称‘E’
% FIS_YDL = addmf(FIS_YDL,'input',1,'N','trimf',[-2 -1 0]); %声明隶属度函数 trimf 三角
% FIS_YDL = addmf(FIS_YDL,'input',1,'Z','trimf',[-1 0 1]);      
% FIS_YDL = addmf(FIS_YDL,'input',1,'P','trimf',[0 1 2]);
% 
% FIS_YDL = addvar(FIS_YDL,'input','CE',[-1 1]);                    %声明 输入2 EC Error微分
% FIS_YDL = addmf(FIS_YDL,'input',2,'N','trimf',[-2 -1 0]);
% FIS_YDL = addmf(FIS_YDL,'input',2,'Z','trimf',[-1 0 1]);
% FIS_YDL = addmf(FIS_YDL,'input',2,'P','trimf',[0 1 2]);
% 
% FIS_YDL = addvar(FIS_YDL,'output','u',[-20 20]);                    %输出
% FIS_YDL = addmf(FIS_YDL,'output',1,'LargeNegative','trimf',[-20 -20 -20]);
% FIS_YDL = addmf(FIS_YDL,'output',1,'SmallNegative','trimf',[-10 -10 -10]);
% FIS_YDL = addmf(FIS_YDL,'output',1,'Zero','trimf',[0 0 0]);
% FIS_YDL = addmf(FIS_YDL,'output',1,'SmallPositive','trimf',[10 10 10]);
% FIS_YDL = addmf(FIS_YDL,'output',1,'LargePositive','trimf',[20 20 20]);
% 
% ruleList = [1 1 1 1 1;   % Rule 1
%             1 2 2 1 1;   % Rule 2
%             1 3 3 1 1;   % Rule 3
%             2 1 2 1 1;   % Rule 4
%             2 2 3 1 1;   % Rule 5
%             2 3 4 1 1;   % Rule 6
%             3 1 3 1 1;   % Rule 7
%             3 2 4 1 1;   % Rule 8
%             3 3 5 1 1];  % Rule 9
% FIS_YDL = addrule(FIS_YDL,ruleList);

FIS_YDL = newfis('FIS_YDL','FISType','sugeno');

FIS_YDL = addvar(FIS_YDL,'input','E',[-1 1]);
FIS_YDL = addmf(FIS_YDL,'input',1,'Negative','gaussmf',[0.7 -1]);
FIS_YDL = addmf(FIS_YDL,'input',1,'Positive','gaussmf',[0.7 1]);

FIS_YDL = addvar(FIS_YDL,'input','CE',[-10 10]);
FIS_YDL = addmf(FIS_YDL,'input',2,'Negative','gaussmf',[0.7 -1]);
FIS_YDL = addmf(FIS_YDL,'input',2,'Positive','gaussmf',[0.7 1]);

FIS_YDL = addvar(FIS_YDL,'output','u',[20 40]);
FIS_YDL = addmf(FIS_YDL,'output',1,'Big','constant',40);
FIS_YDL = addmf(FIS_YDL,'output',1,'Mdl','constant',30);
FIS_YDL = addmf(FIS_YDL,'output',1,'Sml','constant',20);

ruleList = [1 1 1 1 1;...   % Rule 1
            1 2 2 1 1;...   % Rule 2
            2 1 2 1 1;...   % Rule 3
            2 2 1 1 1];     % Rule 4
FIS_YDL = addrule(FIS_YDL,ruleList);



