function [q,r,s,g] = dsnmv0(a,b,k,c);
%usage: [q,r,s,g] = dsnmv0(a,b,k,c);
%or
%       [q,r,s]=dsnmv0(a,b,k,c)
%
% ru = qw-sy
 
% Programmed by Niels K. Poulsen 
% Department of Mathematical Modelling, 
% Technical University of Denmark 

[g,s]=truncimp(a,k,c);
r=polmul(b,g);
q=c;

%r0=r(1);
%r=r/r0; q=q/r0; s=s/r0;
