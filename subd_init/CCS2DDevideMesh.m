function [nodes,mmtxs,tree,turn,ftype] = CCS2DDevideMesh(subd,topo,clas,fidx)
%% Instruction of programs ================================================
%
% Filename   : CCS2DDevideMesh.m
% Description:
%    Extract vertex indices of mesh edges on the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/02
% Last Modified: 2024/09/13
%
% =========================================================================
% Calling Sequence:
%    [nodes,mmtxs,tree,turn,ftype] = CCS2DDevideMesh(subd,topo,clas,fidx)
%
% Inputs:
%    face : Vertex indices of all faces
%
% Outputs:
%    edge : Vertex indices of all edges
%    eic  :
%
%% Body of programs =======================================================
%
H1 = sparse(1:16,[7 8 9 10 6 1 2 11 5 4 3 12 16 15 14 13],1,16,16);

%%
[ftype,N,turn,vseq] = CCS2DSortOneLoop(subd,topo,clas,fidx);
nodes = reshape(vseq,1,[]);

switch ftype
    case 10 % Interior regular mesh
        mmtxs{1} = H1;
        tree = [];

    case 11 % Interior Irregular mesh
        trans = CCS2DTransOneLoop(subd.vtype(nodes),ftype,N);

        mmtxs = cell(4,1);
        mmtxs{1} =    trans{1};
        mmtxs{2} = H1*trans{2};
        mmtxs{3} = H1*trans{3};
        mmtxs{4} = H1*trans{4};
        tree = [-1 1 1 1];

    case 21 % Boundary mesh with 1 boundary vertex
        trans = CCS2DTransOneLoop(subd.vtype(nodes),ftype,N);

        mmtxs = cell(4,1);
        mmtxs{1} =    trans{1};
        mmtxs{2} = H1*trans{2};
        mmtxs{3} = H1*trans{3};
        mmtxs{4} = H1*trans{4};
        tree = [-1 1 1 1];

    case 221 % Boundary mesh with 2 boundary vertices
        [trans1,vtype,imtxs] = CCS2DTransOneLoop(subd.vtype(nodes),ftype,N);
        [trans2            ] = CCS2DTransOneLoop(vtype(imtxs{2}),201,N);

        mmtxs = cell(4,1);
        mmtxs{1,1} =    trans1{1};
        mmtxs{2,1} =    trans1{2};
        mmtxs{3,1} = H1*trans1{3};
        mmtxs{4,1} = H1*trans1{4};
        mmtxs{1,2} =    trans2{1};
        mmtxs{2,2} =    trans2{2};
        mmtxs{3,2} = H1*trans2{3};
        mmtxs{4,2} = H1*trans2{4};
        tree = [-1 -2 1 1,-2 -2 2 2];

    case 222 % Boundary mesh with 2 boundary vertices
        [trans1,vtype,imtxs] = CCS2DTransOneLoop(subd.vtype(nodes),ftype,N);
        [trans2            ] = CCS2DTransOneLoop(vtype(imtxs{4}),202,N);

        mmtxs = cell(4,1);
        mmtxs{1,1} =    trans1{1};
        mmtxs{2,1} = H1*trans1{2};
        mmtxs{3,1} = H1*trans1{3};
        mmtxs{4,1} =    trans1{4};
        mmtxs{1,2} =    trans2{1};
        mmtxs{2,2} = H1*trans2{2};
        mmtxs{3,2} = H1*trans2{3};
        mmtxs{4,2} =    trans2{4};
        tree = [-1 1 1 -2,-2 2 2 -2];

    case 23 % Boundary mesh with 3 boundary vertices
        [trans1,vtype,imtxs] = CCS2DTransOneLoop(subd.vtype(nodes),ftype,N);
        [trans2            ] = CCS2DTransOneLoop(vtype(imtxs{2}),201,N);
        [trans3            ] = CCS2DTransOneLoop(vtype(imtxs{4}),202,N);

        mmtxs = cell(4,3);
        mmtxs{1,1} =    trans1{1};
        mmtxs{2,1} =    trans1{2};
        mmtxs{3,1} = H1*trans1{3};
        mmtxs{4,1} =    trans1{4};
        mmtxs{1,2} =    trans2{1};
        mmtxs{2,2} =    trans2{2};
        mmtxs{3,2} = H1*trans2{3};
        mmtxs{4,2} = H1*trans2{4};
        mmtxs{1,3} =    trans3{1};
        mmtxs{2,3} = H1*trans3{2};
        mmtxs{3,3} = H1*trans3{3};
        mmtxs{4,3} =    trans3{4};
        tree = [-1 -2 1 -3,-2 -2 2 2,-3 3 3 -3];

    otherwise
        error('Sorry, an error has occurred.');
end

end