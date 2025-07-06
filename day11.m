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

for ii = 1:25
    disp(ii);
    processStones();
end
