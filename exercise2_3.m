totaltime = 20;
deltat = 0.01;
numsteps = totaltime/deltat;
p = zeros(numsteps,1); %p is protein
r = zeros(numsteps,1); %r is RNA
khalf = 0.33;
hold on
for (pi=0:0.2:1.4)
    for (ri=0:0.2:1.4)
        p(1) = pi;
        r(1) = ri;
        for (i=1:numsteps-1)
            dr_dt = (((p(i))^2)/((khalf ^ 2)+((p(i))^2))) - r(i);
            dp_dt = r(i) - p(i);
            r(i+1) = r(i) + dr_dt*deltat;
            p(i+1) = p(i) + dp_dt*deltat;
        end
    plot(p,r,'k-');
    end
end
hold off
xlabel('Protein (mM)');
ylabel('RNA (mM)');
title('Concentrations of the RNA and protein of an autoregulatory gene');
