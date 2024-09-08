function [clas,vclas,fclas,eclas] = CCS2DClassifyMesh(vertex,face,edge,eic)
%% Instruction of programs ================================================
%
% Filename   : CCS2DClassifyMesh.m
% Description:
%    Classify the control meshes of the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/08/31
% Last Modified: 2024/09/05
%
% =========================================================================
% Calling Sequence:
%    [clas,vclas,fclas,eclas] = CCS2DClassifyMesh(vertex,face,edge,eic)
%
% Inputs:
%    vertex : Coordinates of all vertices
%    face   : Vertex indices of all faces
%    edge   : Vertex indices of all edges
%    eic    : Index relationship between four edges of each face and the face.
%
% Outputs:
%    vclas  :
%    fclas  :
%    eclas  :
%
%% Body of programs =======================================================
%
%! Amount of vertices, faces and edges
nv = size(vertex,1);
nf = size(face,1);
ne = size(edge,1);

%! Initialize outputs
fclas = zeros(nf,1);
eclas = zeros(ne,1);

%%
FVmtx = sparse(repmat((1:nf)',1,4),face,1,nf,nv);
FEmtx = sparse(repmat((1:nf)',1,4),eic ,1,nf,ne);

BEidx = find(sum(FEmtx,1) == 1)';
BE = edge(BEidx,:);
BVidx = unique(reshape(BE,[],1));

%%
%! vclas: 0(regular vertex); n(n-irregular vertex); -n(n-boundary vertex)
vclas = full(sum(FVmtx,1)');
vclas(BVidx) = -vclas(BVidx);
vclas(vclas == 4) = 0;

%! fclas: 10(interior regular face); 11(interior irregular face);
%         2n(boundary face with n boundary vertices)
fclas(sum(FVmtx(:,vclas == 0),2) == 4) = 10;
temp = sum(FVmtx(:,vclas < 0),2);
fclas(temp > 0) = 20+temp(temp > 0);
fclas(fclas == 0) = 11;

%! eclas: 1(interior edge); 2(boundary edge)
eclas(BEidx) = 2;
eclas(eclas == 0) = 1;

%%
clas = struct;
clas.vclas = vclas;
clas.fclas = fclas;
clas.eclas = eclas;

end