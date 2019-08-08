function drive(x,y,z,s_max,V0)
s=0;
t=0;
dt=0.5;
k=0.2;
figure
axis([0 10 0 10])
hold on
Z=0;
dz=0;
while s<s_max && t<200
   s=s+V0*(1-dz*k)*dt;
   X=x(s);
   Y=y(s);
   dz=Z;
   Z=z(s);
   dz=dz-Z;
   t=t+dt;
   plot(X,Y,'bo')   
end

hold off






