%1
Vmax1 = 2;
Vmax2 = 5;
Vmax3 = 10;
Khalf1 = 20;
Khalf2 = 20;
Khalf3 = 20;
h1 = 2;
h2 = 2;
h3 = 2;
conc = 0:1:100;
for i=1:length(conc)
    v1(i) = (Vmax1 * (conc(i) ^ h1)) / ((Khalf1 ^ h1)+(conc(i) ^ h1));
end
for i=1:length(conc)
    v2(i) = (Vmax2 * (conc(i) ^ h2)) / ((Khalf2 ^ h2)+(conc(i) ^ h2));
end
for i=1:length(conc)
    v10(i) = (Vmax3 * (conc(i) ^ h3)) / ((Khalf3 ^ h3)+(conc(i) ^ h3));
end
plot(conc,v1,'b-');
hold on;
plot(conc,v2,'r-');
plot(conc,v10,'g-');
hold off
legend({'Vmax=2.0','Vmax=5.0','Vmax=10.0'},'location','northwest');
xlabel('Concentration in mM');
ylabel('Value of v in mM/s');
title('Hill equation for Vmax=2.0,5.0,10.0');
