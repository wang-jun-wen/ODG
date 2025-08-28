%% Clear Environment Variables
close all    
clear        
clc         
%% Training-Validation Phase
% Define the number of groups for training and validation phase data
data_group=10;
% Defining Parameters 
initLen=300;           %Mwashout
trainLen=5600;         %Mtraining
validationLen=1100;    %Mvalidation
inSize=3;              %Dimension of the input sequence
outSize=3;             %Dimension of the input and output sequences
lb  = [1e-6,0, 1e-6, 700,0.01,1e-9,0];                         % Optimize the lower bound of the parameter target（IS,a,SR,k,density,reg,σb）
ub  = [1, 1, 2,1000,0.05,1e-1,2];                              % Optimize the lower bound of the parameter target（IS,a,SR,k,density,reg,σb）

% MHOA Parameters（SAO)  
pop = 10;                                 % Number of Populations
Max_iteration = 150;                      % Maximum number of iterations
dim=size(lb,2);                         

%% Start Time
start_time = datetime('now'); 
fprintf('Start Time：%s\n', datestr(start_time, 'yyyy-mm-dd HH:MM:SS'));

%%  WOA Optimization
[~, Best_pos, curve]=WOA(pop, Max_iteration, lb,ub,dim,data_group);
%% Save Results
%save('C:\Users\wangjunwen\Desktop\curve\WOA_curve.mat', 'curve');
%save('C:\Users\wangjunwen\Desktop\Best_pos\WOA_pos.mat', 'Best_pos');
%% End Time 
end_time = datetime('now');
fprintf('End Time：%s\n', datestr(end_time, 'yyyy-mm-dd HH:MM:SS'));

%% Calculate and output the time spent.
elapsed_time = end_time - start_time; 
fprintf('time spent：%s\n', datestr(elapsed_time, 'HH:MM:SS')); 
%% Optimal parameters obtained
disp('Stage 1 obtained the optimal hyperparameter combination');
disp(Best_pos);
%% Drawing Curves
figure(1)
plot(1 : length(curve), curve, 'LineWidth', 1.5);

