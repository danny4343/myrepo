%model parameters

C = 1*(10^3); %pF
GL = 50; %nS
VL = -65; %mV
I0 = 1.1*(10^3); %pA

Vspk = -45; %mV

tmax = 400; %ms
dt = 0.1; %ms timestep
numsteps = tmax/dt;
Tarp = 2; %ms

t = zeros(numsteps,1); %time array
V = zeros(numsteps,1); %membrane potential
Iec = zeros(numsteps,1); %induced current

%initial conditions

V(1) = VL;
refrac = 0; %refractory period on/off

%simulation

tic

for i = 1:numsteps
    
    if t(i) < 50
        Ie=0;
    else
        Ie=I0;
    end
    
    if V(i)>=Vspk
        refrac = Tarp/dt;
        
    end
    
    if refrac > 0
        
        V(i+1)=-65;
        t(i+1)=t(i)+dt;
        refrac = refrac - 1;
        
    else

        dv_dt = ((-1*GL*(V(i)-VL)) + Ie)/C;
        

        V(i+1) = V(i) + dv_dt*dt; %update V


        t(i+1)=t(i)+dt; % time forward
    
    end
    
    Iec(i+1)=Ie;
    
end

toc

subplot(2,1,1); %potential vs time
plot(t,V,'b-'); 
xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Membrane Potential vs Time');


subplot(2,1,2); %current vs time
plot(t,Iec,'r-'); 
xlabel('Time (ms)');
ylabel('Current (mV)');
title('Induced Current vs Time');















