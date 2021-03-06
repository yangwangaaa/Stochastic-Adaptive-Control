
%  Solution to exercise no 19, Stochastic Adaptive Control
%  Mahmood Mirzaei, Apr. 2013

clear all;
close all;
warning off;

%% ------------------------------------------------------------------------
% #1 Solution to the first question:
% Deterministic experiment:
% ------------------------------------------------------------------------

sh=0;%6/2.5758; %sh=0;
su=0;%10/2.5758; %su=0;

wb
y(:,1)=data(:,3);
y(:,2)=data(:,4);

u=data(:,5);

figure;
plot(y);
title('Outputs');

figure;
plot(u);
title('Inputs');

% Detrend:
y=detrend(y,'constant');
u=detrend(u,'constant');

dat=iddata(y,u,Ts);
%plot(dat)

na=[2 2; 2 2];
nb=[1;1];
k=[1; 1];
ns=[na nb k];
th=arx(dat,ns);
present(th);

fprintf('\n\n\n-------------------------------------------------\n');
fprintf('\t\tPress any key to continue!');
fprintf('\n-------------------------------------------------\n');
pause;

%% ------------------------------------------------------------------------
% #2 Solution to the second question:
% Stochastic experiment:
% -------------------------------------------------------------------------

clear all;
clc;
% close all;

sh=6/2.5758; %sh=0;
su=10/2.5758; %su=0;

wb
y(:,1)=data(:,3);
y(:,2)=data(:,4);

u=data(:,5);

figure;
plot(y);
title('Outputs');

figure;
plot(u);
title('Inputs');

% Detrend:
y=detrend(y,'constant');
u=detrend(u,'constant');

dat=iddata(y,u,Ts);
%plot(dat)

na=[2 2; 2 2];
% na=[1 2; 0 2];
na=[3 3; 3 3];
nb=[1;1];
k=[1; 1];
ns=[na nb k];
th=arx(dat,ns);
present(th);

fprintf('\n\n\n-------------------------------------------------\n');
fprintf('\t\tPress any key to continue!');
fprintf('\n-------------------------------------------------\n');
pause;

%% ------------------------------------------------------------------------
% #3 Solution to the third question:
% MARX, CT (identification of a transfer function)
% ------------------------------------------------------------------------
clear all;
clc;
% close all;

sh=6/2.5758; %sh=0;
su=10/2.5758; %su=0;

wb
y(:,1)=data(:,3);
y(:,2)=data(:,4);

u=data(:,5);

figure;
plot(y);
title('Outputs');

figure;
plot(u);
title('Inputs');

% Detrend:
y=detrend(y,'constant');
u=detrend(u,'constant');

dat=iddata(y,u,Ts);
 
np = 2;
th=tfest(dat,np);
present(th);

fprintf('\n\n\n-------------------------------------------------\n');
fprintf('\t\tPress any key to continue!');
fprintf('\n-------------------------------------------------\n');
pause;

% sys = 
%% ------------------------------------------------------------------------
% #4 Solution to the 4th question:
% Stochastic experiment, continuous time:
% -------------------------------------------------------------------------

clear all;
clc;
% close all;

sh=0;%6/2.5758; %sh=0;
su=0;%10/2.5758; %su=0;

wb
y(:,1)=data(:,3);
y(:,2)=data(:,4);

u=data(:,5);

% figure;
% plot(y);
% title('Outputs');
% 
% figure;
% plot(u);
% title('Inputs');

% Detrend:
y=detrend(y,'constant');
u=detrend(u,'constant');

dat=iddata(y,u,Ts);
%plot(dat)

th=ssest(dat,2,'Ts',Ts);%(dat,ns);
present(th);

fprintf('\n\n\n-------------------------------------------------\n');
fprintf('\t\tPress any key to continue!');
fprintf('\n-------------------------------------------------\n');
pause;

%% ------------------------------------------------------------------------
% #5 Solution to the 5th question:
% Stochastic experiment, continuous time:
% -------------------------------------------------------------------------

clear all;
clc;
% close all;

sh=0;%6/2.5758; %sh=0;
su=0;%10/2.5758; %su=0;

wb
y(:,1)=data(:,3);
y(:,2)=data(:,4);

u=data(:,5);

% Detrend:
y=detrend(y,'constant');
u=detrend(u,'constant');

dat=iddata(y,u,Ts);

x1_0    = X0(1);
x2_0    = X0(2);
C       = 153.938;

aux                 = [x1_0 x2_0 C];
initial_guess       = [1 1]; %a1 and a2 initial guess
sys                 = idgrey('two_tanks',initial_guess,'c',aux);
identified_model    = pem(dat,sys);

a1_identified       = identified_model.Report.Parameters.ParVector(1);
a2_identified       = identified_model.Report.Parameters.ParVector(2);

%--------------------------------------------------------------------------
%                   Calculate a1 and a2
tank_par;
a1=ao*sigmao*sqrt(2*g)/C;
a2=al*sigmal*sqrt(2*g)/C;
%--------------------------------------------------------------------------

disp('----------------------------------------------');
fprintf('a1 is %1.4f and the identified a1 is %1.4f\n\n',a1,a1_identified);
fprintf('a2 is %1.4f and the identified a2 is %1.4f\n',a2,a2_identified);
disp('----------------------------------------------');
