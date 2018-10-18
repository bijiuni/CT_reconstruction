%{ Compare the performance of pencil-beam and fan-beam CT reconstruction
	 
	   % This is a simple program with no function defined
%}

% Calculate pencil-beam and fan-beam result for a single column
I = phantom(256); D = 200; dtheta = 1; [Farc,FposArcDeg,Fangles] =  fanbeam(I,D,'FanSensorGeometry','arc','FanRotationIncrement',dtheta); 
 
FposArc = D*tan(FposArcDeg*pi/180); 
 
[R,Rpos]=radon(I,Fangles); 

% Plot the result and compare the performance
figure idx = find(Fangles==90); plot(Rpos,R(:,idx),FposArc,Farc(:,idx)) legend('Radon','Arc') 
