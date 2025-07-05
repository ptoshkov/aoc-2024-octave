dat = importdata('day04.dat');
dat = cell2mat(dat);
occurs = 0;

for i = 1:numel(dat)
    [row, col] = ind2sub(size(dat), i);

    % check horizontal
    hcolend = col + 3;

    if(hcolend <= columns(dat))
        word = dat(row, col:hcolend);
        if(isequal(word, "XMAS"))
            occurs++;
        end
        if(isequal(word, "SAMX"))
            occurs++;
        end
    end

    %check vertical
    vrowend = row + 3;

    if(vrowend <= rows(dat))
        word = dat(row:vrowend, col);
        if(isequal(transpose(word), "XMAS"))
            occurs++;
        end
        if(isequal(transpose(word), "SAMX"))
            occurs++;
        end
    end
    
    % check south-east
    ix1 = [row,col];
    ix2 = [row+1, col+1];
    ix3 = [row+2, col+2];
    ix4 = [row+3, col+3];

    try
        word = [dat(ix1(1), ix1(2)), dat(ix2(1), ix2(2)), dat(ix3(1), ix3(2)), dat(ix4(1), ix4(2))];
        if(isequal(word, "XMAS"))
            occurs++;
        end
        if(isequal(word, "SAMX"))
            occurs++;
        end
    end

    % check north-east
    ix1 = [row,col];
    ix2 = [row-1, col+1];
    ix3 = [row-2, col+2];
    ix4 = [row-3, col+3];

    try
        word = [dat(ix1(1), ix1(2)), dat(ix2(1), ix2(2)), dat(ix3(1), ix3(2)), dat(ix4(1), ix4(2))];
        if(isequal(word, "XMAS"))
            occurs++;
        end
        if(isequal(word, "SAMX"))
            occurs++;
        end
    end
end

assert(2557 == occurs);

occurs = 0;

for i = 1:numel(dat)
    [row, col] = ind2sub(size(dat), i);
    ix11 = [row, col];
    ix12 = [row+1, col+1];
    ix13 = [row+2, col+2];
    ix21 = [row+2, col];
    ix22 = [row+1, col+1];
    ix23 = [row, col+2];

    try
        word1 = [dat(ix11(1), ix11(2)), dat(ix12(1), ix12(2)), dat(ix13(1), ix13(2))];
        word2 = [dat(ix21(1), ix21(2)), dat(ix22(1), ix22(2)), dat(ix23(1), ix23(2))];

        if((isequal(word1, "MAS") || isequal(word1, "SAM")) && (isequal(word2, "MAS") || isequal(word2, "SAM")))
            occurs++;
        end
    end
end

assert(1854 == occurs);


