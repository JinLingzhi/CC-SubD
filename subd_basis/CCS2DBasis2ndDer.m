function Nd = CCS2DBasis2ndDer(SubDInfo,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DBasis2ndDer.m
% Description:
%    ...
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/02
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    Nd = CCS2DBasis2ndDer(SubDInfo,u)
%
% Inputs:
%    SubDInfo :
%    u        :
%
% Outputs:
%    Nd       :
%
%% Body of programs =======================================================
%
mmtxs = SubDInfo.mmtxs;
Nd = cell(size(u,2),1);

[H,seqs,c,u] = CCS2DFindSpan(SubDInfo,u);

%%
for i = 1:size(u,2)
    r = c(i,3)-c(i,1);
    s = c(i,4)-c(i,2);

    Bdu = UbspBasis2ndDer((u(1,i)-c(i,1))/r);
    Bdv = UbspBasis2ndDer((u(2,i)-c(i,2))/s);

    Bt(1,:) = kron(Bdv(1,:),Bdu(1,:));
    Bt(2,:) = kron(Bdv(1,:),Bdu(2,:))/r;
    Bt(3,:) = kron(Bdv(2,:),Bdu(1,:))/s;
    Bt(4,:) = kron(Bdv(1,:),Bdu(3,:))/(r*r);
    Bt(5,:) = kron(Bdv(3,:),Bdu(1,:))/(s*s);
    Bt(6,:) = kron(Bdv(2,:),Bdu(2,:))/(r*s);

    Bd = Bt;
    Bd(2:3,:) = [H(1,1),H(2,1);H(1,2),H(2,2)]*Bd(2:3,:);
    Bd(4:6,:) = [
        H(1,1)*H(1,2),H(2,1)*H(2,1),H(1,1)*H(2,1)+H(1,1)*H(2,1)
        H(1,2)*H(1,2),H(2,2)*H(2,2),H(1,2)*H(2,2)+H(1,2)*H(2,2)
        H(1,1)*H(1,2),H(2,1)*H(2,2),H(1,1)*H(2,2)+H(1,2)*H(2,1)
        ]*Bt(4:6,:);

    if isempty(seqs{i})
        Nd{i} = Bd*mmtxs{1,1};
    else
        mmtx = mmtxs{seqs{i}(1,1),seqs{i}(1,2)};
        for j = 2:size(seqs{i},1)
            mmtx = mmtxs{seqs{i}(j,1),seqs{i}(j,2)}*mmtx;
        end
        Nd{i} = Bd*mmtx;
    end
end

end