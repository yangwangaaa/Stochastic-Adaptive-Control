function act(u,sysflag)
% Actuator - Implement control action

global t Tnext Ts
global As Bs % test
global Xs 
global en % test
global An1 Bn1 Cn1 Dn1 Xn1 n1
global An2 Bn2 Cn2 Dn2 Xn2 n2

if sysflag==0, 		% Physical system (D/A converter)
 da_u1([u 0]*0.01);
elseif sysflag==1, 	% Linear discrete time system
 Xs=nl2tank(Xs,u);
 Xs=Xs+Dn1*randn(n1(2),1);
elseif sysflag==2, 	% Linear Continoues time system
 [td,xd]=ode45('dl2tank',[0 Ts],Xs,[],u);
 Xs=xd(length(xd),:)';
 Xs=Xs+Dn1*randn(n1(2),1);
elseif sysflag==3,	% Nonlinear continoues time system
 [td,xd]=ode45('d2tank',[0 Ts],Xs,[],u);
 Xs=xd(length(xd),:)';
 Xs=Xs+Dn1*randn(n1(2),1);
end

