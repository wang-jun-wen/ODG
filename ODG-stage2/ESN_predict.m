function Pdata=ESN_predict(net, indata, Lbegin, Lend, outSize)
warning('off', 'MATLAB:nearlySingularMatrix');
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
    %xpr =[x; x.^2];
    %xpr =[x; x.^2; x.^3];
    %xpr =[x; x.^2; x.^3; x.^4; x.^5];
    %y = Wout*xpr;
    y = Wout*x;
    Y1(:,t) = y;       
    % generative mode
    u = y;            
    u(2)=indata(Lbegin+t,2);
    %u = indata(Lbegin+t,:)';
end

Pdata=Y1;
end