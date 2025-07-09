dat = cell2mat(importdata('day12.dat'));
letters = unique(dat);
datPadded = zeros(size(dat) + 2);
datPadded+='.';
datPadded(2:rows(dat)+1, 2:columns(dat)+1) = dat;
datPadded = char(datPadded);
global group;
global wallCnt;
group = [];
wallCnt = [];
sum1 = 0;

function findAdjacent(gryd, index)
    global group;

    if(any(group == index))
        return;
    end

    group = unique([group, index]);

    nextIndex = index + 1;

    if(gryd(nextIndex) > 0)
        gryd(index) = 0;
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index + rows(gryd);

    if(gryd(nextIndex) > 0)
        gryd(index) = 0;
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index - 1;

    if(gryd(nextIndex) > 0)
        gryd(index) = 0;
        findAdjacent(gryd, nextIndex)
    end

    nextIndex = index - rows(gryd);

    if(gryd(nextIndex) > 0)
        gryd(index) = 0;
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

for ii = 1:numel(letters)
    ii
    letter = letters(ii);
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
        % disp(group)

        wallCnt = [];
        getWallCnt(datPadded, group);
        % disp(wallCnt)

        sum1 = sum1 + numel(group)*sum(wallCnt);
        % disp(numel(group)*sum(wallCnt))
    end
end

sum1
