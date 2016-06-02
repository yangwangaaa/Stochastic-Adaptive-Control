function [Dtsys Dnsys] = sysinit
% Initialize simulation system (Ssys) and Design system (Dsys)

global Stsys Snsys
global Ts
Ts=5;

[A B C D R1 Cm R2] = tsystem;
[An Bn Cn Dn] = nsystem;

R1n=NaN;
disp(' ');
disp('*** CanNot run. R1n has to be set ***')
disp('*** try R1n=10                    ***')
disp(' ')
R2n=0;

P0 = zeros(2,2);
X0 = zeros(2,1);

Stsys=sysss(A,B,Cm,D,R1,R2,X0,P0);
Snsys=sysss(An,Bn,Cn,Dn,R1n,R2n,X0,P0);

Dtsys=sysss(A,B,Cm,D,R1,R2,X0,P0);
Dnsys=sysss(An,Bn,Cn,Dn,R1n,R2n,X0,P0);
