close all
clear global; clear
clc

%%
stp = 0.001;
idx = 1:5;
dir = 1;

u0 = [0.3;0.3];

%%
% N0 = CCS2DBasisFun(SubDInfo,u0);
% v0 = N0{1}(1,idx);
%
% u1 = u0;
% u1(dir) = u1(dir)-stp;
% N1 = CCS2DBasisFun(SubDInfo,u1);
% v1 = N1{1}(1,idx);
%
% u2 = u0;
% u2(dir) = u2(dir)+stp;
% N2 = CCS2DBasisFun(SubDInfo,u2);
% v2 = N2{1}(1,idx);
%
% (v2-v1)/(stp*2)
%
% Nd1 = CCS2DBasis1stDer(SubDInfo,u0);
% vd1 = Nd1{1}(dir+1,idx)

%%
N0 = CCS2DBasis1stDer(SubDInfo,u0);
vd01 = N0{1}(2,idx);
vd02 = N0{1}(3,idx);

u1 = u0;
u1(dir) = u1(dir)-stp;
N1 = CCS2DBasis1stDer(SubDInfo,u1);
vd11 = N1{1}(2,idx);
vd12 = N1{1}(3,idx);

u2 = u0;
u2(dir) = u2(dir)+stp;
N2 = CCS2DBasis1stDer(SubDInfo,u2);
vd21 = N2{1}(2,idx);
vd22 = N2{1}(3,idx);

(vd21-vd11)/(stp*2)
(vd22-vd12)/(stp*2)

Nd2 = CCS2DBasis2ndDer(SubDInfo,u0);
vd31 = Nd2{1}(4,id)
vd32 = Nd2{1}(5,id)
vd33 = Nd2{1}(6,id)
