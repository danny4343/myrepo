
runs = 50;
conv = 0; %convegrgence in each
conved = 0; %total convergence
wout = 0; %total that did not converge

for m = 1:runs


    M = 40; %vectors
    N = 50; %elements per vector

    X=sign(randi(2,M,N)-1.5); %random vectors with +-1 values

    r=randperm(M); 
    r=r(1:(M/2)); %the half of the vectors that are right

    eta = 0.1; %learning rate
    T = 4000; %iterations

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
        else
            conv = 0;
        end
        
        conv = conv + 1;
        
        if conv == 200
            conved = conved + i - 200;
        end
        
        if i == T
            if conv < 200
                wout = wout + 1;
            end
        end

    end

    
    
end   
    
    
    
(conved/runs)/M    
wout

    
    
    

