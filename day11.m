global stones;
global counts;

% stones = [125 17];
% counts = [1 1];
% stones = [0 1 10 99 999];
% counts = [1 1 1 1 1];
stones = [0 37551 469 63 1 791606 2065 9983586];
counts = [1 1 1 1 1 1 1 1];

function appendStones(value)
    global stones;
    global counts;

    if(any(stones == value))
        counts(find(stones == value))++;
    else
        stones = [stones, value];
        counts = [counts, 1];
    end
end

function popStones(value)
    global stones;
    global counts;

    counts(find(stones == value))--;
end

function clearStones()
     global stones;
     global counts;

     stones(counts == 0) = [];
     counts(counts == 0) = [];
end

function [stone1, stone2] = processEvenNumberDigitsStone(value, midpoint)
    tens = 10^midpoint;
    stone1 = floor(value/tens);
    stone2 = rem(value, tens);
end

function processStones()
    global stones;
    global counts;
    stonesBackup = stones;
    countsBackup = counts;

    for ii = 1:numel(stonesBackup)
        stone = stonesBackup(ii);

        for jj = 1:countsBackup(ii)
            popStones(stone);

            if(stone == 0)
                appendStones(1);
            else
                digits = floor(log10(stone)) + 1;

                if(rem(digits, 2) == 0)
                    [stone1, stone2] = processEvenNumberDigitsStone(stone, digits/2);
                    appendStones(stone1);
                    appendStones(stone2);
                else
                    appendStones(2024*stone)
                end
            end
        end
    end
end

stones = stones(:, :);
counts = counts(:, :);

totalSum = 0;
allStones = stones;
allCounts = counts;

stonesPost25 = [];
countsPost25 = [];
sumPost25 = 0;

for i = 1:numel(allStones)
    stones = [allStones(i)];
    counts = [allCounts(i)];

    for ii = 1:25
        processStones();
        clearStones();
    end

    for ii = 1:numel(stones)
        value = stones(ii);
        count = counts(ii);

        for jj = 1:count
            if(any(stonesPost25 == value))
                countsPost25(find(stonesPost25 == value))++;
            else
                stonesPost25 = [stonesPost25, value];
                countsPost25 = [countsPost25, 1];
            end
        end
    end

    sumPost25+=sum(counts);
end

sumPost25
size(stonesPost25)
% assert(204022 == sumPost25);

stonesPost40 = [];
countsPost40 = [];
sumPost40 = 0;

for i = 1:numel(stonesPost25)
    disp(i)
    stones = [stonesPost25(i)];
    counts = [countsPost25(i)];

    for ii = 26:40
        fprintf("%d ", ii);
        processStones();
        clearStones();
    end

    for ii = 1:numel(stones)
        value = stones(ii);
        count = counts(ii);

        for jj = 1:count
            if(any(stonesPost40 == value))
                countsPost40(find(stonesPost40 == value))++;
            else
                stonesPost40 = [stonesPost40, value];
                countsPost40 = [countsPost40, 1];
            end
        end
    end

    sumPost40+=sum(counts);
    disp("");
end

sumPost40
size(stonesPost40)

stonesPost50 = [];
countsPost50 = [];
sumPost50 = 0;

for i = 1:numel(stonesPost40)
    disp(i)
    stones = [stonesPost40(i)];
    counts = [countsPost40(i)];

    for ii = 41:50
        fprintf("%d ", ii);
        processStones();
        clearStones();
    end

    for ii = 1:numel(stones)
        value = stones(ii);
        count = counts(ii);

        for jj = 1:count
            if(any(stonesPost50 == value))
                countsPost50(find(stonesPost50 == value))++;
            else
                stonesPost50 = [stonesPost50, value];
                countsPost50 = [countsPost50, 1];
            end
        end
    end

    sumPost50+=sum(counts);
    disp("");
end

sumPost50
size(stonesPost50)

stonesPost60 = [];
countsPost60 = [];
sumPost60 = 0;

for i = 1:numel(stonesPost50)
    disp(i)
    stones = [stonesPost50(i)];
    counts = [countsPost50(i)];

    for ii = 51:62
        fprintf("%d ", ii);
        processStones();
        clearStones();
    end

    for ii = 1:numel(stones)
        value = stones(ii);
        count = counts(ii);

        for jj = 1:count
            if(any(stonesPost60 == value))
                countsPost60(find(stonesPost60 == value))++;
            else
                stonesPost60 = [stonesPost60, value];
                countsPost60 = [countsPost60, 1];
            end
        end
    end

    sumPost60+=sum(counts);
    disp("");
end

sumPost60
size(stonesPost60)

for i = 1:numel(stonesPost60)
    disp(i)
    stones = [stonesPost60(i)];
    counts = [countsPost60(i)];

    for ii = 63:75
        fprintf("%d ", ii);
        processStones();
        clearStones();
    end

    totalSum+=sum(counts);
    disp("");
end

totalSum
