%1
Vmax = 5;
Khalf = 20;
conc = 0:1:100;
for i=1:length(conc)
    v1(i) = (Vmax * (conc(i) ^ 1)) / ((Khalf ^ 1)+(conc(i) ^ 1));
end
for i=1:length(conc)
    v2(i) = (Vmax * (conc(i) ^ 2)) / ((Khalf ^ 2)+(conc(i) ^ 2));
end
for i=1:length(conc)
    v10(i) = (Vmax * (conc(i) ^ 10)) / ((Khalf ^ 10)+(conc(i) ^ 10));
end
plot(conc,v1,'b-');
hold on;
plot(conc,v2,'r-');
plot(conc,v10,'g-');
hold off
xlabel('Concentration in mM');
ylabel('Value of v in mM/s');
title('Hill equation for h=1,2,10');
