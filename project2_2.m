XcIrna = 1.2; %s^-1
XcIprot = XcIrna;
Xcrorna = 0.8; %s^-1
Xcroprot = Xcrorna;
WcI = 50; %s^-1
mucI = WcI;
Wcro = WcI;
mucro = WcI;
KcIhalf = 10; %mol/cell s^-1
Kcrohalf = KcIhalf;
hold on;
plottimes = 20;

for k = 1:plottimes
    numsteps=100000;
    time = zeros(numsteps,1);
    cIprot = zeros(numsteps,1);
    cIrna = zeros(numsteps,1);
    croprot = zeros(numsteps,1);
    crorna = zeros(numsteps,1);
    cIprot(1) = 0; %Molecule
    cIrna(1) = 50; %Molecules
    croprot(1) = 0; %Molecules
    crorna(1) = 0; %Molecules
    time(1) = 0;
    for i = 1:(numsteps-1)
        if (time(i) > 2)
            XcIprot=6.5; %6.5
        end
        v1 = WcI * cIrna(i);
        v2 = XcIprot * cIprot(i);
        v3 = mucI*(1-(((croprot(i))^2)/((Kcrohalf^2)+((croprot(i))^2))));
        v4 = XcIrna * cIrna(i);
        v5 = Wcro * crorna(i);
        v6 = Xcroprot * croprot(i);
        v7 = mucro*(1-(((cIprot(i))^2)/((KcIhalf^2)+((cIprot(i))^2))));
        v8 = Xcrorna * crorna(i);
        Rtot = v1+v2+v3+v4+v5+v6+v7+v8;
        y = rand();
        tau = -log(y)/Rtot;
        time(i+1) = time(i) + tau;
        rxn_rate = zeros(1,8);
        for j = 1:8
            if j == 1
                rxn_rate(j) = v1;
            end
            if j == 2
                rxn_rate(j) = v2;
            end
            if j == 3
                rxn_rate(j) = v3;
            end
            if j == 4
                rxn_rate(j) = v4;
            end
            if j == 5
                rxn_rate(j) = v5;
            end
            if j == 6
                rxn_rate(j) = v6;
            end
            if j == 7
                rxn_rate(j) = v7;
            end
            if j == 8
                rxn_rate(j) = v8;
            end
        end
        z = rand();
        z_mod = Rtot*z;
        next_rxn=0;
        for j = 1:8
            if z_mod < sum(rxn_rate(1:j))
                next_rxn = j;
                break;
            end
        end
        if next_rxn == 1
            cIprot(i+1)=cIprot(i)+1;
            cIrna(i+1)=cIrna(i);
            croprot(i+1)=croprot(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 2
            cIprot(i+1)=cIprot(i)-1;
            cIrna(i+1)=cIrna(i);
            croprot(i+1)=croprot(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 3
            cIrna(i+1)=cIrna(i)+1;
            cIprot(i+1)=cIprot(i);
            croprot(i+1)=croprot(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 4
            cIrna(i+1)=cIrna(i)-1;
            cIprot(i+1)=cIprot(i);
            croprot(i+1)=croprot(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 5
            croprot(i+1)=croprot(i)+1;
            cIprot(i+1)=cIprot(i);
            cIrna(i+1)=cIrna(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 6
            croprot(i+1)=croprot(i)-1;
            cIprot(i+1)=cIprot(i);
            cIrna(i+1)=cIrna(i);
            crorna(i+1)=crorna(i);
        end
        if next_rxn == 7
            crorna(i+1)=crorna(i)+1;
            cIprot(i+1)=cIprot(i);
            cIrna(i+1)=cIrna(i);
            croprot(i+1)=croprot(i);
        end
        if next_rxn == 8
            crorna(i+1)=crorna(i)-1;
            cIprot(i+1)=cIprot(i);
            cIrna(i+1)=cIrna(i);
            croprot(i+1)=croprot(i);
        end
    end
    stairs(time,cIprot,'b-'); 
    stairs(time,cIrna,'r-');
    stairs(time,croprot,'k-');
    stairs(time,crorna,'g-');
end
hold off;
legend({'cIprot','cIrna','croprot','crorna'},'location','northwest');
xlabel('Time (s)');
ylabel('Concentration');
title('Concentrations of cro and cI protein and RNA');




