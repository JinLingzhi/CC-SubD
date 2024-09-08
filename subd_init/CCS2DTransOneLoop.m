function [trans,vtype,imtxs] = CCS2DTransOneLoop(vtype,ftype,N)
%% Instruction of programs ================================================
%
% Filename   : CCS2DMeshStorage.m
% Description:
%
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/06
% Last Modified: 2024/09/06
%
% =========================================================================
% Calling Sequence:
%    trans = CCS2DMeshStorage(vtype,ftype,N)
%
% Inputs:
%    vtype :
%    ftype :
%    N     :
%
% Outputs:
%    trans :
%
%% Body of programs =======================================================
%
switch ftype

    case 10 % Interior regular mesh
        %! Number of vertices, faces, and edges
        nv = 16;
        nf = 09;
        ne = 24;

        %! Generate a new mesh topology
        F = [
            01 08 09 02 03 04 05 06 06
            02 09 10 11 12 03 04 01 07
            03 02 11 12 13 14 15 04 08
            04 01 02 03 14 15 16 05 01
            ]';

        E = [
            16 15 14 05 04 03 01 02 08 09 16 05, ...
            15 04 14 03 02 13 12 11 01 01 06 07
            15 14 13 04 03 12 02 11 09 10 05 06, ...
            04 01 03 02 09 12 11 10 06 08 07 08
            ]';

        %!
        imtxs = cell(4,1);
        imtxs{1} = [01 32 17 39 24 46 25 47 18 42 02 41 03 30 04 29];
        imtxs{2} = [32 02 41 17 39 01 47 18 42 19 33 20 31 03 30 04];
        imtxs{3} = [17 41 03 30 04 39 01 32 02 33 20 31 21 40 22 38];
        imtxs{4} = [39 17 30 04 29 24 46 01 32 02 41 03 40 22 38 23];

    case 11 % Interior irregular mesh
        %! Number of vertices, faces, and edges
        nv = 2*N+08;
        nf = 1*N+05;
        ne = 3*N+12;

        %! Generate a new mesh topology
        D = 2*N;
        F = [
            001 D+0 D+1 002 003 004 005 006
            002 D+1 D+2 D+3 D+4 003 004 001
            003 002 D+3 D+4 D+5 D+6 D+7 004
            004 001 002 003 D+6 D+7 D+8 005
            ];
        F = [F,[6:2:D-2;7:2:D-1;8:2:D;ones(1,N-3)]]';

        E = [
            D+8 D+7 D+6 005 004 003 001 002 D+0 D+1, ...
            D+8 005 D+7 004 D+6 003 002 D+5 D+4 D+3
            D+7 D+6 D+5 004 003 D+4 002 D+3 D+1 D+2, ...
            005 006 004 001 003 002 D+1 D+4 D+3 D+2
            ];
        E = [E,[ones(1,N-2);6:2:D],[6:D-1;7:D]]';

        %!
        M = 2*N+8; R = M+N+5; K = R+N;
        imtmp = reshape([R+21:R+N+18;M+9:R,0],1,[]);
        imtxs = cell(4,1);
        imtxs{1} = [0001 R+07 M+01 R+14 M+08 imtmp(1:end-1) M+02 R+17 0002 R+16 0003 R+05 0004 R+04];
        imtxs{2} = [R+07 0002 R+16 M+01 R+14 0001 K+18 M+02 R+17 M+03 R+08 M+04 R+06 0003 R+05 0004];
        imtxs{3} = [M+01 R+16 0003 R+05 0004 R+14 0001 R+07 0002 R+08 M+04 R+06 M+05 R+15 M+06 R+13];
        imtxs{4} = [R+14 M+01 R+05 0004 R+04 M+08 R+21 0001 R+07 0002 R+16 0003 R+15 M+06 R+13 M+07];

    case 201 % Boundary regular mesh-1
        %! Number of vertices, faces, and edges
        nv = 12;
        nf = 06;
        ne = 17;

        %! Generate a new mesh topology
        F = [
            01 02 03 04 05 06
            02 07 08 03 04 01
            03 08 09 10 11 04
            04 03 10 11 12 05
            ]';

        E = [
            12 11 10 05 04 03 06 01 02 12 05 11 04 10 03 09 08
            11 10 09 04 03 08 01 02 07 05 06 04 01 03 02 08 07
            ]';

        %!
        imtxs = cell(4,1);
        imtxs{1} = [01 26 13 31 18 25 02 33 03 23 04 22];
        imtxs{2} = [26 02 33 13 31 01 27 14 24 03 23 04];
        imtxs{3} = [13 33 03 23 04 31 01 26 02 27 14 24 15 22 16 30];
        imtxs{4} = [31 13 23 04 22 18 25 01 26 02 33 03 32 16 30 17];

    case 202 % Boundary regular mesh-2
        %! Number of vertices, faces, and edges
        nv = 12;
        nf = 06;
        ne = 17;

        %! Generate a new mesh topology
        F = [
            01 05 06 02 03 04
            02 06 07 08 09 03
            03 02 08 09 10 11
            04 01 02 03 11 12
            ]';

        E = [
            12 11 04 03 01 02 05 06 12 04 01 11 03 02 10 09 08
            11 10 03 09 02 08 06 07 04 01 05 03 02 06 09 08 07
            ]';

        %!
        imtxs = cell(4,1);
        imtxs{1} = [01 23 13 28 29 14 32 02 31 03 21 04];
        imtxs{2} = [23 02 31 13 28 01 29 14 32 15 24 16 22 03 21 04];
        imtxs{3} = [13 31 03 21 04 28 01 23 02 24 16 22 17 30 18 27];
        imtxs{4} = [28 13 21 04 01 23 02 31 03 30 18 27];

    case 21 % Boundary irregular mesh with 1 boundary vertex
        imtxs = [];

    case 221 % Boundary irregular mesh with 2 boundary vertices
        %! Number of vertices, faces, and edges
        nv = 2*N+08;
        nf = 1*N+04;
        ne = 3*N+11;

        %! Generate a new mesh topology
        D = 2*N;
        F = [
            001 002 003 004 005 006
            002 D+3 D+4 003 004 001
            003 D+4 D+5 D+6 D+7 004
            004 003 D+6 D+7 D+8 005
            ];
        F = [F,[6:2:D;7:2:D+1;8:2:D+2;ones(1,N-2)]]';

        E = [
            D+8 D+7 D+6 004 003 001 002, ...
            D+8 D+7 D+6 003 D+5 D+4
            D+7 D+6 D+5 003 D+4 002 D+3, ...
            005 004 003 002 D+4 D+3
            ];
        E = [E,[ones(1,N);4:2:D+2],[4:D+1;5:D+2]]';

        %!
        M = 2*N+8; R = M+N+4; K = R+N;
        imtmp = reshape([M+6:R;R+15:K+12,0],1,[]);
        imtxs = cell(4,1);
        imtxs{1} = [0001 R+06 M+01 R+14 imtmp(1:end-1) K+13 0002 R+11 0003 R+04 0004 K+14];
        imtxs{2} = [R+06 0002 R+11 M+01 R+14 0001 R+07 M+02 R+05 0003 R+04 0004 R+14 0001];
        imtxs{3} = [M+01 R+11 0003 R+04 0004 R+14 0001 R+06 0002 R+07 M+02 R+05 M+03 R+10 M+04 R+09];
        imtxs{4} = [R+14 M+01 R+04 0004 K+14 M+06 R+15 0001 R+06 0002 R+11 0003 R+10 M+04 R+09 M+05];

    case 222 % Boundary irregular mesh with 2 boundary vertices
        %! Number of vertices, faces, and edges
        nv = 2*N+08;
        nf = 1*N+04;
        ne = 3*N+11;

        %! Generate a new mesh topology
        D = 2*N;
        F = [
            001 D+1 D+2 002 003 004
            002 D+2 D+3 D+4 D+5 003
            003 002 D+4 D+5 D+6 D+7
            004 001 002 003 D+7 D+8
            ];
        F = [F(:,1),[5:2:D-1;6:2:D;7:2:D+1;ones(1,N-2)],F(:,2:6)]';

        E = [
            D+8 D+7 004 003 002 D+2 D+8, ...
            004 D+7 003 D+6 D+5 D+4
            D+7 D+6 003 D+5 D+4 D+3 004, ...
            001 003 002 D+5 D+4 D+3
            ];
        E = [E,[ones(1,N);5:2:D+1,2],[5:D+1,D+2;6:D+2,2]]';

        %!
        M = 2*N+8; R = M+N+4; K = R+N; P = M+N;
        imtmp = reshape([R+14:K+12,R+3*N+11;M+02:P,0],1,[]);
        imtxs = cell(4,1);
        imtxs{1} = [0001 K+13 M+01 R+08 imtmp(1:end-1) 0002 R+10 0003 R+03 0004];
        imtxs{2} = [K+13 0002 R+10 M+01 R+08 0001 K+12 P+00 R+3*N+11  R-03 R+05 R-02 R+04 0003 R+03 0004];
        imtxs{3} = [M+01 R+10 0003 R+03 0004 R+08 0001 K+12 0002 R+05 P+02 R+04 P+03 R+09 P+04 R+07];
        imtxs{4} = [R+08 M+01 R+03 0004 0001 K+13 0002 R+10 0003 R+09 P+04 R+07];

    case 23 % Boundary irregular mesh with 3 boundary vertices
        %! Number of vertices, faces, and edges
        nv = 09;
        nf = 04;
        ne = 12;

        %! Generate a new mesh topology
        F = [
            01 02 03 04
            02 05 06 03
            03 06 07 08
            04 03 08 09
            ]';

        E = [
            09 08 04 03 01 02 09 04 08 03 07 06
            08 07 03 06 02 05 04 01 03 02 06 05
            ]';

        %!
        M = 09; R = 13;
        imtxs = cell(4,1);
        imtxs{1} = [0001 R+05 M+01 R+08 0002 R+10 0003 R+03 0004];
        imtxs{2} = [R+05 0002 R+10 M+01 R+08 0001 R+06 M+02 R+04 0003 R+03 0004];
        imtxs{3} = [M+01 R+10 0003 R+03 0004 R+08 0001 R+05 0002 R+06 M+02 R+04 M+03 R+09 M+04 R+07];
        imtxs{4} = [R+08 M+01 R+03 0004 0001 R+05 0002 R+10 0003 R+09 M+04 R+07];

    otherwise
        error(' ');
end

%%
%!
EVmtx = sparse(repmat((1:ne)',1,2),E,1,ne,nv);
Eic = zeros(4*nf,1);
for i = 1:nf
    Eic(0*nf+i) = find(sum(EVmtx(:,F(i,[1 2])),2) == 2,1);
    Eic(1*nf+i) = find(sum(EVmtx(:,F(i,[2 3])),2) == 2,1);
    Eic(2*nf+i) = find(sum(EVmtx(:,F(i,[3 4])),2) == 2,1);
    Eic(3*nf+i) = find(sum(EVmtx(:,F(i,[4 1])),2) == 2,1);
end

%!
[mtemp,vtype] = CCS2DTopoRefine(F,E,Eic,vtype);

trans = cell(4,1);
trans{1} = mtemp(imtxs{1},:);
trans{2} = mtemp(imtxs{2},:);
trans{3} = mtemp(imtxs{3},:);
trans{4} = mtemp(imtxs{4},:);

end