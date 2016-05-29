%% Initialization
clear all
close all

format compact
warning off
    path(path,'ver12/pol');
    path(path,'ver12/sys');
    path(path,'ver12/sig');
    path(path,'ver12/plt');
    path(path,'ver12/ctrl');
    path(path,'ver12/sysid');

%% Question 2.1

A = [1 -2.36 2.16 -0.74];
B = [0 0.06];
dstep(B,A)
grid

%% Question 2.2

h = tf([0 0.06],[1 -2.36 2.16 -0.74],1.5,'variable','z^-1')
pzmap(h)

%% Question 2.3
