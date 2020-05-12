M = 40; %vectors
N = 50; %elements per vector

X=sign(randi(2,M,N)-1.5); %random vectors with +-1 values

r=randperm(M); 
r=r(1:(M/2)); %the half of the vectors that are right

eta = 0.1; %learning rate
T = 1000; %iterations

perf = zeros(T,1); %performance plot

w=zeros(1,N); %each vector element gets a weight




for i=1:T
    yt = -1;
    u=randi(M); %check random vector
    checking = X(u,:);
    for j = 1:(M/2)
        if checking == X(r(j),:); %check vector against right vectors
            yt = 1;
        end
    end
        

    y=sign(sum((w.*(X(u,:))))); %actual output

    for k = 1:N
        w(k) = w(k) + ( eta*(yt-y)*(X(u,k)) ); %update w
    end
        

    if y == yt
        perf(i) = 1;
    end
    
end

plot(1:T,perf,'.k');    
xlabel('Trial Number');
ylabel('Performance');
title('Performance plot');
ylim([-0.2 1.2]);











