close all;
clear global; clear;
clc

% Read mesh vertex information from .OBJ file
[V,F] = Obj2Matlab('Vehicle.obj');
subd = CCS2DMaker(V,F);

% Plot the topology diagram of subdivision control meshes
figure(1)
CCS2DPlotTopo(subd,0);
hold on

figure(2)
CCS2DPlotMesh(subd,3);
hold on

[SubDInfos,subd] = CCS2DInitInfo(subd,1);

for i = 1:size(subd.face,1)
    SubDInfo = SubDInfos(i);

    y = linspace(SubDInfo.corner(2),SubDInfo.corner(4),11);
    x = linspace(SubDInfo.corner(1),SubDInfo.corner(3),11);
    [yy,xx] = meshgrid(y,x);

    u = [reshape(xx,1,[]);reshape(yy,1,[])];
    P = CCS2DPointEval(SubDInfo,subd.vertex,u);

    plot3(P(1,:),P(2,:),P(3,:),'b.');
    hold on
end