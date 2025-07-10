dat = cell2mat(importdata("day25.dat"));

lockIndices = [];
keyIndices = [];
idx = 1;

while(idx < rows(dat))
    if(isequal(dat(idx, :), "#####"))
        lockIndices(end+1) = idx;
    end

    if(isequal(dat(idx, :), "....."))
        keyIndices(end+1) = idx;
    end
    idx+=7;
end

[A, B] = meshgrid(lockIndices, keyIndices);
C = cat(2,A',B');
allCombinations = reshape(C,[],2);

sum1 = 0;

for ii = 1:rows(allCombinations)
    lockIndex = allCombinations(ii, 1);
    keyIndex = allCombinations(ii, 2);

    lock = dat(lockIndex:lockIndex + 6, :);
    key = dat(keyIndex:keyIndex + 6, :);

    if(any((((lock == '#') + (key == '#')) > 1)(:)))
        continue;
    end

    sum1++;
end

assert(sum1 == 2618);
