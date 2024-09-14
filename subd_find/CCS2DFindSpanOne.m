function [H,seqs,c,u] = CCS2DFindSpanOne(corner,tree,turn,u)
%% Instruction of programs ================================================
%
% Filename   : CCS2DFindSpanOne.m
% Description:
%    ...
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/10
% Last Modified: 2024/09/14
%
% =========================================================================
% Calling Sequence:
%    [seqs,c,u] = CCS2DFindSpan(corner,tree,turn,u)
%
% Inputs:
%    corner : Data structure for representing a subdivision surface
%    tree   :
%    turn   :
%    u      :
%
% Outputs:
%    seqs   :
%    c      :
%    u      :
%
%% Body of programs =======================================================
%
% Ta = [1 0 -1; 0 1 0; 0 0 1];
% Tb = [0 1  0;-1 0 0; 0 0 1];
% T1 = Tb*Ta;

T1 = [0 1 0;-1 0 1; 0 0 1];
T2 = [1 0 0; 0 1 0];
H  = T2*(T1^turn);

u = H*[u(1);u(2);1];
t = H*[corner(1,[1,3]);corner(1,[2,4]);1,1];
corner = [min(t(1,:)),min(t(2,:)),max(t(1,:)),max(t(2,:))];

%%
nmax = 16;
seqs = zeros(nmax,2);
seqs(1,:) = [1 1];

u1 = corner(1); u2 = corner(3);
v1 = corner(2); v2 = corner(4);
iter = 0;

if ~isempty(tree)
    branch = tree(1:4);
    flag = -1;

    while flag < 0
        %! Determine in which subspace the parameter point lies
        x = sign((u(1)-u1)/(u2-u1)-0.5);
        y = sign((u(2)-v1)/(v2-v1)-0.5);
        x(x == 0) = 1;
        y(y == 0) = 1;

        span = 1.5*x*x-0.5*x*y+y+1;
        iter = iter+1;

        if iter >= nmax
            u = 0.5*[u1+u2;v1+v2];
            span = find(branch > 0,1);
            seqs(iter,:) = [span,abs(flag)];
            break;
        end

        %! Update the new parameters
        seqs(iter,:) = [span,abs(flag)];

        flag = branch(span);
        branch = tree(4*(abs(flag)-1)+(1:4));

        k = [1 4 3 2]; temp = k(span);
        u1 = (0.25*span^2-1.25*span+2.0)*u1+ ...
            (-0.25*span^2+1.25*span-1.0)*u2;
        u2 = (0.25*span^2-1.25*span+1.5)*u1+ ...
            (-0.25*span^2+1.25*span-0.5)*u2;
        v1 = (0.25*temp^2-1.25*temp+2.0)*v1+ ...
            (-0.25*temp^2+1.25*temp-1.0)*v2;
        v2 = (0.25*temp^2-1.25*temp+1.5)*v1+ ...
            (-0.25*temp^2+1.25*temp-0.5)*v2;
    end
end

c = [u1,v1,u2,v2];
seqs = seqs(1:iter,:);

end