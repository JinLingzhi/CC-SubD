function N = CCS2DBasisFunOne(mmtxs,seqs,c,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DBasisFunOne.m
% Description:
%    Extract vertex indices of mesh edges on the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/02
% Last Modified: 2024/09/12
%
% =========================================================================
% Calling Sequence:
%    N = CCS2DBasisFunOne(mmtxs,seqs,c,u)
%
% Inputs:
%    mmtxs :
%    seqs  :
%    c     :
%    u     :
%
% Outputs:
%    N     :
%
%% Body of programs =======================================================
%
Bu = UbspBasisFun((u(1)-c(1))/(c(3)-c(1)));
Bv = UbspBasisFun((u(2)-c(2))/(c(4)-c(2)));
B  = kron(Bv,Bu);

if isempty(seqs)
    N = B*mmtxs{1,1};
else
    mmtx = mmtxs{seqs(1,1),seqs(1,2)};
    for i = 2:size(seqs,1)
        mmtx = mmtxs{seqs(i,1),seqs(i,2)}*mmtx;
    end
    N = B*mmtx;
end

end