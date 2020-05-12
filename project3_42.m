% model parameters
f_i = zeros(100,1); %firing rate estimation
for j = 1:100


    C = 1*(10^3); %pF
    GL = 50; %nS
    VL = -65; %mV
    I0 = (0.9+(j/100))*(10^3); %pA

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
    
    spkfinder = 0; % location of spk
    spkfinderf = 0; %location of last spk
    
    apcounter = 0;

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
        
        if refrac == (Tarp/dt)-1
            apcounter = apcounter + 1;
            if spkfinder == 0 
                spkfinder = t(i);
            end
            spkfinderf = t(i);
        end

    end


    if apcounter == 0
        f_i(j) = 0;
    else
        f_i(j) = apcounter/(spkfinderf-spkfinder);
    end
    
end

%plots



plot(0.9:0.01:1.899,f_i,'r-');
xlabel('Induced Current (pA)');
ylabel('Firing Rate (s^-1)');
title('f-I Curve');









    