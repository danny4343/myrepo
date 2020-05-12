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
time = 60; %s do 60 for part 4
numsteps = time/timestep; 
t = zeros(numsteps,1);
cIprot = zeros(numsteps,1);
cIrna = zeros(numsteps,1);
croprot = zeros(numsteps,1);
crorna = zeros(numsteps,1);
cIprot(1) = 0; %Molecule
cIrna(1) = 50; %Molecules
croprot(1) = 0; %Molecules
crorna(1) = 0; %Molecules

for i = (1:numsteps-1)
    if (t(i) > 15)
        XcIprot=6.5; %6.5
    end
    dcIprot_dt = (WcI * cIrna(i)) - (XcIprot * cIprot(i));
    dcIrna_dt = (mucI * (1 - (((croprot(i))^2)/((Kcrohalf^2)+((croprot(i))^2))))-(XcIrna*cIrna(i)));
    dcroprot_dt = (Wcro*crorna(i))-(Xcroprot*croprot(i));
    dcrorna_dt = (mucro * (1 - (((cIprot(i))^2)/((KcIhalf^2)+((cIprot(i))^2))))-(Xcrorna*crorna(i)));
    cIprot(i+1) = cIprot(i) + dcIprot_dt*timestep;
    cIrna(i+1) = cIrna(i) + dcIrna_dt*timestep;
    croprot(i+1) = croprot(i) + dcroprot_dt*timestep;
    crorna(i+1) = crorna(i) + dcrorna_dt*timestep;
    t(i+1) = t(i) + timestep;
end

hold on;
plot(t,cIprot,'b-'); 
plot(t,cIrna,'r-');
plot(t,croprot,'k-');
plot(t,crorna,'g-');
hold off;
legend({'cIprot','cIrna','croprot','crorna'},'location','northwest');
xlabel('Time (s)');
ylabel('Number of Molecules');
title('Concentrations of the RNA and protein of cro and cI');







