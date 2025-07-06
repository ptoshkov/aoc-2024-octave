datStr = strsplit(fileread('day10.dat'));
global dat;
global possiblePaths;
global reachablePeaks;
dat = [];
possiblePaths = [];
reachablePeaks = [];

for ii = 1:numel(datStr)
    rowels = regexp(datStr{ii}, '.', 'match');

    for jj = 1:numel(rowels)
        dat = [dat, str2num(rowels{jj})];
    end
end

dat = reshape(dat, sqrt(numel(dat)), sqrt(numel(dat)));
dat = transpose(dat);

function possibleMoves = getPossibleMoves(location)
    global dat;
    
    possibleMoves = [];
    currentElevation = dat(location);
    leftIdx = location - rows(dat);
    rightIdx = location + rows(dat);
    [currentRow, currentCol] = ind2sub(size(dat), location);
    upRow = currentRow - 1;
    downRow = currentRow + 1;

    if(leftIdx > 0)
        if(dat(leftIdx) - 1 == currentElevation)
            possibleMoves = [possibleMoves, leftIdx];
        end
    end

    if(rightIdx <= numel(dat))
        if(dat(rightIdx) - 1 == currentElevation)
            possibleMoves = [possibleMoves, rightIdx];
        end
    end

    if(upRow > 0)
        if(dat(location - 1) - 1 == currentElevation)
            possibleMoves = [possibleMoves, location - 1];
        end
    end

    if(downRow <= rows(dat))
        if(dat(location + 1) - 1 == currentElevation)
            possibleMoves = [possibleMoves, location + 1];
        end
    end
end

function move(location, pathSoFar)
    global dat;
    global possiblePaths;
    global reachablePeaks;

    pathSoFar = [pathSoFar, location];
    possibleMoves = getPossibleMoves(location);

    if(dat(location) == 9)
        possiblePaths = [possiblePaths; pathSoFar];
        reachablePeaks = [reachablePeaks, location];
    end

    for ii = 1:numel(possibleMoves)
        move(possibleMoves(ii), pathSoFar);
    end
end

startIxs = find(dat == 0);
startIxsScores = [];

for ii = 1:numel(startIxs)
    reachablePeaks = [];
    move(startIxs(ii), []);
    score = numel(unique(reachablePeaks));
    startIxsScores = [startIxsScores, score];
end

assert(778 == sum(startIxsScores));
assert(1925 == rows(unique(possiblePaths, 'rows')));
