close all
clear
clc

%% Case-1
% V = [
%     1  2  2  1  0  0 -1  0  0  1  2  3  3  3  3  2  1  0
%     1  1  2  2  2  1  0  0 -1  0  0  0  1  2  3  3  3  3
%     0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
%     ];

N = 4; D = 2*N;
F = [
    1  2   3   4   5   6
    2  D+3 D+4 3   4   1
    3  D+4 D+5 D+6 D+7 4
    4  3   D+6 D+7 D+8 5
    ];
F = [F,[6:2:D;7:2:D+1;8:2:D+2;ones(1,N-2)]]';
V = [
    1  2  2  1  0  0 -1  0 -1  0  3  3  3  2  1  0
    1  1  2  2  3  2  2  1  0  0  1  2  3  3  3  4
    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
    ]';

subd = CCS2DMaker(V,F);
CCS2DPlotMesh(subd,0);

[SubDInfo,subd] = CCS2DInitInfo(subd,2);
% [subd,mmtx] = CCS2DGlobalRefine(subd,1);
% [subd,mmtx] = CCS2DGlobalRefineOne(subd);


trans = CCS2DDevideMesh(subd.vtype,4,4);

% [Tmtxs,corner] = CCS2DDevideMesh(subd.F,subd.vtype,1,5);

% V = [
%     2, 1, 0; 2, 2, 0; 1, 2, 0; 1, 1, 0
%     1, 0, 0; 2, 0, 0; 3,-1, 0; 3, 0, 0
%     4, 0, 0; 3, 1, 0; 3, 2, 0; 3, 3, 0
%     2, 3, 0; 1, 3, 0; 0, 3, 0; 0, 2, 0
%     0, 1, 0; 0, 0, 0
%     ];
% F = [
%     1  2  3  4
%     1  4  5  6
%     1  6  7  8
%     1  8  9 10
%     1 10 11  2
%     2 11 12 13
%     3  2 13 14
%     16 3 14 15
%     17 4  3 16
%     17 18 5 4
%     ];

% subd2 = CCS2DMaker(V,F);
% [vseq,fseq] = CCS2DSortOrder(subd2,2);

%% 
subd = CCSMaker(V,F);
[E,eic] = CCS2DExtractEdge(F);

figure
CCSPlot(subd,0,'meshline','on');
hold on
view(2)

for i = 1:size(V,1)
    text(V(i,1)+0.05,V(i,2)+0.15,V(i,3),num2str(i),'FontSize',14);
    hold on
end

[V2,F2,vtype2] = CCSubd2DRefine(V,F,subd.vtype,1);
[~,M] = CCSubd2DLocalRefine(F,subd.vtype);

subds2 = CCSMaker(V2,F2,vtype2);
figure
CCSPlot(subds2,0,'meshline','on');
hold on
view(2)

for i = 1:size(V2,1)
    text(V2(i,1)+0.05,V2(i,2)+0.15,V2(i,3),num2str(i),'FontSize',14);
    hold on
end







