%dx(t)/dt=e^(-x(t)) integrated over 100 x with time step 0.1s and x(0)=2.7

numsteps = 1000;
deltat = 0.1;
x = zeros(numsteps,1);
t = zeros(numsteps,1);
x(1) = 2.7;
t(1) = 0;

for (i=1:numsteps-1)
    dx_dt = exp(-x(i));
    x(i+1) = x(i) + dx_dt*deltat;
    t(i+1) = t(i) +deltat;
end

plot(t,x,'k-');
xlabel('Time');
ylabel('Value of X');
title('dx/dt = exp(-x(t)) integrated over time, using Forward Euler');