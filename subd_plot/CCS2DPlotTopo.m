function CCS2DPlotTopo(subd,level,varargin)
%% Instruction of programs ================================================
%
% Filename   : CCS2DPlotTopo.m
% Description:
%    Plot the control mesh topologies of a subdivision surface.
%
% Author: Lingzhi Jin
% Email : jinlz0428@outlook.com
%
% Date Created : 2024/09/05
% Last Modified: 2024/09/06
%
% =========================================================================
% Calling Sequence:
%    CCS2DPlotTopo(subd,level,varargin)
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
T = subd.vtype;
F = subd.face; 
E = subd.edge;
Eic = subd.eic;

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

%% Plot all vertex, face, and edge points
subd2 = subd; subd2.vtype(:) = 3;
subd2 = CCS2DGlobalRefine(subd2,1);

vv  = subd2.vertex(1:nv,:);
txt = cellfun(@num2str,num2cell(1:nv),'UniformOutput',false);
text(vv(:,1),vv(:,2),vv(:,3),txt,'Color','k','FontSize',14);
hold on

vf  = subd2.vertex(nv+(1:nf),:);
txt = cellfun(@num2str,num2cell(nv+(1:nf)),'UniformOutput',false);
text(vf(:,1),vf(:,2),vf(:,3),txt,'Color','b','FontSize',14);
hold on

ve  = subd2.vertex(nv+nf+(1:ne),:);
txt = cellfun(@num2str,num2cell(nv+nf+(1:ne)),'UniformOutput',false);
text(ve(:,1),ve(:,2),ve(:,3),txt,'Color','r','FontSize',14);
hold on

%% Figure properties setting
xlabel('X'); ylabel('Y'); zlabel('Z')
axis equal
axis tight
% view(3)

set(gcf,'Color',[1 1 1])
set(gca,'Clipping','off')

end