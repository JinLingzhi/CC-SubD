function N = CCS2DBasisFun(SubDInfo,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DBasisFun.m
% Description:
%    Extract vertex indices of mesh edges on the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/02
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    N = CCS2DBasisFun(SubDInfo,u)
%
% Inputs:
%    SubDInfo :
%    u        :
%
% Outputs:
%    N        :
%
%% Body of programs =======================================================
%
mmtxs = SubDInfo.mmtxs;
N = cell(size(u,2),1);

[~,seqs,c,u] = CCS2DFindSpan(SubDInfo,u);

%%
for i = 1:size(u,2)
    Bu = UbspBasisFun((u(1,i)-c(i,1))/(c(i,3)-c(i,1)));
    Bv = UbspBasisFun((u(2,i)-c(i,2))/(c(i,4)-c(i,2)));

    B = kron(Bv,Bu);

    if isempty(seqs{i})
        N{i} = B*mmtxs{1,1};
    else
        mmtx = mmtxs{seqs{i}(1,1),seqs{i}(1,2)};
        for j = 2:size(seqs{i},1)
            mmtx = mmtxs{seqs{i}(j,1),seqs{i}(j,2)}*mmtx;
        end
        N{i} = B*mmtx;
    end
end

end