function [SubDInfo,subd] = CCS2DInitInfo(subd,level)
%% Instruction of programs ================================================
%
% Description:
%    Initialize Catmull_Clark subdivision surface information.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/8/31
% Last Modified: 2024/9/06
%
% =========================================================================
% Calling Sequence:
%    [SubDInfo,subd] = CCS2DInitInfo(subd,level)
%
% Inputs:
%    subd  : Data structure for representing a subdivision surface
%    level : Subdivision level
%
% Outputs:
%    V : Coordinates of all vertices
%    F : Vertex indices of all faces
%
%    https://www.cnblogs.com/shushen/p/5251070.html
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
SubDInfo = struct('ancestor',[],'children',[], ...
    'corner',[],'nodes',[],'mmtxs',[],'tree',[],'turn',[]);

for index_face = 1:size(F,1)
    SubDInfo(index_face).ancestor = index_face ...
        -(ceil(index_face/nf_init)-1)*nf_init;
    SubDInfo(index_face).corner = corner(index_face,:);

    [nodes,mmtxs,tree,turn] = CCS2DDevideMesh(subd,topo,clas,index_face);
    SubDInfo(index_face).nodes = nodes;
    SubDInfo(index_face).mmtxs = mmtxs;
    SubDInfo(index_face).tree  = tree;
    SubDInfo(index_face).turn  = turn;
end

end