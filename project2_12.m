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

timestep = 0.01; %s
time = 15; %s
numsteps = time/timestep; 
t = zeros(numsteps,1);
cIprot = zeros(numsteps,1);
cIrna = zeros(numsteps,1);
croprot = zeros(numsteps,1);
crorna = zeros(numsteps,1);
cIprot(1) = 0; %Molecule
croprot(1) = 0; %Molecules
hold on;
for (cIrnai = 0:500:2000)
    for (crornai = 0:500:2000)
        cIrna(1) = cIrnai;
        crorna(1) = crornai;
        for (i = (1:numsteps-1))
            dcIprot_dt = (WcI * cIrna(i)) - (XcIprot * cIprot(i));
            dcIrna_dt = (mucI * (1 - (((croprot(i))^2)/((Kcrohalf^2)+((croprot(i))^2)))))-(XcIrna*cIrna(i));
            dcroprot_dt = (Wcro*crorna(i))-(Xcroprot*croprot(i));
            dcrorna_dt = (mucro * (1 - (((cIprot(i))^2)/((KcIhalf^2)+((cIprot(i))^2)))))-(Xcrorna*crorna(i));
            cIprot(i+1) = cIprot(i) + dcIprot_dt*timestep;
            cIrna(i+1) = cIrna(i) + dcIrna_dt*timestep;
            croprot(i+1) = croprot(i) + dcroprot_dt*timestep;
            crorna(i+1) = crorna(i) + dcrorna_dt*timestep;
            t(i+1) = t(i) + timestep;
        end
        plot(cIprot,croprot,'b-');
        plot(cIprot(numsteps),croprot(numsteps),'go')
    end
end

hold off;
xlabel('cIprot');
ylabel('croprot');
title('Concentrations of the cI protein vs the cro protein');







