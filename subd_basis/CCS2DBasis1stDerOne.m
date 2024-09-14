function Nd = CCS2DBasis1stDerOne(H,mmtxs,seqs,c,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DBasis1stDerOne.m
% Description:
%    Extract vertex indices of mesh edges on the subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/14
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    Nd = CCS2DBasis1stDerOne(H,mmtxs,seqs,c,u)
%
% Inputs:
%    H     :
%    mmtxs :
%    seqs  :
%    c     :
%    u     :
%
% Outputs:
%    Nd    :
%
%% Body of programs =======================================================
%
Bdu = UbspBasis1stDer((u(1)-c(1))/c(3)-c(1));
Bdv = UbspBasis1stDer((u(2)-c(2))/c(4)-c(2));

Bt(1,:) = kron(Bdv(1,:),Bdu(1,:));
Bt(2,:) = kron(Bdv(1,:),Bdu(2,:))/c(3)-c(1);
Bt(3,:) = kron(Bdv(2,:),Bdu(1,:))/c(4)-c(2);

Bd = Bt;
Bd(2:3,:) = [H(1,1),H(2,1);H(1,2),H(2,2)]*Bd(2:3,:);

if isempty(seqs)
    Nd = Bd*mmtxs{1,1};
else
    mmtx = mmtxs{seqs(1,1),seqs(1,2)};
    for i = 2:size(seqs,1)
        mmtx = mmtxs{seqs(i,1),seqs(i,2)}*mmtx;
    end
    Nd = Bd*mmtx;
end

end