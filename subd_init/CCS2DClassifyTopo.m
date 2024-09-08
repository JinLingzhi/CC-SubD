function [topo,vvtop,vftop,vetop,fftop,fetop,eftop] = CCS2DClassifyTopo(vertex,face,edge,eic)
%% Instruction of programs ================================================
%
% Filename   : CCS2DClassifyTopo.m
% Description:
%    Classify the control mesh topologies of the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/01
% Last Modified: 2024/09/05
%
% =========================================================================
% Calling Sequence:
%    [topo,vvtop,vftop,vetop,fftop,fetop,eftop] = CCS2DClassifyTopo(vertex,face,edge,eic)
%
% Inputs:
%    vertex : Coordinates of all vertices
%    face   : Vertex indices of all faces
%    edge   : Vertex indices of all edges
%    eic    : Index relationship between four edges of each face and the face.
%
% Outputs:
%    topo   :
%    vvtop  :
%    vftop  :
%    vetop  :
%    fftop  :
%    fetop  :
%    eftop  :
%
%% Body of programs =======================================================
%
%! Amount of vertices, faces and edges
nv = size(vertex,1);
nf = size(face,1);
ne = size(edge,1);

%! Initialize outputs
vvtop = cell(nv,1);
vftop = cell(nv,1);
vetop = cell(nv,1);
fftop = cell(nf,1);
fetop = cell(nf,1);
eftop = cell(ne,1);

%%
FVmtx = sparse(repmat((1:nf)',1,4),face,1,nf,nv);
EVmtx = sparse(repmat((1:ne)',1,2),edge,1,ne,nv);
FEmtx = sparse(repmat((1:nf)',1,4),eic ,1,nf,ne);

for i = 1:nv
    vftop{i} = find(FVmtx(:,i));
    vetop{i} = find(EVmtx(:,i));
    vvtop{i} = reshape(edge(vetop{i},:),[],1);
    vvtop{i} = setdiff(unique(vvtop{i}),i);
end

for i = 1:nf
    fftop{i} = find(sum(FVmtx(:,face(i,:)),2));
    fftop{i} = setdiff(fftop{i},i);
    fetop{i} = find(FEmtx(i,:));
end

for i = 1:ne
    eftop{i} = find(FEmtx(:,i));
end

%%
topo = struct;
topo.vvtop = vvtop; topo.vftop = vftop;
topo.vetop = vetop; topo.fftop = fftop;
topo.fetop = fetop; topo.eftop = eftop;

end