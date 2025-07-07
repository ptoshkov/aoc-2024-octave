% Combo operands:
% 0-3: literal values 0-3
% 4: value of A
% 5: value of B
% 6: value of C
% 
% adv
%     value 0
%     combo operand x
%     A=floor(A/(2^x))
% 
% bxl
%     value 1
%     literal operand x
%     B = bitxor(B, x)
% 
% bst
%     value 2
%     combo operand x
%     B = mod(x, 8)
% 
% jnz
%     value 3
%     literal operand x
%     IF A ~= 0
%         jump to index x
% 
% bxc
%     value 4
%     operand ignored
%     B = bitxor(B, C)
% 
% out
%     value 5
%     combo operand x
%     OUT = mod(x, 8), i.e. disp(mod(x, 8))
% 
% bdv
%     value 6
%     combo operand x
%     B=floor(A/(2^x))
% 
% cdv
%     value 7
%     combo operand x
%     C=floor(A/(2^x))

global A;
global B;
global C;
global Index;
global Output;

Index = 1;
Output = [];

A = 66245665;
B = 0;
C = 0;
Program = {
"bst(A)";
"bxl(7)";
"cdv(B)";
"bxl(7)";
"bxc()";
"adv(3)";
"out(B)";
"jnz(0)";
};

% A = 729;
% B = 0;
% C = 0;
% Program = {
% "adv(1)";
% "out(A)";
% "jnz(0)"
% };

function jnz(x)
    global A;
    global Index;

    if(A ~= 0)
        Index = 1 + x/2;
    else
        Index++;
    end
end

function out(x)
    global Index;
    global Output;

    y = mod(x, 8);
    Output = [Output, y];
    Index++;
end

function adv(x)
    global Index;
    global A;

    A=floor(A/(2^x));
    Index++;
end

function bxc()
    global Index;

    global B;
    global C;

    B = bitxor(B, C);
    Index++;
end

function bxl(x)
    global Index;

    global B;

    B = bitxor(B, x);
    Index++;
end

function cdv(x)
    global Index;

    global C;
    global A;

    C=floor(A/(2^x));
    Index++;
end

function bst(x)
    global Index;

    global B;

    B = mod(x, 8);
    Index++;
end

while(Index <= numel(Program))
    cmd = Program{Index};
    eval(cmd);
end

% assert(Output == "1,4,6,1,6,4,3,0,3")

ProgramMat = [2 4 1 7 7 5 1 7 4 6 0 3 5 5 3 0];
Program = {
"bst(A)";
"bxl(7)";
"cdv(B)";
"bxl(7)";
"bxc()";
"adv(3)";
"out(B)";
"jnz(0)";
};
% ProgramMat = [0 3 5 4 3 0];
% Program = {
% "adv(3)";
% "out(A)";
% "jnz(0)"
% };

AInit = 281474976710600;
szOutputInit = 0;

while(true)
    Index = 1;
    Output = [];
    A = AInit;
    B = 0;
    C = 0;

    while(Index <= numel(Program))
        cmd = Program{Index};
        eval(cmd);
    end

    if(isequal(ProgramMat , Output ))
        break;
    end

    szOutput = numel(Output);
    
    if(szOutput ~= szOutputInit)
        disp(numel(Output));
        szOutputInit = szOutput;
    end
    
    AInit++;
end






