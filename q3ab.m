% program for question a and b
clear;
load hw1xtr.dat;
load hw1ytr.dat;
load hw1xte.dat;
load hw1yte.dat;

x = hw1xtr(:,1);
y = hw1ytr(:,1);
xt = hw1xte(:,1);
yt = hw1yte(:,1);
lambda = [0.01,0.1,1,10,100,1000];
sizel = numel(lambda);
n = numel(x);
nt = numel(xt);
ii = zeros(5,5);
x1 = [x.^4 x.^3 x.^2 x ones(n,1)];

for i = 2:5
    ii(i,i) = 1;
end

errtr = [];
errte = [];
wg = [];

for i =1 :sizel
    err1 = 0; 
    err2 = 0;
    w =inv(x1'*x1+lambda(i)*ii) * x1' *y ;
    wg = [wg w];
    syms t
    f = @(t) w(1)*t.^4+w(2)*t.^3+w(3)*t.^2+w(4)*t+w(5);
    for i = 1:n
        err1 = err1+(f(x(i))-y(i))^2;
    end
    err1 = err1/n;
    errtr = [errtr err1];
    for i = 1:nt
        err2 = err2+(f(xt(i))-yt(i))^2;
    end
    err2 = err2/nt;
    errte = [errte err2];
end
figure
lambda = log10(lambda);
plot(lambda, errtr, 'b-o')
hold on
plot(lambda, errte, 'r-o')

figure
for i = 1:5
    plot(lambda, wg(i, :));
    labels{i} = strcat('w', num2str(i));
    hold on
end
legend(labels)
