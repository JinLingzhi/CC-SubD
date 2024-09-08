function CCS2DPlotMesh(subd,level,varargin)
%% Instruction of programs ================================================
%
% Filename   : CCS2DPlotMesh.m
% Description:
%    Plot the control meshes of a subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/05
% Last Modified: 2024/09/06
%
% =========================================================================
% Calling Sequence:
%    CCS2DPlotMesh(subd,level,varargin)
%
% Inputs:
%    subd     : Data structure for representing a subdivision surface
%    level    : Subdivision level
%    varargin : Property options
%
% Outputs:
%
%% Body of programs =======================================================
%
nargs = nargin; m = 2; % Number of parameters inputed
if nargs < m
    error('Need a subdivision mesh to plot and the level of subdivisions.');
elseif rem(nargs+m,2)
    error('Parameter value pairs expected.')
end

%% Default values
linestyle = '-';
linecolor = [025,025,025]/255;                                             % 线颜色
linewidth = 1.0;                                                           % 线宽
facecolor = [241,244,250]/255;                                             % 面颜色
coloralph = 1.0;                                                           % 颜色透明度

colorlist = [];

%% Recover Param/Value pairs from argument list
for index_param = 1:2:nargs-m
    param = varargin{index_param  };
    value = varargin{index_param+1};

    if ~ischar(param)
        error('Parameter must be a string.')
    elseif size(param,1) ~= 1
        error('Parameter must be a non-empty single row string.')
    end

    switch lower(param)
        case 'linestyle'
            if ischar(value)
                linewidth = value;
            else
                error('linestyle must be a string.');
            end

        case 'linewidth'
            if isnumeric(value)
                linewidth = max(0.5,value);
            else
                error('linewidth must be a number.');
            end

        case 'linecolor'
            if ischar(value)
                linecolor = lower(value);
            elseif ismatrix(value)
                linecolor = value;
            else
                error('linecolor must be a string or matrix.');
            end

        case 'facecolor'
            if ischar(value)
                facecolor = lower(value);
            elseif ismatrix(value)
                facecolor = value;
            else
                error('facecolor must be a string or matrix.');
            end

        case 'coloralph'
            if isnumeric(value)
                coloralph = min(1,max(0.5,value));
            else
                error('coloralph must be a number.');
            end

        otherwise
            error('Unknown parameter: %s',param);
    end
end

%%
subd = CCS2DGlobalRefine(subd,level);
V = subd.vertex;
F = subd.face;
E = subd.edge;
Eic = subd.eic;

%! Amount of vertices, faces and edges
nv = size(V,1);
nf = size(F,1);
ne = size(E,1);
C  = ones(nv,1);

%%
patch('Vertices',V,'Faces',F,'FaceVertexCData',C, ...
    'LineStyle',linestyle,'LineWidth',linewidth, ...
    'FaceColor',facecolor,'FaceAlpha',coloralph);
hold on

FEmtx = sparse(repmat((1:nf)',1,4),Eic,1,nf,ne);
BE = E(sum(FEmtx,1) == 1,:);
for i = 1:length(BE)
    plot3(V(BE(i,:),1),V(BE(i,:),2),V(BE(i,:),3), ...
        'LineStyle',linestyle,'LineWidth',linewidth+1, ...
        'Color',linecolor);
end

%% Figure properties setting
xlabel('X'); ylabel('Y'); zlabel('Z')
axis equal
axis tight
% view(3)

set(gcf,'Color',[1 1 1])
set(gca,'Clipping','off')

end