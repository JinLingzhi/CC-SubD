function subd = CCS2DMaker(vertex,face,vtype)
%% Instruction of programs ================================================
%
% Description:
%    Create a struct to store the data of control meshes on the subdivision
%    surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/01
% Last Modified: 2024/09/06
%
% =========================================================================
% Calling Sequence:
%    subd = CCS2DMaker(vertex,face,vtype)
%
% Inputs:
%    vertex : Coordinates of all vertices
%    face   : Vertex indices of all faces
%    vtype  : Types of all vertices
%
% Outputs:
%    subd   : Data structure for representing a subdivision surface
%
%% Body of programs =======================================================
%
[edge,eic] = CCS2DExtractEdge(face);

if nargin == 2
    clas = CCS2DClassifyMesh(vertex,face,edge,eic);
    vtype = ones(size(vertex,1),1);                                        % Smooth vertices
    vtype(clas.vclas <  -1) = 2;                                           % Sharp vertices
    vtype(clas.vclas == -1) = 3;                                           % Corner vertices
elseif nargin == 3
    vtype = reshape(vtype,[],1);
end

%%
subd = struct;
subd.vertex = vertex;
subd.face = face;
subd.edge = edge;

subd.vtype = vtype;
subd.eic = eic;

end