%%Special Course System Identification
%% Simulating a 1st order system
startup
wb
%% Fit the model in ARMAX model
ye = data(:,3); 
ue = data(:,4);
ze=[ye ue];
Ze = dtrend(ze);
SYS = armax(ze, [1 1 0 1])
present(SYS)
[parm p] = th2par(SYS);
estpres(parm, p)
resid(SYS, Ze)

%%

SYS = n4sid(ze,[1,3,2,10,15])

%% simulate boat manuvering

ExZigZag
data = [psi delta_c]; %[output:HeadingAngle input:RudderAngle]

%% 

SYSboat = n4sid(data,[1,2,3,4,5,6,7,8,9])