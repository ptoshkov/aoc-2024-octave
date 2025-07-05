global result;
dat = fileread('day03.dat');
pattern = 'mul\(([0-9]+),([0-9]+)\)';
matches = regexp(dat, pattern, 'match');
result = 0;

function mul(x,y)
    global result;
    result+=(x*y);
end

for i = 1:length(matches)
    str = matches{i};
    eval(str);
end

assert(182619815 == result);

clear all;

global result;
global enabled;
dat = fileread('day03.dat');
pattern = '(mul\(([0-9]+),([0-9]+)\)|do\(\)|don.t\(\))';
matches = regexp(dat, pattern, 'match');
result = 0;
enabled = true;

function mul(x,y)
    global result;
    global enabled

    if(enabled)
        result+=(x*y);
    end
end

function doo()
    global enabled;
    enabled = true;
end

function dont()
    global enabled;
    enabled = false;
end

for i = 1:length(matches)
    str = matches{i};
    
    if(isequal(str,"don't()"))
        dont();
        continue;
    end
    
    if(isequal(str,"do()"))
        doo();
        continue;
    end

    eval(str);
end

assert(80747545 == result);



