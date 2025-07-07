dat = importdata('day13.dat');
PRESSACOST = 3;
PRESSBCOST = 1;
score = 0;

function res = isInteger(value)
    res = false;

    if(abs(value - round(value)) < 1E-13)
        res = true;
    end
end

for ii = 1:3:numel(dat)
    buttonAStr = dat{ii};
    buttonBStr = dat{ii + 1};
    prizeStr = dat{ii + 2};

    % match all numbers
    pattern = '[0-9]+';

    buttonAVals = regexp(buttonAStr, pattern, 'match');
    A = [str2num(buttonAVals{1}); str2num(buttonAVals{2})];
    buttonBVals = regexp(buttonBStr, pattern, 'match');
    A = [A, [str2num(buttonBVals{1}); str2num(buttonBVals{2})]];
    prizeVals = regexp(prizeStr, pattern, 'match');
    B = [str2num(prizeVals{1}); str2num(prizeVals{2})];

    U = inverse(A)*B;
    u1 = U(1);
    u2 = U(2);

    if(isInteger(u1) && isInteger(u2))
        newScore = PRESSACOST*u1 + PRESSBCOST*u2;
        score+=newScore;
    end
end

% assert(26599 == score);

score = 0;

function res = isIntegerP2(value)
    res = false;

    if(abs(value - round(value)) < 1E-3)
        res = true;
    end
end

for ii = 1:3:numel(dat)
    disp(ii)
    buttonAStr = dat{ii};
    buttonBStr = dat{ii + 1};
    prizeStr = dat{ii + 2};

    % match all numbers
    pattern = '[0-9]+';

    buttonAVals = regexp(buttonAStr, pattern, 'match');
    A = [str2num(buttonAVals{1}); str2num(buttonAVals{2})];
    buttonBVals = regexp(buttonBStr, pattern, 'match');
    A = [A, [str2num(buttonBVals{1}); str2num(buttonBVals{2})]];
    prizeVals = regexp(prizeStr, pattern, 'match');
    B = [10000000000000 + str2num(prizeVals{1}); 10000000000000 + str2num(prizeVals{2})];

    U = inverse(A)*B
    u1 = U(1);
    u2 = U(2);

    if(U(1) < 0)
        continue;
    end

    if(U(2) < 0)
        continue;
    end

    if(isIntegerP2(u1) && isIntegerP2(u2))
        newScore = PRESSACOST*u1 + PRESSBCOST*u2;
        score+=newScore;
    end

    disp("");



    %pause(2)
end

score
% assert(106228669504887 == score);
