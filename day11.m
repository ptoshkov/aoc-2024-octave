stones = [0 37551 469 63 1 791606 2065 9983586];
counts = [1 1 1 1 1 1 1 1];

function stones = stepStone(stone)
    stones = [];

    if(stone == 0)
            stones = [1];
    else
        digits = floor(log10(stone)) + 1;

        if(rem(digits, 2) == 0)
            tens = 10^(digits/2);
            stone1 = floor(stone/tens);
            stone2 = rem(stone, tens);
            stones = [stone1, stone2];
        else
            stones = [2024*stone];
        end
    end
end

for ii = 1:75
    disp(ii)
    newStones = [];
    newCounts = [];

    for jj = 1:numel(stones)
        stone = stones(jj);
        count = counts(jj);

        newStonesTmp = stepStone(stone);

        for ll = 1:numel(newStonesTmp)
            value = newStonesTmp(ll);
            
            if(any(newStones == value))
                newCounts(find(newStones == value))+=count;
            else
                newStones = [newStones, value];
                newCounts = [newCounts, count];
            end
        end
    end

    stones = newStones;
    counts = newCounts;
end

sum(counts)
% assert(241651071960597 == sum(counts))


