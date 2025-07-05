dat=cell2mat(importdata('day06.dat'));

function dat = move(dat)
    startix = find(dat == '^');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        dat(startix) = '.';
        rowscnt--;

        try
            dat(rowscnt, colscnt) = '^';
        end

        return;
    end

    startix = find(dat == 'v');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        dat(startix) = '.';
        rowscnt++;

        if(rowscnt <= rows(dat))
            dat(rowscnt, colscnt) = 'v';
        end

        return;
    end

    startix = find(dat == '>');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        dat(startix) = '.';
        colscnt++;

        if(colscnt <= columns(dat))
            dat(rowscnt, colscnt) = '>';
        end

        return;
    end

    startix = find(dat == '<');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        dat(startix) = '.';
        colscnt--;

        try
            dat(rowscnt, colscnt) = '<';
        end

        return;
    end
end

function res = left_map(dat)
    res = true;

    if(sum(dat(:) == '^'))
        res = false;
        return;
    end
    if(any(dat(:) == 'v'))
        res = false;
        return;
    end
    if(any(dat(:) == '>'))
        res = false;
        return;
    end
    if(any(dat(:) == '<'))
        res = false;
        return;
    end
end

function blocked = is_blocked(dat)
    startix = find(dat == '^');
    blocked = true;

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        rowscnt--;
        next = '.';

        try
            next = dat(rowscnt, colscnt);
        end

        if(next == '.')
            blocked = false;
        end

        return;
    end

    startix = find(dat == 'v');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        rowscnt++;
        next = '.';

        try
            next = dat(rowscnt, colscnt);
        end

        if(next == '.')
            blocked = false;
        end

        return;
    end

    startix = find(dat == '>');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        colscnt++;
        next = '.';

        try
            next = dat(rowscnt, colscnt);
        end

        if(next == '.')
            blocked = false;
        end

        return;
    end

    startix = find(dat == '<');

    if(startix)
        [rowscnt, colscnt] = ind2sub(size(dat), startix);
        colscnt--;
        next = '.';

        try
            next = dat(rowscnt, colscnt);
        end

        if(next == '.')
            blocked = false;
        end

        return;
    end
end

function dat = roteit(dat)
    startix = find(dat == '^');
    
    if(startix)
        dat(startix) = '>';

        return;
    end

    startix = find(dat == 'v');

    if(startix)
        dat(startix) = '<';

        return;
    end

    startix = find(dat == '>');

    if(startix)
        dat(startix) = 'v';

        return;
    end

    startix = find(dat == '<');

    if(startix)
        dat(startix) = '^';

        return;
    end
end

function idx = get_idx(dat)
    idx = find(dat == '^');

    if(idx)
        return;
    end

    idx = find(dat == 'v');

    if(idx)
        return;
    end

    idx = find(dat == '>');

    if(idx)
        return;
    end

    idx = find(dat == '<');

    if(idx)
        return;
    end
end

idxs = [];

while(~left_map(dat))
    idxs = [idxs, get_idx(dat)];
    idxs = unique(idxs);

    if(is_blocked(dat))
        dat = roteit(dat);
    else
        dat = move(dat);
    end
end

assert(4776 == numel(idxs));

dat=cell2mat(importdata('day06.dat'));
dats_with_obstacle = {};
obstacle_locations = 0;

for i = 1:numel(dat)
    dat_with_obstacle = dat;
    
    if(dat_with_obstacle(i) == '.')
        dat_with_obstacle(i) = 'O';
        dats_with_obstacle = [dats_with_obstacle, dat_with_obstacle];
    end
end

disp("dats_with_obstacle:")
disp(numel(dats_with_obstacle))

for i = 1:numel(dats_with_obstacle)
    disp(i)
    dat = dats_with_obstacle{i};
    steps = 0;

    while(~left_map(dat))
        if(is_blocked(dat))
            dat = roteit(dat);
        else
            dat = move(dat);
            steps++;
        end

        if(steps > numel(dat))
            disp("stuck")
            obstacle_locations++;
            break;
        end
    end
end

assert(1586 == obstacle_locations);
