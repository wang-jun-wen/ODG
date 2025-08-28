function net=ESN_train(indata, outdata, initLen, trainLen,reg,a,SR,b,resSize,W,Win)
warning('off', 'MATLAB:nearlySingularMatrix');
opt.disp = 0;
rhoW = abs(eigs(W,1,'LM',opt)); 
W = W .* (SR/rhoW); 
b=b*ones(resSize,1);
X = zeros(resSize,trainLen-initLen);    
Yt = outdata(initLen+2:trainLen+1,:)';         
x = zeros(resSize,1);    
for t = 1:trainLen       
    u = indata(t,:)';   
    x = (1-a)*x + a*tanh( Win*u + W*x+b ); 
    if t > initLen       
        X(:,t-initLen) = x;   
    end
end
%Xpr = [X; X.^2];
%Xpr = [X; X.^2; X.^3];
%Xpr = [X; X.^2; X.^3; X.^4; X.^5];
X_T = X';
%Xpr_T = Xpr';
Wout = Yt*X_T / (X*X_T + reg*eye(resSize));
%Wout = Yt * Xpr_T * pinv(Xpr * Xpr_T + reg * eye(5*resSize));
%Wout = Yt*Xpr_T / (Xpr*Xpr_T + reg*eye(5*resSize));

net.a = a;
net.Win = Win;
net.W = W;
net.Wout = Wout;
net.x  =  x;
net.b  =  b;
end