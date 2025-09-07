clc;
initLen=400;          
trainLen=12400;         
testLen=3000;
inSize=3;              
outSize=3;             
load('C:\Users\GWO_pos.mat', 'Best_pos');
%% Optimal Hyperparameter Combination
IS=Best_pos(1,1);         
a=Best_pos(1,2);           
SR=Best_pos(1,3);          
resSize=Best_pos(1,4);     
resSize= round(resSize);   
density=Best_pos(1,5);     
reg=Best_pos(1,6);         
b=Best_pos(1,7);          
W=sprand(resSize, resSize, density);              
Win = (rand(resSize,inSize) * 2 - 1) * IS;  

%% Import test data
load('C:\Users\Rosser_train&test_data', 'Mtraining', 'Mtest');
indata = [Mtraining; Mtest];   
outdata = [Mtraining; Mtest];  
sigma  = std(indata);          

net=ESN_train(indata, outdata, initLen, trainLen,reg,a,SR,b,resSize,W,Win);

Pdata= ESN_predict(net, indata, trainLen, trainLen+testLen-1, outSize);  
Pdata=Pdata';

%% Plot the NRMSE of the test set
Amax=0.87;      
dt=0.02;
time=(0:testLen-1)*dt*Amax;
k=time';
temp=outdata(trainLen+1:trainLen+testLen,:)-Pdata;
temp=temp./sigma;
%%
OGD_GWO_nrmse_1= sqrt(sum(temp.^2,2)./outSize);
true_x=outdata(trainLen+1:trainLen+testLen, 1);
true_y=outdata(trainLen+1:trainLen+testLen, 2);
true_z=outdata(trainLen+1:trainLen+testLen, 3);

OGD_GWO_1_x=Pdata(:, 1);
OGD_GWO_1_y=Pdata(:, 2);
OGD_GWO_1_z=Pdata(:, 3);

%%
figure(1)
plot(time,OGD_GWO_nrmse_1,'b','linewidth',2);
figure;
subplot(3, 1, 1);  
plot(time, outdata(trainLen+1:trainLen+testLen, 1), 'linewidth', 2);   
hold on;
plot(time, Pdata(:, 1), '--', 'linewidth', 2);   
hold off;
axis tight;

% Subplot for y component
subplot(3, 1, 2);  
plot(time, outdata(trainLen+1:trainLen+testLen, 2), 'linewidth', 2);
hold on;
plot(time, Pdata(:, 2), '--', 'linewidth', 2);
hold off;
axis tight;

% Subplot for z component
subplot(3, 1, 3);  
plot(time, outdata(trainLen+1:trainLen+testLen, 3), 'linewidth', 2);  
hold on;
plot(time, Pdata(:, 3), '--', 'linewidth', 2);    
hold off;
axis tight;
