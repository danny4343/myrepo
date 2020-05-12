recovery = 0.5;
transmission = 2.5;
maxtime=10;
timestep=maxtime/0.01;
recovered=zeros(timestep,1);
infected=zeros(timestep,1);
susceptible=zeros(timestep,1);
time=zeros(timestep,1);
recovered(1)=0;
infected(1)=0.1;
susceptible(1)=0.9;
time(1)=0;


for i=1:maxtime-1
    recovered(i+1)=recovered(i)+(recovery*infected(i));
    infected(i+1)=infected(i)+(transmission*susceptible(i)*infected(i))-(recovery*infected(i));
    susceptible(i+1)=1-recovered(i+1)-infected(i+1);
    time(i+1)=time(i)+1
end


hold on
plot(time,recovered,'b-'); 
plot(time,infected,'r-');
plot(time,susceptible,'k-');
hold off
legend({'recovered','infected','susceptible'},'location','southeast');