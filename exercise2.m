totaltime = 20;
deltat = 0.01;
numsteps = totaltime/deltat;
p = zeros(numsteps,1); %p is protein
r = zeros(numsteps,1); %r is RNA
t = zeros(numsteps,1); %t is time
p(1) = 0.5;
r(1) = 0;
t(1) = 0;
khalf = 0.33;

for (i=1:numsteps-1)
    dr_dt = (((p(i))^2)/((khalf ^ 2)+((p(i))^2))) - r(i);
    dp_dt = r(i) - p(i);
    r(i+1) = r(i) + dr_dt*deltat;
    p(i+1) = p(i) + dp_dt*deltat;
    t(i+1) = t(i) +deltat;
end

plot(t,p,'k-');
hold on;
plot(t,r,'r-');
hold off;
legend({'protein','RNA'},'location','northwest');
xlabel('Time (s)');
ylabel('Concentration (mM)');
title('Concentrations of the RNA and protein of an autoregulatory gene');