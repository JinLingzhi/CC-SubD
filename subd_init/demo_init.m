close all;
clear global; clear;
clc

%% Demo-1 mesh
%! ftype: 10
% V = [
%     1.0 2.0 2.0 1.0 0.0 0.0 0.0 1.0 2.0 3.0 3.0 3.0 3.0 2.0 1.0 0.0
%     1.0 1.0 2.0 2.0 2.0 1.0 0.0 0.0 0.0 0.0 1.0 2.0 3.0 3.0 3.0 3.0
%     0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
%     ]';
%
% F = [
%     01 08 09 02 03 04 05 06 06
%     02 09 10 11 12 03 04 01 07
%     03 02 11 12 13 14 15 04 08
%     04 01 02 03 14 15 16 05 01
%     ]';
%

%% Demo-2 mesh
%! ftype: 11
% V = [
%     1.0 2.0 2.0 1.0 0.0 0.0 -1.0 0.0  0.0 1.0 2.0 3.0 3.0 3.0 3.0 2.0 1.0 0.0
%     1.0 1.0 2.0 2.0 2.0 1.0  0.0 0.0 -1.0 0.0 0.0 0.0 1.0 2.0 3.0 3.0 3.0 3.0
%     0.0 0.0 0.0 0.0 0.0 0.0  0.0 0.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
%     ]';
%
% F = [
%     01 10 11 02 03 04 05 06 06 08
%     02 11 12 13 14 03 04 01 07 09
%     03 02 13 14 15 16 17 04 08 10
%     04 01 02 03 16 17 18 05 01 01
%     ]';
%

%% Demo-3 mesh
%! ftype: 21
% V = [
%     0.0 1.0 2.0 1.0 1.0 0.0 0.0  1.0 1.0 2.0 3.0 2.0 3.0 4.0 3.0 2.0 2.0
%     1.0 1.0 2.0 2.0 3.0 2.0 0.0 -1.0 0.0 0.0 0.0 1.0 2.0 3.0 3.0 3.0 4.0
%     0.0 0.0 0.0 0.0 0.0 0.0 0.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
%     ]';
%
% F = [
%     01 04 07 09 10 02 03 04 05
%     02 05 08 10 11 12 13 03 04
%     03 06 09 02 12 13 14 15 16
%     04 01 01 01 02 03 15 16 17
%     ]';

% V = [
%     0 1 2 1 2 1 1 0 0 1  2 2 3 4 3 2 3
%     2 1 1 2 3 3 4 3 1 0 -1 0 0 0 1 2 3
%     0 0 0 0 0 0 0 0 0 0  0 0 0 0 0 0 0
%     ]';
%
% F = [
%     1 4 6 9 10 2 3 4 5
%     2 5 7 10 11 12 13 3 4
%     3 6 8 2 12 13 14 15 16
%     4 1 1 1 2 3 15 16 17
%     ]';

%% Demo-4 mesh
%! ftype: 221
% V = [
%     1.0 2.0 2.0 1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 3.0 3.0 3.0 2.0 1.0 0.0
%     1.0 1.0 2.0 2.0 3.0 2.0  2.0 1.0  0.0 0.0 1.0 2.0 3.0 3.0 3.0 4.0
%     0.0 0.0 0.0 0.0 0.0 0.0  0.0 0.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
%     ]';
%
% F = [
%     01 02 03 04 05 06 06 08
%     02 11 12 03 04 01 07 09
%     03 12 13 14 15 04 08 10
%     04 03 14 15 16 05 01 01
%     ]';
%

%% Demo-5 mesh
%! ftype: 222
% V = [
%     0.0 1.0 1.0 0.0 -1.0 -1.0 0.0  1.0 1.0 2.0 3.0 2.0 2.0 2.0 1.0 0.0
%     1.0 1.0 2.0 2.0  0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 1.0 2.0 3.0 3.0 3.0
%     0.0 0.0 0.0 0.0  0.0  0.0 0.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
%     ]';
%
% F = [
%     01 05 07 09 10 02 03 04
%     02 06 08 10 11 12 13 03
%     03 07 09 02 12 13 14 15
%     04 01 01 01 02 03 15 16
%     ]';
%

%% Demo-6 mesh
%! ftype: 23
V = [
    1.0 2.0 2.0 1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 3.0 3.0 3.0 2.0 1.0 0.0
    1.0 1.0 2.0 2.0 3.0 2.0  2.0 1.0  0.0 0.0 1.0 2.0 3.0 3.0 3.0 4.0
    0.0 0.0 0.0 0.0 0.0 0.0  0.0 0.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
    ]';

F = [
    01 02 03 04 05 06 06 08
    02 11 12 03 04 01 07 09
    03 12 13 14 15 04 08 10
    04 03 14 15 16 05 01 01
    ]';


%%
ri = reshape(randperm(size(V,1)),[],1);
[~,si] = sort(ri);
vimap = [(1:size(V,1))',ri];
V = V(vimap(:,2),:);
F = reshape(si(F),[],size(F,2));

nv = size(V,1);
nf = size(F,1);

%%
subd = CCS2DMaker(V,F);
subd = CCS2DGlobalRefine(subd,1);

figure
CCS2DPlotTopo(subd,0);
hold on
figure
CCS2DPlotMesh(subd,0);
hold on

[SubDInfos,subd] = CCS2DInitInfo(subd,1);

for i = 1:size(subd.face,1)
    % text(subd.vertex(subd.face(i,:),1),subd.vertex(subd.face(i,:),2),subd.vertex(subd.face(i,:),3),{'1' '2' '3' '4'})
    SubDInfo = SubDInfos(i);
    corner = SubDInfo.corner;

    y = linspace(corner(2),corner(4),11);
    x = linspace(corner(1),corner(3),11);
    [yy,xx] = meshgrid(y,x);

    u = [reshape(xx,1,[]);reshape(yy,1,[])];
    P = CCS2DPointEval(SubDInfo,subd.vertex,u);

    plot3(P(1,:),P(2,:),P(3,:),'b.');
    hold on
end