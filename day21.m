% solution based on https://www.reddit.com/r/adventofcode/comments/1hj2odw/comment/m4ui1sy/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
% and https://topaz.github.io/paste/#XQAAAQDAAQAAAAAAAAAzHIoib6poHLpewxtGE3pTrRdzrponKxDhfDpmqUbmwC6eNytFiAtpkMiCqeghNLV2zaw8KSdzSEgXG3fzAq9S86ZmDlpLKRv41QjaGoPMIOjliWR5SLyfp1w/AAVy/FzxwYh6hhYb8UqJYJH75Rz/cc8aK+sCP/lFJwcsXr124+25Uaasqd4vs7FGUGyyagyZ+JDL4iM9ivvgbtVIFkoRRNt583UCDIN1BOtDZG8xZmrmdt77IqHBrIqN+4+qo2Ju43pDk/eukPUU+WMG1AluFJzBpCioq7ZG6s8nyVhCUxzPWdQ5V98X3+VKzUkz/QC1aEpPZTeGPR725wr0PRLVKq6XH/Ld4D/NDOVutTbAVC0lF+yrkOUQ1mqw7EQ2PsqGertTc1QLKEO0SPwfrB11LnQK4f+B83UA
sum1 = 0;
sum2 = 0;

function sequence = get_sequence(endpoints)
    combined_keypad = [
        "789";
        "456";
        "123";
        "#0A";
        "<v>"
    ];
    start_idx = find(combined_keypad == endpoints(1));
    [y1, x1] = ind2sub(size(combined_keypad), start_idx);
    end_idx = find(combined_keypad == endpoints(2));
    [y2, x2] = ind2sub(size(combined_keypad), end_idx);
    sequence = ['>'*ones(1, x2 - x1), 'v'*ones(1, y2 - y1), '0'*ones(1, y1 - y2), '<'*ones(1, x1 - x2)];
    sequence = char(sequence);

    if(all([4, 1] == [y1,x2]))
        return;
    end

    if(all([4, 1] == [y2,x1]))
        return;
    end

    sequence = flip(sequence);
end

function keystroke_cnt = get_keystroke_cnt(sequence, robot_cnt)
    persistent get_keystroke_cnt_memoized = memoize (@get_keystroke_cnt);
    get_keystroke_cnt_memoized.CacheSize = 1e6;
    keystroke_cnt = 0;

    if(robot_cnt >= 0)
        Asequence = ['A', sequence];
        sequenceA = [sequence, 'A'];

        for ii = 1:numel(Asequence)
            endpoints = [Asequence(ii), sequenceA(ii)];
            new_sequence = get_sequence(endpoints);
            keystroke_cnt+=get_keystroke_cnt_memoized(new_sequence, robot_cnt - 1);
        end
    else
        keystroke_cnt = length(sequence) + 1;
    end
end

sum1+=(964*get_keystroke_cnt('964', 2));
sum1+=(246*get_keystroke_cnt('246', 2));
sum1+=(973*get_keystroke_cnt('973', 2));
sum1+=(682*get_keystroke_cnt('682', 2));
sum1+=(180*get_keystroke_cnt('180', 2))
sum2+=(964*get_keystroke_cnt('964', 25));
sum2+=(246*get_keystroke_cnt('246', 25));
sum2+=(973*get_keystroke_cnt('973', 25));
sum2+=(682*get_keystroke_cnt('682', 25));
sum2+=(180*get_keystroke_cnt('180', 25))
assert(sum1 == 212488);
assert(sum2 == 258263972600402);
