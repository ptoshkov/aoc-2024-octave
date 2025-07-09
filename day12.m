max_recursion_depth(512);
dat = cell2mat(importdata('day12.dat'));
letters = unique(dat);
datPadded = zeros(size(dat) + 2);
datPadded+='.';
datPadded(2:rows(dat)+1, 2:columns(dat)+1) = dat;
datPadded = char(datPadded);
global group;
global wallCnt;
global edgeCnt;
group = [];
wallCnt = [];
edgeCnt = [];
sum1 = 0;
sum2 = 0;

function findAdjacent(gryd, index)
    global group;

    if(any(group == index))
        return;
    end

    group = unique([group, index]);

    nextIndex = index + 1;

    if(gryd(nextIndex) > 0)
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index + rows(gryd);

    if(gryd(nextIndex) > 0)
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index - 1;

    if(gryd(nextIndex) > 0)
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index - rows(gryd);

    if(gryd(nextIndex) > 0)
        findAdjacent(gryd, nextIndex)
    end

end

function getWallCnt(gryd, group)
    global wallCnt;

    for ii = 1:numel(group)
        index = group(ii);
        value = gryd(index);
        cnt = 0;

        nextIndex = index + 1;

        if(~(isequal(gryd(nextIndex), value)))
            cnt++;
        end

        nextIndex = index + rows(gryd);

        if(~(isequal(gryd(nextIndex), value)))
            cnt++;
        end

        nextIndex = index - 1;

        if(~(isequal(gryd(nextIndex), value)))
            cnt++;
        end

        nextIndex = index - rows(gryd);

        if(~(isequal(gryd(nextIndex), value)))
            cnt++;
        end

        wallCnt = [wallCnt, cnt];
    end
end

function getEdgeCnt(gryd, group)
    global edgeCnt;

    for ii = 1:numel(group)
        index = group(ii);
        value = gryd(index);
        cnt = 0;

        southIndex = index + 1;
        eastIndex = index + rows(gryd);
        northIndex = index - 1;
        westIndex = index - rows(gryd);
        % south-east
        southEastIndex = index + 1 + rows(gryd);
        % north-east
        northEastIndex = index + rows(gryd) - 1;
        % north-west
        northWestIndex = index - rows(gryd) - 1;
        % south-west
        southWestIndex = index - rows(gryd) + 1;

        % outer edge north-west
        if(~(isequal(gryd(westIndex), value)))
                if(~(isequal(gryd(northIndex), value)))
                    cnt++;
                    % ("outer north west")
                end
        end

        % outer edge north-east
        if(~(isequal(gryd(northIndex), value)))
                if(~(isequal(gryd(eastIndex), value)))
                    cnt++;
                    % ("outer north east")
                end
        end

        % outer edge south-east
        if(~(isequal(gryd(eastIndex), value)))
                if(~(isequal(gryd(southIndex), value)))
                    cnt++;
                    % ("outer south east")
                end
        end

        % outer edge south-west
        if(~(isequal(gryd(southIndex), value)))
                if(~(isequal(gryd(westIndex), value)))
                    cnt++;
                    % ("outer south west")
                end
        end

        % inner edge north-west
        if((isequal(gryd(westIndex), value)))
            if(~(isequal(gryd(northWestIndex), value)))
                if((isequal(gryd(northIndex), value)))
                    cnt++;
                    % ("inner north west")
                end
            end
        end

        % inner edge north-east
        if((isequal(gryd(northIndex), value)))
            if(~(isequal(gryd(northEastIndex), value)))
                if((isequal(gryd(eastIndex), value)))
                    cnt++;
                    % ("inner north east")
                end
            end
        end

        % inner edge south-east
        if((isequal(gryd(eastIndex), value)))
            if(~(isequal(gryd(southEastIndex), value)))
                if((isequal(gryd(southIndex), value)))
                    cnt++;
                    % ("inner south east")
                end
            end
        end

        % inner edge south-west
        if((isequal(gryd(southIndex), value)))
            if(~(isequal(gryd(southWestIndex), value)))
                if((isequal(gryd(westIndex), value)))
                    cnt++;
                    % ("inner south west")
                end
            end
        end

        edgeCnt = [edgeCnt, cnt];
    end
end

for ii = 1:numel(letters)
    letter = letters(ii)
    adjMat = (datPadded == letter);
    indices = find(adjMat > 0);

    for jj = 1:numel(indices)
        index = indices(jj);

        if(adjMat(index) == 0)
            continue;
        end

        group = [];
        findAdjacent(adjMat, index);
        adjMat(group) = 0;

        wallCnt = [];
        getWallCnt(datPadded, group);
        sum1 = sum1 + numel(group)*sum(wallCnt);

        edgeCnt = [];
        getEdgeCnt(datPadded, group);
        sum2 = sum2 + numel(group)*sum(edgeCnt);
    end
end

sum1
% assert( 1488414 == sum1);
sum2
% assert( 911750 == sum2);
