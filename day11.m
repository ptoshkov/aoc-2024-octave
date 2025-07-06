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

function [stone1, stone2] = processEvenNumberDigitsStone(value)
    valueStr = num2str(value);
    str1 = valueStr(1:numel(valueStr)/2);
    str2 = valueStr(1+numel(valueStr)/2:end);
    stone1 = str2num(str1);
    stone2 = str2num(str2);
end

function clearEmpty()
    global stones;
    global counts;

    stones(counts == 0) = [];
    counts(counts == 0) = [];
end

function processStones()
    global stones;
    global counts;
    stonesBackup = stones;
    countsBackup = counts;

    for ii = 1:numel(stonesBackup)
        assert(counts(ii) >= 0);
        if(counts(ii) <= 0)
            continue;
        end

        stone = stonesBackup(ii);

        for jj = 1:countsBackup(ii)
            counts(ii)--;

            if(stone == 0)
                appendStones(1);
            elseif(rem(numel(num2str(stone)), 2) == 0)
                [stone1, stone2] = processEvenNumberDigitsStone(stone);
                appendStones(stone1);
                appendStones(stone2);
            else
                appendStones(2024*stone)
            end
        end
    end
end

for ii = 1:25
    disp(ii);
    processStones();
    clearEmpty();
end

% assert(204022 == sum(counts));

for ii = 26:75
    disp(ii);
    processStones();
    clearEmpty();
end

sum(counts)
