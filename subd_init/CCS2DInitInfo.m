function [SubDInfos,subd] = CCS2DInitInfo(subd,level)
%% Instruction of programs ================================================
%
% Description:
%    Initialize Catmull_Clark subdivision surface information.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/8/31
% Last Modified: 2024/9/12
%
% =========================================================================
% Calling Sequence:
%    [SubDInfos,subd] = CCS2DInitInfo(subd,level)
%
% Inputs:
%    subd      : Data structure for representing a subdivision surface
%    level     : Subdivision level
%
% Outputs:
%    SubDInfos :
%    subd      : Data structure for representing a subdivision surface
%
%% Body of programs =======================================================
%
[nf_init] = size(subd.face,1);
[subd,~,corner] = CCS2DGlobalRefine(subd,level);

V = subd.vertex;
F = subd.face;
E = subd.edge;
Eic = subd.eic;

topo = CCS2DClassifyTopo(V,F,E,Eic);
clas = CCS2DClassifyMesh(V,F,E,Eic);

%% Initialize information for subdivision surface
SubDInfos = struct('parent',[],'corner',[],'nodes',[],'mmtxs',[], ...
    'tree',[],'turn',[],'type',[]);

for index_face = 1:size(F,1)
    SubDInfos(index_face).ancestor = index_face ...
        -(ceil(index_face/nf_init)-1)*nf_init;
    SubDInfos(index_face).corner = corner(index_face,:);

    [nodes,mmtxs,tree,turn,type] = CCS2DDevideMesh( ...
        subd,topo,clas,index_face);
    SubDInfos(index_face).nodes = nodes;
    SubDInfos(index_face).mmtxs = mmtxs;
    SubDInfos(index_face).tree  = tree;
    SubDInfos(index_face).turn  = turn;
    SubDInfos(index_face).type  = type;
end

end