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

stonesPost50 = [];
countsPost50 = [];
sumPost50 = 0;

for i = 1:numel(stonesPost25)
    disp(i)
    stones = [stonesPost25(i)];
    counts = [countsPost25(i)];

    for ii = 26:50
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

for i = 1:numel(stonesPost50)
    disp(i)
    stones = [stonesPost50(i)];
    counts = [countsPost50(i)];

    for ii = 51:75
        fprintf("%d ", ii);
        processStones();
        clearStones();
    end

    totalSum+=sum(counts);
    disp("");
end

totalSum
