eta = 0.1; %learning rate
T = 1000; %iterations

perf = zeros(T,1); %performance plot

w=[0,0,0];

%
%and
for i=1:T
    
    x=[sign(rand()-0.5),sign(rand()-0.5),-1]; %x has random +-1
    if x(1) == 1 && x(2) == 1 %find expected output 
        yt = 1;
    else
        yt = -1;
    end
    y=sign(sum(w.*x)); %actual output
    deltaw1 = eta*(yt-y)*x(1);
    deltaw2 = eta*(yt-y)*x(2);
    deltaw3 = eta*(yt-y)*x(3);
    w(1) = w(1)+deltaw1;
    w(2) = w(2)+deltaw2;
    w(3) = w(3)+deltaw3;
    if y == yt
        perf(i) = 1;
    end
    
end
%}



%or
%{
for i=1:T
    
    x=[sign(rand()-0.5),sign(rand()-0.5),-1]; %x has random +-1
    if x(1) == 1 || x(2) == 1 %find expected output 
        yt = 1;
    else
        yt = -1;
    end
    y=sign(sum(w.*x)); %actual output
    deltaw1 = eta*(yt-y)*x(1);
    deltaw2 = eta*(yt-y)*x(2);
    deltaw3 = eta*(yt-y)*x(3);
    w(1) = w(1)+deltaw1;
    w(2) = w(2)+deltaw2;
    w(3) = w(3)+deltaw3;
    if y == yt
        perf(i) = 1;
    end
    
end
%}

%xor
%{
for i=1:T
    
    x=[sign(rand()-0.5),sign(rand()-0.5),-1]; %x has random +-1
    if (x(1) == 1 && x(2) == -1)  || (x(2) == 1 && x(1) == -1) %find expected output 
        yt = 1;
    else
        yt = -1;
    end
    y=sign(sum(w.*x)); %actual output
    deltaw1 = eta*(yt-y)*x(1);
    deltaw2 = eta*(yt-y)*x(2);
    deltaw3 = eta*(yt-y)*x(3);
    w(1) = w(1)+deltaw1;
    w(2) = w(2)+deltaw2;
    w(3) = w(3)+deltaw3;
    if y == yt
        perf(i) = 1;
    end
    
end
%}


plot(1:T,perf,'.k');    
xlabel('Trial Number');
ylabel('Performance');
title('Performance plot for XOR');
ylim([-0.2 1.2]);




