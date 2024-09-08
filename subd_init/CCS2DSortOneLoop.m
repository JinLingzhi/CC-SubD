function [ftype,N,turn,vseq,fseq] = CCS2DSortOneLoop(subd,topo,clas,fidx)
%% Instruction of programs ================================================
%
% Filename   : CCS2DSortOneLoop.m
% Description:
%    Sort the vertices and faces adjacent to the specified face in a snake
%    like pattern.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/01
% Last Modified: 2024/09/08
%
% =========================================================================
% Calling Sequence:
%    [ftype,N,turn,vseq,fseq] = CCS2DSortOneloop(subd,topo,clas,fidx)
%
% Inputs:
%    subd : Data structure for representing a subdivision surface
%    fidx :
%
% Outputs:
%    vseq :
%    fseq :
%
%% Body of programs =======================================================
%
k = [1 2 3 4 1 2 3];

nbrf = topo.fftop{fidx};
fcls = clas.fclas(fidx);
vcls = clas.vclas(subd.face(fidx,:));
N = max(abs(vcls));

nf = size(subd.face,1);

%%
if fcls == 22
    [~,I] = sort(vcls,'ascend');
    invi = I(1);
    turn = invi-1;

    if I(2) == k(I(1)+1)
        ftype = 221;
        vseq = subd.face(fidx,k(invi));
        fseq = [];

        nxfi = fidx;
        nxvi = invi;
        crfn = 0;

    else
        ftype = 222;
        vseq(1:4) = subd.face(fidx,k(invi:invi+3));
        fseq(1,1) = fidx;

        nbre = topo.vetop{subd.face(fidx,k(invi))};
        temp = find(clas.eclas(nbre) == 2,2);
        nxei = setdiff(nbre(temp),subd.eic((k(invi+3)-1)*nf+fidx));
        nxfi = topo.eftop{nxei}(1);
        nxvi = find(subd.face(nxfi,:) == subd.face(fidx,k(invi)),1);
        crfn = 1;
    end

else
    switch fcls
        case 10
            invi = 1;
        case 11
            invi = find(vcls >   0,1);
        case 21
            invi = find(vcls <   0,1);
        case 23
            invi = find(vcls == -1,1);
        otherwise
            error('Sorry, an error has occurred.');
    end
    ftype = fcls;
    turn = invi-1;

    vseq = subd.face(fidx,k(invi));
    fseq = [];

    nxfi = fidx;
    nxvi = invi;
    crfn = 0;
end

%%
while crfn <= length(nbrf)

    while isempty(find(vseq == subd.face(nxfi,k(nxvi+1)),1))
        nxvi = k(nxvi+1);
        vseq(end+1) = subd.face(nxfi,k(nxvi)); %#ok<*AGROW>
    end
    fseq(end+1) = nxfi;

    if crfn == length(nbrf)
        break;
    end
    crvi = nxvi;
    crfi = nxfi;

    next = topo.eftop{subd.eic((k(crvi)-1)*nf+crfi)};
    if length(next) < 2
        nxfi = fidx;
        nxvi = find(subd.face(nxfi,:) == subd.face(crfi,k(crvi+1)));
        next = topo.eftop{subd.eic((k(nxvi)-1)*nf+nxfi)};

        while length(next) == 1
            nxvi = nxvi+1;
            next = topo.eftop{subd.eic((k(nxvi)-1)*nf+nxfi)};
        end
        crvi = nxvi;
        crfi = nxfi;
        nxfi = setdiff(next,crfi);
        nxvi = find(subd.face(nxfi,:) == subd.face(crfi,k(crvi)));
    else
        nxfi = setdiff(next,crfi);
        nxvi = find(subd.face(nxfi,:) == subd.face(crfi,k(crvi)));
    end

    crfn = crfn+1;

end

end