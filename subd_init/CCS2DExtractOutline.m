function [SV,CV] = CCS2DExtractOutline(F,E,eic)
%% Body of programs

%! Amount of vertices, faces and edges
nf = size(F,1);
ne = size(E,1);

%! Table for mapping each edge to its opposite vertex
EF = sparse(eic,repmat(1:nf,[1,4]),1,ne,nf);
% EV = sparse([1:ne 1:ne],[E(:,1);E(:,2)],1,ne,nv);

%%
BEidx = find(sum(EF,2) == 1);
BE = E(BEidx,:);
SV = unique([BE(:,1);BE(:,2)]);

SEF = EF(BEidx,sum(EF(BEidx,:),1) == 2);
CV = zeros(1,size(SEF,2));
for i = 1:size(SEF,2)
    temp = E(BEidx(SEF(:,i) == 1),:);
    temp = intersect(temp(1,:),temp(2,:));
    if ~isempty(temp)
        CV(i) = temp;
    end
end
CV(CV == 0) = [];

%%
if ~isempty(BEidx)
    outlines = cell(10,1); nl = 0;
    isused = zeros(1,length(BEidx));

    outlines{1} = E(BEidx(find(isused == 0,1)),:);
    isused(1) = 1;

    nl = nl+1;
    flag = 1;

    while any(isused == 0)

        idxtmp = find(isused == 0);
        if flag == 0
            nl = nl+1;
            outlines{nl} = E(BEidx(idxtmp(1)),:);
            isused(idxtmp(1)) = 1;
            idxtmp(1) = [];
        end

        flag = 0;
        unused_edges = BEidx(idxtmp);

        for i = 1:length(unused_edges)
            temp = find(E(unused_edges(i),:) == outlines{nl}(end),1);

            if isempty(temp), continue; end

            if temp == 1
                outlines{nl} = [outlines{nl},E(unused_edges(i),2)];
            else
                outlines{nl} = [outlines{nl},E(unused_edges(i),1)];
            end

            flag = 1;
            isused(idxtmp(i)) = 1;
            break;
        end

    end

    outlines = outlines(1:nl);

else
    outlines = [];
end


%%
SE = {}; %#ok<*AGROW>
for i = 1:length(outlines)
    line = [outlines{i},outlines{i}(1:end-1)];

    [~,ia] = intersect(outlines{i},CV);

    if ~isempty(ia)
        ia = sort(ia);
        for j = 1:length(ia)
            if j ~= length(ia)
                SE{end+1} = line(ia(j):ia(j+1));
            else
                SE{end+1} = line(ia(j):(ia(1)+length(outlines{i})-1));
            end
        end
    else
        SE{end+1} = outlines{i};
    end
end

end