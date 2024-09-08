function [edge,eic] = CCS2DExtractEdge(face)
%% Instruction of programs ================================================
%
% Filename   : CCS2DExtractEdge.m
% Description:
%    Extract vertex indices of mesh edges on the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/08/31
% Last Modified: 2024/08/31
%
% =========================================================================
% Calling Sequence:
%    [edge,eic] = CCS2DExtractEdge(face)
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
temp = reshape(face(:,[1 2 3 4 2 3 4 1]),[],2);

% imin = min(F,[],'all');
% imax = max(F,[],'all');
% inum = imax-imin+1;
% itmp = reshape(1:inum*inum,[inum,inum]);
% itmp = tril(itmp,-1)+triu(itmp',-1);
% [~,eia,eic] = unique(itmp(sub2ind(size(itmp),temp(:,1),temp(:,2))));

[~,eia,eic] = unique(sum(temp.^-2,2));
edge = temp(eia,:);

end