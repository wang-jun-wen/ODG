function objValue = getfitness(indata,outdata,Best_pos)

initLen=300;          
trainLen=5600;         
validationLen=1100;    
inSize=3;              
outSize=3;             
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
net=ESN_train(indata, outdata, initLen, trainLen,reg,a,SR,b,resSize,W,Win);

Pdata= ESN_predict(net, indata, trainLen, trainLen+validationLen-1, outSize);

accuracy = sum(sum(abs(outdata(trainLen+1:trainLen+validationLen,:) - Pdata'))) /(outSize * validationLen);
objValue = accuracy;
end




