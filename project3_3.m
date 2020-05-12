% model parameters

GNa = 400; % nS
GK = 200; % nS
GL = 2; % nS
ENa = 99; % mV
EK = -85; % mV
VL = -65; % mV
C = 2; %pF
I0 = 109; %pA

tmax = 400; %ms
dt = 0.01; %ms timestep
numsteps = tmax/dt;

t = zeros(numsteps,1); %time array
V = zeros(numsteps,1); %membrane potential
Im = zeros(numsteps,1); %membrane current
m = zeros(numsteps,1); %Na activating subunit
h = zeros(numsteps,1); %Na deactivating subunit
n = zeros(numsteps,1); %K activating
NaC = zeros(numsteps,1); %sodium conductance
KC = zeros(numsteps,1); %potassium conductance
Iec = zeros(numsteps,1); %induced current

%inital conditions

V(1) = VL;

ami = (0.1*(V(1)+40))/(1-exp(-0.1*(V(1)+40))); % initial am
Bmi = 4*exp(-0.0556*(V(1)+65)); % initial Bm
ahi = 0.07*exp(-0.05*(V(1)+65)); % inital ah
Bhi = 1/(1+exp(-0.1*(V(1)+35))); % inital Bh
ani = (0.01*(V(1)+55))/(1-exp(-0.1*(V(1)+55))); % initial an
Bni = 0.125*exp(-0.0125*(V(1)+65)); % initial Bn

minf = ami/(ami+Bmi);
hinf = ahi/(ahi+Bhi);
ninf = ani/(ani+Bni);

m(1) = minf;
h(1) = hinf;
n(1) = ninf;

spkfinder = 0; % location of spk

apcounter = 0; %number of action potentials
Vspk = -10; %mV critical value

% simulation
tic
for i = 1:numsteps
    if t(i) < 40
        Ie=0;
    else
        Ie=I0;
    end
    
    am = (0.1*(V(i)+40))/(1-exp(-0.1*(V(i)+40))); % update am
    Bm = 4*exp(-0.0556*(V(i)+65)); % update Bm
    ah = 0.07*exp(-0.05*(V(i)+65)); % update ah
    Bh = 1/(1+exp(-0.1*(V(i)+35))); % update Bh
    an = (0.01*(V(i)+55))/(1-exp(-0.1*(V(i)+55))); % update an
    Bn = 0.125*exp(-0.0125*(V(i)+65)); % update Bn
    
    dm_dt = (am*(1-m(i)))-(Bm*m(i));
    dh_dt = (ah*(1-h(i)))-(Bh*h(i));
    dn_dt = (an*(1-n(i)))-(Bn*n(i));
    
    m(i+1) = m(i) + dm_dt*dt; %update m
    h(i+1) = h(i) + dh_dt*dt; %update h
    n(i+1) = n(i) + dn_dt*dt; %update n
    
    dV_dt = ((-1*GL*(V(i)-VL))-(GNa*(m(i)^3)*h(i)*(V(i)-ENa))-(GK*(n(i)^4)*(V(i)-EK))+Ie)/C;    
    V(i+1) = V(i) + dV_dt*dt; %update V
    
    Im(i+1) = (GL*(V(i)-VL))+(GNa*(m(i)^3)*h(i)*(V(i)-ENa))+(GK*(n(i)^4)*(V(i)-EK)); %update Im
    NaC(i+1) = GNa*(m(i)^3)*h(i);
    KC(i+1) = GK*(n(i)^4);
    Iec(i+1) = Ie;
    
    if V(i)<=Vspk && V(i+1)>Vspk
        apcounter = apcounter + 1;
        if spkfinder == 0 
            spkfinder = t(i);
        end
    end
    
    t(i+1)=t(i)+dt; % time forward
end
toc
%plots

xlimi=1;
xlimf=tmax;

figure(1);

subplot(5,1,1); %potential vs time
hold on
plot(t,V,'b-'); 
%plot(spkfinder,Vspk,'r*');
hold off
xlabel('Time (ms)');
ylabel('Membrane Potential (mV)');
title('Membrane Potential vs Time');
xlim([xlimi,xlimf]);

subplot(5,1,2); %current vs time
plot(t,Im,'r-');
xlabel('Time (ms)');
ylabel('Membrane Current (pA)');
title('Membrane Current vs Time');
xlim([xlimi,xlimf]);

subplot(5,1,3); %Na conductance vs time
plot(t,NaC,'g-');
xlabel('Time (ms)');
ylabel('Sodium Conductance (pF)');
title('Sodium Conductance vs Time');
xlim([xlimi,xlimf]);

subplot(5,1,4); %K conductance vs time
plot(t,KC,'b-');
xlabel('Time (ms)');
ylabel('Potassium Conductance (pF)');
title('Potassium Conductance vs Time');
xlim([xlimi,xlimf]);

subplot(5,1,5); %Ie vs time
plot(t,Iec,'r-');
xlabel('Time (ms)');
ylabel('Induced Current (pA)');
title('Induced Current vs Time');
xlim([xlimi,xlimf]);
