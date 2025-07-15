dat = importdata ('day22.dat');

function number = evolveNumber(number, steps)
    for ii = 1:steps
        number = mod(bitxor(number, number*64), 16777216);
        number = mod(bitxor(number, floor(number/32)), 16777216);
        number = mod(bitxor(number, number*2048), 16777216);
    end
end

% assert(17005483322 == sum(evolveNumber(dat, 2000)));

%dat = [
%1;
%2;
%3;
%2024
%];

numbers = dat;
prices = [];
priceChanges = [];

for ii = 1:2000
    currentPrices = rem(numbers, 10);
    numbers = evolveNumber(numbers, 1);
    newPrices = rem(numbers, 10);
    prices = [prices, newPrices];
    priceChanges = [priceChanges, newPrices - currentPrices];
end

disp("found price changes")
size(priceChanges)
fourDigitSequences = [];

for ii = 1:rows(priceChanges)
    ii
    sequencesRow = priceChanges(ii, :);
    fourDigitSequencesTmp = [];

    for jj = 1:(columns(sequencesRow) - 3)
        sequence = sequencesRow(jj:(jj + 3));
        fourDigitSequencesTmp = [fourDigitSequencesTmp; sequence];
    end

    fourDigitSequences = [fourDigitSequences; fourDigitSequencesTmp];
    fourDigitSequences = unique(fourDigitSequences, 'rows');
end

disp("found four-digit sequences")
size(fourDigitSequences)
maxPrice = 0;

for ii = 1:rows(fourDigitSequences)
    ii
    sequence = fourDigitSequences(ii, :);
    totalPrice = 0;

    % attempt to sell at this sequence
    for jj = 1:rows(priceChanges)
        priceChangesRow = priceChanges(jj, :);
        sequenceIndex = [];

        for kk = 1:(numel(priceChangesRow) - 3)
            if((priceChangesRow(kk) == sequence(1)) && (priceChangesRow(kk + 1) == sequence(2)) && ...
                (priceChangesRow(kk + 2) == sequence(3)) && (priceChangesRow(kk + 3) == sequence(4)))
                sequenceIndex = kk;
                break;
            end
        end

        if(isempty(sequenceIndex))
            continue;
        end

        sequenceIndex = sequenceIndex(1);
        totalPrice+=prices(jj, sequenceIndex + 3);
    end

    maxPrice = max(maxPrice, totalPrice);
end

maxPrice
