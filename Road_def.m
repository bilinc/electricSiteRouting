function Road_data=Road_def(Name,Path,PolyDeg)

S=zeros(length(Path(1,:)),1)';
dz=zeros(length(Path),1)';
 %Compute S
 for i=1:length(Path(1,:))
    
  if i==1
   S(i)=0;
  else
     
     S(i)=S(i-1)+sqrt((Path(1,i-1)-Path(1,i))^2+(Path(2,i-1)-Path(2,i))^2+(Path(3,i-1)-Path(3,i))^2);
     %dx(i)=Path(1,i-1)-Path(1,i);
     %dy(i)=Path(2,i)-Path(2,i-1);
     %dz(i)=Path(3,i)-Path(3,i-1);

  end
  
 end

 %Create X(s), Y(s) and Z(s)

 X_pol=fit(S',Path(1,:)',PolyDeg);
 Y_pol=fit(S',Path(2,:)',PolyDeg);
 Z_pol=fit(S',Path(3,:)',PolyDeg);
 
 s=0:0.1:S(end);
 
 DZ=differentiate(Z_pol,s);
 
 dZ=fit(s',DZ,PolyDeg);
%  
 %  figure
 % plot(S',Path(3,:))
 % hold on
 %  plot(Z_pol,'b--')
%  
 Road_data={Name,S(end),X_pol,Y_pol,Z_pol,dZ}; %Save name of road, length of road, X_pol, Y_pol
 