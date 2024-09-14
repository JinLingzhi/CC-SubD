function P = CCS2DPointEval(SubDInfo,vertex,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DPointEval.m
% Description:
%    Sort the vertices and faces adjacent to the specified face in a snake
%    like pattern.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/12
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    P = CCS2DPointEval(SubDInfo,vertex,u)
%
% Inputs:
%    SubDInfo :
%    vertex   :
%    u        :
%
% Outputs:
%    P        :
%
%% Body of programs =======================================================
%
P = zeros(size(u,2),3);
N = CCS2DBasisFun(SubDInfo,u);
for i = 1:size(u,2)
    P(i,:) = N{i}*vertex(SubDInfo.nodes,:);
end
P = P';
end