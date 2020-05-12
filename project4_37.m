Ts = zeros(14,1);

CVs = zeros(14,1);


FFs = zeros(14,1);

tries = 0;



for T = [0.5,1,2,5,10,20,30,40,50,60,70,80,90,100]
    
    tries = tries + 1;
    
    Ts(tries) = T;
    
  
    N = 50; %number of spike trains

    lambda = 10; %spikes/s


    range = lambda*T; %average number of spikes

    spikes = zeros(range*2,N); %times when spikes occur in each trial

    CV = zeros(N,1);



    reached = 0; %reached T?

    nspikes = zeros(N,1);

    numspikes = 0;


    for j = 1:N %N trials
        ISIs = zeros((range*2)-1,1);
        counter = 1; %count bin
        reached = 0; %reached T?
        for i = 1:(range*2)-1 % each trial goes extra far to make sure reaches 5 sec
            if reached == 0 %not at T yet
                u = rand();
                ISI = -log(u)/lambda;
                if (spikes(i,j)+ISI) < T %ISI won't push it past T
                    ISIs(i) = ISI; %next ISI
                    spikes(i+1,j) = spikes(i,j)+ISI; %next spike
                    numspikes = numspikes+1; %count spikes
                    nspikes(j) = nspikes(j) + 1;
                else
                    reached = 1; %at T
                end
            else
                spikes(i+1,j) = NaN; %NaN for values beyond T
                ISIs(i) = NaN;
            end
        end
        CV(j) = nanstd(ISIs)/nanmean(ISIs);
    end
    
    CVs(tries) = mean(CV);
    FFs(tries) = var(nspikes)/mean(nspikes);
   
    
end



subplot(2,1,1);
plot(Ts,CVs,'-k');    
xlabel('Total Time of trial(s)');
ylabel('CV');
title('CV as function of T');

subplot(2,1,2);
plot(Ts,FFs,'-r');    
xlabel('Total Time of trial(s)');
ylabel('FF');
title('FF as function of T');
















