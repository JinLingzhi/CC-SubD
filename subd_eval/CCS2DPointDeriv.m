function Pd = CCS2DPointDeriv(SubDInfo,vertex,u,nd)
%% Instruction of programs ================================================
%
% Filename   : CCS2DPointDeriv.m
% Description:
%    ...
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/14
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    P = CCS2DPointDeriv(SubDInfo,vertex,u)
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
switch nd
    case 0
        Pd = zeros(3,size(u,2));
        Nd = CCS2DBasisFun(SubDInfo,u);
        for i = 1:size(u,2)
            Pd(:,i) = (Nd{i}*vertex(SubDInfo.nodes,:))';
        end

    case 1
        Pd = zeros(3,3,size(u,2));
        Nd = CCS2DBasis1stDer(SubDInfo,u);
        for i = 1:size(u,2)
            Pd(:,:,i) = (Nd{i}*vertex(SubDInfo.nodes,:))';
        end

    case 2
        Pd = zeros(3,6,size(u,2));
        Nd = CCS2DBasis2ndDer(SubDInfo,u);
        for i = 1:size(u,2)
            Pd(:,:,i) = (Nd{i}*vertex(SubDInfo.nodes,:))';
        end

    otherwise
        error('Sorry, an error has occurred.');
end

end