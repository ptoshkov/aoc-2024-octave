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

function solve(octalStr, loc)
    global Index;
    global Output;
    global A;
    global B;
    global C;

    ProgramMat = [2 4 1 7 7 5 1 7 4 6 0 3 5 5 3 0];
    ProgramMat = ProgramMat(loc:end);
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
    additions = ['0' '1' '2' '3' '4' '5' '6' '7'];

    for ii = 1:numel(additions)
        Index = 1;
        Output = [];
        toTry = [octalStr, additions(ii)];
        A = base2dec(toTry, 8);
        B = 0;
        C = 0;

        while(Index <= numel(Program))
            cmd = Program{Index};
            eval(cmd);
        end

        if(isequal(ProgramMat, Output ))
            % disp("FOUND")
            disp(toTry);
        end
    end
end

solve("", 16);
disp("")

solve("0", 15);
solve("7", 15);
disp("")

solve("72", 14);
solve("74", 14);
disp("")

solve("726", 13);
solve("742", 13);
solve("743", 13);
solve("746", 13);
disp("")

solve("7260", 12);
solve("7266", 12);
solve("7421", 12);
solve("7426", 12);
solve("7431", 12);
solve("7461", 12);
solve("7466", 12);
disp("")

solve("72600", 11);
solve("72603", 11);
solve("72660", 11);
solve("74211", 11);
solve("74213", 11);
solve("74261", 11);
solve("74610", 11);
solve("74613", 11);
solve("74660", 11);
disp("")

solve("726000", 10);
solve("726007", 10);
solve("726030", 10);
solve("726037", 10);
solve("726607", 10);
solve("742110", 10);
solve("742111", 10);
solve("742112", 10);
solve("742117", 10);
solve("742130", 10);
solve("742131", 10);
solve("742132", 10);
solve("742137", 10);
solve("742617", 10);
solve("746100", 10);
solve("746101", 10);
solve("746102", 10);
solve("746107", 10);
solve("746130", 10);
solve("746131", 10);
solve("746132", 10);
solve("746137", 10);
solve("746607", 10);
disp("");

solve("7421115",9);
solve("7421123",9);
solve("7421124",9);
solve("7421315",9);
solve("7421323",9);
solve("7421324",9);
solve("7461015",9);
solve("7461024",9);
solve("7461315",9);
solve("7461323",9);
solve("7461324",9);
disp("");

solve("74211150", 8);
solve("74211245", 8);
solve("74213150", 8);
solve("74213245", 8);
solve("74610245", 8);
solve("74613150", 8);
solve("74613245", 8);
disp("")

solve("742111503", 7);
solve("742131503", 7);
solve("746131503", 7);
disp("")

solve("7421115031", 6);
solve("7421115036", 6);
solve("7421315031", 6);
solve("7421315036", 6);
solve("7461315031", 6);
solve("7461315036", 6);
disp("")

solve("74211150314", 5);
solve("74211150362", 5);
solve("74211150366", 5);
solve("74213150314", 5);
solve("74213150362", 5);
solve("74213150366", 5);
solve("74613150314", 5);
solve("74613150362", 5);
solve("74613150366", 5);
disp("")

solve("742111503620", 4);
solve("742111503621", 4);
solve("742111503660", 4);
solve("742111503661", 4);
solve("742111503662", 4);
solve("742131503620", 4);
solve("742131503621", 4);
solve("742131503660", 4);
solve("742131503661", 4);
solve("742131503662", 4);
solve("746131503620", 4);
solve("746131503621", 4);
solve("746131503660", 4);
solve("746131503661", 4);
solve("746131503662", 4);
disp("")

solve("7421115036601", 3);
solve("7421115036611", 3);
solve("7421115036621", 3);
solve("7421315036601", 3);
solve("7421315036611", 3);
solve("7421315036621", 3);
solve("7461315036601", 3);
solve("7461315036611", 3);
solve("7461315036621", 3);
disp("");

solve("74211150366011", 2);
solve("74211150366016", 2);
solve("74211150366116", 2);
solve("74211150366210", 2);
solve("74211150366216", 2);
solve("74213150366011", 2);
solve("74213150366016", 2);
solve("74213150366116", 2);
solve("74213150366210", 2);
solve("74213150366216", 2);
solve("74613150366011", 2);
solve("74613150366016", 2);
solve("74613150366116", 2);
solve("74613150366210", 2);
solve("74613150366216", 2);
disp("");

solve("742111503660163" , 1);
solve("742111503661160" , 1);
solve("742111503661163" , 1);
solve("742111503662104" , 1);
solve("742111503662105" , 1);
solve("742111503662163" , 1);
solve("742131503660163" , 1);
solve("742131503661160" , 1);
solve("742131503661163" , 1);
solve("742131503662104" , 1);
solve("742131503662105" , 1);
solve("742131503662163" , 1);
solve("746131503660163" , 1);
solve("746131503661160" , 1);
solve("746131503661163" , 1);
solve("746131503662104" , 1);
solve("746131503662105" , 1);
solve("746131503662163" , 1);
disp("")

base2dec("7421115036601633", 8) % lowest == 265061364597659
base2dec("7421115036601635", 8)
base2dec("7421115036611633", 8)
base2dec("7421115036611635", 8)
base2dec("7421115036621633", 8)
base2dec("7421115036621635", 8)
base2dec("7421315036601633", 8)
base2dec("7421315036601635", 8)
base2dec("7421315036611633", 8)
base2dec("7421315036611635", 8)
base2dec("7421315036621633", 8)
base2dec("7421315036621635", 8)
base2dec("7461315036601633", 8)
base2dec("7461315036601635", 8)
base2dec("7461315036611633", 8)
base2dec("7461315036611635", 8)
base2dec("7461315036621633", 8)
base2dec("7461315036621635", 8)








