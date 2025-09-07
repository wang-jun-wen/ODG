function Pdata=ESN_predict(net, indata, Lbegin, Lend, outSize)
warning('off', 'MATLAB:nearlySingularMatrix');
%% Network parameters during training import
a = net.a;
Win = net.Win;
W = net.W;
Wout = net.Wout ;
x = net.x;
b = net.b;

Length=Lend-Lbegin+1;
Y1= zeros(outSize,Length);  
u = indata(Lbegin,:)';   
for t = 1:Length   
    x = (1-a)*x + a*tanh( Win*u + W*x+b );  
    y = Wout*x;
    Y1(:,t) = y;       
    u = y;           
end
Pdata=Y1;
end