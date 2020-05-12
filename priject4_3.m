N = 50; %number of spike trains

lambda = 10; %spikes/s
T = 5; %s length of train

range = lambda*T; %average number of spikes

spikes = zeros(range*2,N); %times when spikes occur in each trial
PSTH = zeros((range/2),1);
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
                if counter * 0.2 > (spikes(i,j)+ISI) %this bin?
                    PSTH(counter) = PSTH(counter) + 1; %spike in bin
                else
                    if counter ~= 5*T %not at T
                        counter = counter + 1; %next bin
                        PSTH(counter) = PSTH(counter) + 1; %spike
                    end
                end
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

for k = 1:range/2
    PSTH(k) = PSTH(k)/(N*0.2);
end


figure(1);
plot(spikes,1:N,'.k');    
xlabel('Time (s)');
ylabel('Trial Number');
title('Raster Plot');

figure(2);
plot(1:range/2,PSTH,'-r');    
xlabel('bin');
ylabel('Number of Spikes');
title('PSTH Plot');

figure(3);
plot(1:N,CV,'-b');    
xlabel('Trial Number');
ylabel('coefficient of variability');
title('CV Plot');


firerate = numspikes/(N*T)

avgCV = mean(CV)

FF = var(nspikes)/mean(nspikes)


















    