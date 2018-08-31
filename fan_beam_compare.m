I = phantom(256); D = 200; dtheta = 1; [Farc,FposArcDeg,Fangles] =  fanbeam(I,D,'FanSensorGeometry','arc','FanRotationIncrement',dtheta); 
 
FposArc = D*tan(FposArcDeg*pi/180); 
 
[R,Rpos]=radon(I,Fangles); 
 
figure idx = find(Fangles==90); plot(Rpos,R(:,idx),FposArc,Farc(:,idx)) legend('Radon','Arc') 