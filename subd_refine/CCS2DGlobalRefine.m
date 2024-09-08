function [subd,mmtx,corner] = CCS2DGlobalRefine(subd,level)
%% Instruction of programs ================================================
%
% Filename   : CCS2DGlobalRefine.m
% Description:
%    ***.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/08/31
% Last Modified: 2024/09/06
%
% =========================================================================
% Calling Sequence:
%    [subd,mmtx] = CCS2DGlobalRefine(subd,level)
%
% Inputs:
%    subd  : Data structure for representing a subdivision surface
%    level : Subdivision level
%
% Outputs:
%    subd  : Data structure for representing a subdivision surface
%
%% Body of programs =======================================================
%
V = subd.vertex;
T = subd.vtype;
F = subd.face;
E = subd.edge;
Eic = subd.eic;

%! Initialize outputs
mmtx = eye(size(V,1),size(V,1));
corner = repmat([0 0 1 1],[size(F,1),1]);

%%
for i = 1:level
    %! Amount of vertices, faces and edges
    nv = size(T,1);
    nf = size(F,1);
    ne = size(E,1);

    %! Number of vertices on the boundary
    FEmtx = sparse(repmat((1:nf)',1,4),Eic,1,nf,ne);
    BVis = (T ~= 1);                                                       % Check if the vertex is on the boundary
    BEis = (sum(FEmtx,1) == 1)';                                           % Check if the edge is on the boundary

    IVid = find(T == 1);
    ni = length(IVid);

    %! Mapped matrix for vertices
    Aeve = sparse([E(:,1) E(:,2)],[E(:,2) E(:,1)],1,nv,nv);
    Aodd = sparse([F(:,1) F(:,2)],[F(:,3) F(:,4)],1,nv,nv);
    Aodd = Aodd+Aodd';

    val_eve = sum(Aeve,2);
    val_odd = sum(Aodd,2);

    beta = 3./(2*val_eve);
    gama = 1./(4*val_odd);
    alph = 1-beta-gama;

    mmtx_v = sparse(nv,nv); %#ok<*SPRIX>
    mmtx_v(IVid,:) = ...
        sparse(1:ni,IVid,alph(IVid),ni,nv)+ ...
        bsxfun(@times,Aeve(IVid,:),beta(IVid)./val_eve(IVid))+ ...
        bsxfun(@times,Aodd(IVid,:),gama(IVid)./val_odd(IVid));
    mmtx_bv = ...
        sparse(E(BEis,[1 2]),E(BEis,[2 1]),1/8,nv,nv)+ ...
        sparse(E(BEis,[1 2]),E(BEis,[1 2]),3/8,nv,nv);
    mmtx_v(BVis,:) = mmtx_bv(BVis,:);

    %! Mapped matrix for faces
    mmtx_f = sparse(repmat((1:nf)',1,4),F,1,nf,nv).*1/4;

    %! Mapped matrix for edges
    EVmtx = sparse([Eic Eic],reshape(F(:,[3 4 1 2 4 1 2 3]),[],2), ...
        1,ne,nv);
    EVmtx(BEis,:) = 0;
    mmtx_e = sparse([1:ne 1:ne],[E(:,1);E(:,2)], ...
        [BEis;BEis].*1/2+[~BEis;~BEis].*3/8, ...
        ne,nv)+EVmtx.*1/16;

    %! New faces & new vertices
    s0 = 0*nf+(1:nf); i0 = nv+s0';
    s1 = 1*nf+(1:nf); i1 = nv+s1';
    s2 = 2*nf+(1:nf); i2 = nv+s2';
    s3 = 3*nf+(1:nf); i3 = nv+s3';
    s4 = 4*nf+(1:nf); i4 = nv+s4';

    Ftmp = [
        F(:,1) i1 i0 i4
        i1 F(:,2) i2 i0
        i0 i2 F(:,3) i3
        i4 i0 i3 F(:,4)
        ];
    reidx = [(1:nv)';nv+(1:nf)';nv+nf+Eic];
    F = reidx(Ftmp);

    corner = repmat(corner,[4 1]);
    corner([s0,s1,s2,s3],:) = [
        corner(s0,1),corner(s0,2),0.5*(corner(s0,1)+corner(s0,3)),0.5*(corner(s0,2)+corner(s0,4))
        0.5*(corner(s1,1)+corner(s1,3)),corner(s1,2),corner(s1,3),0.5*(corner(s1,2)+corner(s1,4))
        0.5*(corner(s2,1)+corner(s2,3)),0.5*(corner(s2,2)+corner(s2,4)),corner(s2,3),corner(s2,4)
        corner(s3,1),0.5*(corner(s3,2)+corner(s3,4)),0.5*(corner(s3,1)+corner(s3,3)),corner(s3,4)
        ];

    %! New vertex type
    ET = zeros(ne,1);
    ET(BEis ~= 1) = 1;
    ET(BEis == 1) = 2;
    T = [T;ones(nf,1);ET]; %#ok<*AGROW>

    %! Update vertices
    temp = find(T == 3);
    ntmp = length(temp);

    mmtx_v(temp,:) = sparse(1:ntmp,temp,1,ntmp,nv);
    mmtx = [mmtx_v;mmtx_f;mmtx_e]*mmtx;

    %! Extract vertex index for edges
    [E,Eic] = ExtractEdgeVertex(F);
end

V = mmtx*V;
subd = CCS2DMaker(V,F,T);

end