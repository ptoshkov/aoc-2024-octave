global dat;
dat = cell2mat(importdata('day08.dat'));

function ixs = get_window_ixs(current_ix, dat)
    dat_ixs = reshape(1:numel(dat), rows(dat), columns(dat));
    [current_ix_row, current_ix_col] = ind2sub(size(dat), current_ix);
    ixs = dat_ixs(:, current_ix_col:end);
end

function res = is_valid_ix(ix, sz)
    res = true;

    if(ix(1) < 1) || (ix(1) > sz(1))
        res = false;
        return;
    end

    if(ix(2) < 1) || (ix(2) > sz(2))
        res = false;
        return;
    end
end

function [ix1, ix2] = get_antinodes_ixs(antenna1_ix, antenna2_ix)
    vdistance = antenna2_ix(1) - antenna1_ix(1);
    hdistance = antenna2_ix(2) - antenna1_ix(2);
    ix1 = [antenna1_ix(1) - vdistance, antenna1_ix(2) - hdistance];
    ix2 = [antenna2_ix(1) + vdistance, antenna2_ix(2) + hdistance];
end

antinodelocs = [];

for ii = 1:numel(dat)
    currentel = dat(ii);

    if(currentel == '.')
        continue;
    end

    windowixs = get_window_ixs(ii, dat);

    for jj = 1:numel(windowixs)
        adjacentelix = windowixs(jj);

        if(ii == adjacentelix)
            continue;
        end

        adjacentel = dat(adjacentelix);

        if(adjacentel ~= currentel)
            continue;
        end

        [currentelsub1, currentelsub2] = ind2sub(size(dat), ii);
        [adjacentelsub1, adjacentelsub2] = ind2sub(size(dat), adjacentelix);

        [ix1, ix2] = get_antinodes_ixs([currentelsub1, currentelsub2], [adjacentelsub1, adjacentelsub2]);

        if(is_valid_ix(ix1, size(dat)))
            % disp(currentel)
            % disp("ix1")
            % disp(ix1)
            antinodelocs = [antinodelocs; ix1];
        end

        if(is_valid_ix(ix2, size(dat)))
            % disp(currentel)
            % disp("ix2")
            % disp(ix2)
            antinodelocs = [antinodelocs; ix2];
        end
    end
end

assert(357 == rows(unique(antinodelocs, 'rows')));

function ixs = get_antinodes_ixs_p2(antenna1_ix, antenna2_ix)
    global dat;

    ixs = [antenna1_ix; antenna2_ix];
    vdistance = antenna2_ix(1) - antenna1_ix(1);
    hdistance = antenna2_ix(2) - antenna1_ix(2);

    while(true)
        ix1 = ixs(1, :);
        ix0 = [ix1(1) - vdistance, ix1(2) - hdistance];

        if(is_valid_ix(ix0, size(dat)))
            ixs = [ix0; ixs];
        else
            break;
        end
    end

    while(true)
        ix1 = ixs(end, :);
        ix2 = [ix1(1) + vdistance, ix1(2) + hdistance];

        if(is_valid_ix(ix2, size(dat)))
            ixs = [ixs; ix2];
        else
            break;
        end
    end
end

antinodelocs = [];

for ii = 1:numel(dat)
    currentel = dat(ii);

    if(currentel == '.')
        continue;
    end

    windowixs = get_window_ixs(ii, dat);

    for jj = 1:numel(windowixs)
        adjacentelix = windowixs(jj);

        if(ii == adjacentelix)
            continue;
        end

        adjacentel = dat(adjacentelix);

        if(adjacentel ~= currentel)
            continue;
        end

        [currentelsub1, currentelsub2] = ind2sub(size(dat), ii);
        [adjacentelsub1, adjacentelsub2] = ind2sub(size(dat), adjacentelix);

        ixs = get_antinodes_ixs_p2([currentelsub1, currentelsub2], [adjacentelsub1, adjacentelsub2]);

        for kk = 1:rows(ixs)
            ix = ixs(kk, :);

            if(is_valid_ix(ix, size(dat)))
                antinodelocs = [antinodelocs; ix];
            end
        end
    end
end

uniqueantinodelocs = unique(antinodelocs, 'rows');
assert(1266 == rows(uniqueantinodelocs));


