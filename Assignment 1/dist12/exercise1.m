%% Initialization
clear all
close all
startup

%% Question 1.1
 [A,B,C,D,R1,Cm,R2] = tsystem;
 etha = R1;
 Q = B*R1*B';
 Px_inf = dlyap(A,Q);
 Py_inf = C*Px_inf*C';
 
%% Question 1.2

realizations = [];
for i = 1:100
    wb2
    yt = sdata(:,3);
    realizations = [realizations yt];
end 
%% plotting of question 1.2
plot(time,-3*sqrt(Py_inf),time,3*sqrt(Py_inf),'color','b','LineWidth',2)
time = 1:10000;
for i = 1:length(realizations)
    hold on
    plot(time,realizations(:,i),'color',rand(1,3))
    hold off
end

%% Question 1.3
[A B C D R1 Cm R2] = tsystem; %%System dynamics
Q1 = C'*C;
Q2 = 0.01;
[K,S,e] = dlqr(A,B,Q1,Q2);
Q = B*R1*B';
Pxcl_infty = dlyap(A-B*K,Q)
Pycl_infty = C*Pxcl_infty*C'
Pu_infty = K*Pxcl_infty*K';

%% Question 1.4
wb_q4
output = sdata(:,3);
input = sdata(:,4);
confid99_in = 3*ones(length(output),1)*sqrt(Pycl_infty);
confid99_out = 3*ones(length(input),1)*sqrt(Pu_infty);

subplot(211)
plot(output)
hold on
plot(confid99_in, 'color','r')
plot(-confid99_in, 'color','r')
legend('Simulated output','Theoretical 99% confidence')
hold off
subplot(212)
plot(input)
hold on
plot(confid99_out, 'color','r')
plot(-confid99_out, 'color','r')
legend('Simulated input','Theoretical 99% confidence')
hold off

%% Question 1.5
% [M,P,Z,E] = dlqe(A,B,Cm,R1,R2);
wb_q6
% P_err_infty = Z;
nplot = 150;
t = 1:nplot;
real_x1  = sdata(:,3);
meas_x1 = sdata(:,5);
estim_x1 = sdata(:,6);

plot(t,real_x1(1:nplot),t,meas_x1(1:nplot),t,estim_x1(1:nplot))
legend('real x_1', 'measured x_1', 'estimated x_1')
grid


disp('hit key')
pause
plot(t,real_x1(1:nplot),t,estim_x1(1:nplot))
legend('real x_1', 'estimated x_1')
grid

disp('hit key')
pause
nplot = 6000;
plot(1:nplot,real_x1(1:nplot),1:nplot,estim_x1(1:nplot))
legend('real x_1', 'estimated x_1')
grid

%% Question 1.9

Q1 = C'*C;
Q2 = 0.01;
[L,S,e] = dlqr(A,B,Q1,Q2);
[K,P,Z,E] = dlqe(A,B,Cm,R1,R2);
A_cl = [A-B*L B*L;
    zeros(size(A)) A-K*Cm*A];
G_cl = [eye(size(A)) zeros(size(A))
    eye(size(A))-K*Cm -K];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vari_t+1 = A_cl*Var_t*A_cl' + G'RG'
R = [Q zeros(size(Q)); zeros(size(Q)) R2];
P_cl = dlyap(A_cl,G_cl*R*G_cl')
P_y_cl = [C zeros(1,length(C))]*P_cl*[C zeros(1,length(C))]'
P_u_cl = [L -L]*P_cl*[L -L]'

%% Question 1.10
wb_q9
disp('Stationary output variance')
var(sdata(:,3))
disp('Stationary input variance')
var(sdata(:,4))
%% Question 1.11
T =  [1.8,1;-0.95,0];
W = [1.5;0];

P_T = dlyap(T,W*1.794871*W');
P_n = [0.5 0]*P_T*[0.5 0]'

%% Question 1.13
variance_eta = [];
for i = 1:100
    wb_q13;
    variance_eta = [variance_eta var(sdata(:,5))];
end
disp('The experimental variance is')
mean(variance_eta)
%% Question 1.14
[A B C D R1 Cm R2] = tsystem; %%System dynamics
[Aw,Bw,Cw,Dw]=nsystem; %%Noise dynamic
A_aug = [A,B*Cw;zeros(size(A)),Aw];  
B_aug = [B; zeros(size(B))];
C_aug = [C zeros(size(C))];
Q1 = [C'*C,zeros(size(A));zeros(size(A)),zeros(size(A))];
Q2 = 0.01;
[L,S,e] = dlqr(A_aug,B_aug,Q1,Q2);
Q = [zeros(size(Bw)); Bw]*1.794871*[zeros(size(Bw)); Bw]';
Pxcl_infty = dlyap(A_aug-B_aug*L,Q);
disp('Theoretical stationary output variance')
Pycl_infty = C_aug*Pxcl_infty*C_aug'
disp('Theoretical stationary input variance')
Pu_infty = L*Pxcl_infty*L'

%% Question 1.15
realization = [];
for i = 1:100
    wb_q14
    exp_var_out = var(sdata(:,3));
    exp_var_in = var(sdata(:,4));
    realization = [realization;exp_var_out exp_var_in];
end
wb_q14
disp('Experimental stationary output variance')
var(realization(:,1))
disp('Experimental stationary input variance')
var(realization(:,2))

%% Question 1.19

Q1 = C'*C;
Q2 = 0.01;
[L,S,e] = dlqr(A,B,Q1,Q2);
[K,P,Z,E] = dlqe(A,B,Cm,R1,R2);
A_cl = [A-B*L B*L;
    zeros(size(A)) A-A*K*Cm];
G_cl = [eye(size(A)) zeros(size(A))
    eye(size(A)) -A*K];
Q = B*R1*B';
R = [Q zeros(size(Q)); zeros(size(Q)) R2];
P_cl = dlyap(A_cl,G_cl*R*G_cl')
P_y_cl = [C zeros(1,length(C))]*P_cl*[C zeros(1,length(C))]'
P_u_cl = [L -L]*P_cl*[L -L]'

%% Question 1.20
realization = [];
for i = 1:100
    wb_q20
    var_output = var(sdata(:,3));
    var_input = var(sdata(:,4));
    realization = [realization;var_output var_input];
end
disp('Experimental input variance')
mean(realization(:,1))
disp('Experimental output variance')
mean(realization(:,2))