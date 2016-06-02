global data % some data and time administration
data=[];
%------------------------------------------------------------------------
[A,B,k,C,s2]=sysinit; % Determine linear model (ie. get system)
%------------------------------------------------------------------------
% Reference signal
refsig=2; % 1-5
switch refsig,
 case 1, wt=zeros(100,1);
 case 2, wt=[zeros(10,1); ones(90,1)];
 case 3, wt=5*sqwave(100,100)';
 case 4, wt=5*prbs(100,15);
end
nstp=length(wt);
%------------------------------------------------------------------------
% Here goes the design of the controller ie. Q, R and S

%------------------------------------------------------------------------
% This is a state space realization of the controller.
[Ar,Br,Cr,Dr]=armax2ss(R,Q,0,S); 
nr=length(Ar); Xr=zeros(nr,1); 
%------------------------------------------------------------------------
measinit;		% Initilialise the measurement system
for it=1:nstp,
 w=wt(it);
 [y,t]=meas;

 u=Cr*Xr+Dr*[w;-y];             % Fixed parameter controller
 %u=w;

 data=[data; t w y u ];

 act(u);			 % Actuate control 
 Xr=Ar*Xr+Br*[w;-y];             % fixed parameter controller
end


%------------------------------------------------------------------------
% Post mortem analysis
%------------------------------------------------------------------------
plt 				  % plot results
%------------------------------------------------------------------------
