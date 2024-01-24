clc
clf
clear
x = 1;
y = 0;
plot(x,y); hold on; grid on
%xline(0)
%xline(8)
%yline(0)
%yline(8)
axis([-1 9 -1 9])
t = 1;


%import piece images


[wpawn,~,palpha] = imread('wpawn.png');
wpawn = flipud(wpawn);
palpha = flipud(palpha);

bpawn = imread('bpawn.png');
bpawn = flipud(bpawn);

[wrook,~,ralpha] = imread('wrook.png');
wrook = flipud(wrook);
ralpha = flipud(ralpha);

brook = imread('brook.png');
brook = flipud(brook);

[wknight,~,kalpha] = imread('wknight.png');
wknight = flipud(wknight);
kalpha = flipud(kalpha);

bknight = imread('bknight.png');
bknight = flipud(bknight);

[wbishop,~,balpha] = imread('wbishop.png');
wbishop = flipud(wbishop);
balpha = flipud(balpha);

bbishop = imread('bbishop.png');
bbishop = flipud(bbishop);

[wqueen,~,qalpha] = imread('wqueen.png');
wqueen = flipud(wqueen);
qalpha = flipud(qalpha);

bqueen = imread('bqueen.png');
bqueen = flipud(bqueen);

[wking,~,Kalpha] = imread('wking.png');
wking = flipud(wking);
Kalpha = flipud(Kalpha);

bking = imread('bking.png');
bking = flipud(bking);

bpieces = [wpawn wrook wknight wbishop wqueen wking;
           bpawn brook bknight bbishop bqueen bking];
bpieces1 = ["wpawn" "wrook" "wknight" "wbishop" "wqueen" "wking";
           "bpawn" "brook" "bknight" "bbishop" "bqueen" "bking"];

background = imread('background.jpg');
background = flipud(background);







boardid = "";
boardn = bnum(boardid,i);
game = true;

%letters and numbers on side of board
ppos = text(0.5,-0.5,"A");
ppos = text(1.5,-0.5,"B");
ppos = text(2.5,-0.5,"C");
ppos = text(3.5,-0.5,"D");
ppos = text(4.5,-0.5,"E");
ppos = text(5.5,-0.5,"F");
ppos = text(6.5,-0.5,"G");
ppos = text(7.5,-0.5,"H");
for i =0:1:7
    istr = int2str(i+1);
    ppos=text(-0.5,i + 0.5,istr);
end

%White piece setup
board(8,8) = "wrook1";
board(8,1) = "wrook2";
for i = 1:1:8
    board(7,i) = "wpawn" + i;
end
board(8,2) = "wknight1";
board(8,7) = "wknight2";
board(8,3) = "wbishop1";
board(8,6) = "wbishop2";
board(8,4) = "wqueen";
board(8,5) = "wking";

%Black piece setup
board(1,8) = "brook2";
board(1,1) = "brook1";
for i = 1:1:8
    board(2,i) = "bpawn" + i;
end
board(1,2) = "bknight1";
board(1,7) = "bknight2";
board(1,3) = "bbishop1";
board(1,6) = "bbishop2";
board(1,4) = "bqueen";
board(1,5) = "bking";
for i=1:1:40
    fprintf('\n')
end


%background visual

image(background,'xdata',[0,8],'ydata',[0,8]);

%pawn visuals
for i = 0:1:7
    image(wpawn,'xdata',[i,i+1],'ydata',[1 2],'AlphaData',palpha);
end
for i = 0:1:7
    image(bpawn,'xdata',[i,i+1],'ydata',[6,7],'AlphaData',palpha);
end


%rook visuals
image(wrook,'xdata',[0,1],'ydata',[0 1],'AlphaData',ralpha);
image(wrook,'xdata',[7,8],'ydata',[0 1],'AlphaData',ralpha);
image(brook,'xdata',[0,1],'ydata',[7 8],'AlphaData',ralpha);
image(brook,'xdata',[7,8],'ydata',[7,8],'AlphaData',ralpha);

%knight visuals
image(wknight,'xdata',[1,2],'ydata',[0 1],'AlphaData',kalpha);
image(wknight,'xdata',[6,7],'ydata',[0 1],'AlphaData',kalpha);
image(bknight,'xdata',[1,2],'ydata',[7 8],'AlphaData',kalpha);
image(bknight,'xdata',[6,7],'ydata',[7 8],'AlphaData',kalpha);

%bishop visuals
image(wbishop,'xdata',[2,3],'ydata',[0 1],'AlphaData',balpha);
image(wbishop,'xdata',[5,6],'ydata',[0 1],'AlphaData',balpha);
image(bbishop,'xdata',[2,3],'ydata',[7 8],'AlphaData',balpha);
image(bbishop,'xdata',[5,6],'ydata',[7 8],'AlphaData',balpha);

%queen visuals
image(wqueen,'xdata',[3,4],'ydata',[0 1],'AlphaData',qalpha);
image(bqueen,'xdata',[3,4],'ydata',[7 8],'AlphaData',qalpha);

%king visuals
image(wking,'xdata',[4,5],'ydata',[0 1],'AlphaData',Kalpha);
image(bking,'xdata',[4,5],'ydata',[7 8],'AlphaData',Kalpha);



pieces = ["pawn" "rook" "knight" "bishop" "queen" "king"];




kingtakesking = 0;

while game == true
    

    % Normal iteration

    move = input("Enter move (Ex. Queen D1-G4):\n" + ...
        "Type 'undo' at any time to undo move" + ...
        "\n ","s");
    
    
    move = char(lower(move));
    
    mpos = erase(move,pieces);
    mpos = erase(mpos, " ");
    oldpos = extractBefore(mpos,"-");
    newpos = extractAfter(mpos,"-");
    piece1 = erase(move,oldpos);
    piece1 = erase(piece1,newpos);
    piece1 = erase(piece1," -");

    [oy,ox] = find(boardn == oldpos);
    [ny,nx] = find(boardn == newpos);
    newpiece = board(ny,nx);
    oldpiece = board(oy,ox);
    if isempty(newpiece) == 0
        if contains(newpiece,"king") && contains(oldpiece,"king")
            kingtakesking = 1;
        else
            kingtakesking = 0;
        end
    end
    val = contains(board(oy,ox),piece1);
    if isempty(ny) || isempty(nx)
        val = 0;
    end
    contain = contains(move,pieces);
    if contains("undo",move)
            contain = 1;
            val = 1;
    end
    
    
    % Checks if the user input is invalid
    while contain == 0 || val == 0 || kingtakesking == 1
        disp("Please enter a valid piece and position")
        move = input("Enter move: ", "s");
        move = char(lower(move));
    
        mpos = erase(move,pieces);
        mpos = erase(mpos, " ");
        oldpos = extractBefore(mpos,"-");
        newpos = extractAfter(mpos,"-");
        piece1 = erase(move,oldpos);
        piece1 = erase(piece1,newpos);
        piece1 = erase(piece1," -");

        contain = contains(move,pieces);
        [oy,ox] = find(boardn == oldpos);
        [ny,nx] = find(boardn == newpos);
        newpiece = board(ny,nx);
        oldpiece = board(oy,ox);
        if isempty(newpiece) == 0
            if contains(newpiece,"king") && contains(oldpiece,"king")
                kingtakesking = 1;
            else
                kingtakesking = 0;
            end
        end
        val = contains(board(oy,ox),piece1);
        if isempty(ny) || isempty(nx)
            val = 0;
        end

        if contains("undo",move)
            contain = 1;
            val = 1;
        end
    end


    % If the player types undo

    if contains("undo",move)
    t = t - 1;
    board = memboard;
    mpiece = picpiece(piece1,t,bpieces,bpieces1);
    board = refresh(board,bpieces,bpieces1);
    for i=1:1:40
    fprintf('\n')
    end
    move = input("Enter move (Ex. Queen D1-G4):\n" + ...
        "Type 'undo' at any time to undo move" + ...
        "\n ","s");
    

    
    move = char(lower(move));
    mpos = erase(move,pieces);
    mpos = erase(mpos, " ");
    oldpos = extractBefore(mpos,"-");
    newpos = extractAfter(mpos,"-");
    piece1 = erase(move,oldpos);
    piece1 = erase(piece1,newpos);
    piece1 = erase(piece1," -");

    [oy,ox] = find(boardn == oldpos);
    [ny,nx] = find(boardn == newpos);
    newpiece = board(ny,nx);
    oldpiece = board(oy,ox);
    if isempty(newpiece) == 0
        if contains(newpiece,"king") && contains(oldpiece,"king")
            kingtakesking = 1;
        else
            kingtakesking = 0;
        end
    end
    val = contains(board(oy,ox),piece1);
    if isempty(ny) || isempty(nx)
        val = 0;
    end
    contain = contains(move,pieces);

    while contain == 0 || val == 0 || kingtakesking == 1
        disp("Please enter a valid piece and position")
        move = input("Enter move: ", "s");
        move = char(lower(move));
    
        mpos = erase(move,pieces);
        mpos = erase(mpos, " ");
        oldpos = extractBefore(mpos,"-");
        newpos = extractAfter(mpos,"-");
        piece1 = erase(move,oldpos);
        piece1 = erase(piece1,newpos);
        piece1 = erase(piece1," -");

        contain = contains(move,pieces);
        [oy,ox] = find(boardn == oldpos);
        [ny,nx] = find(boardn == newpos);
        newpiece = board(ny,nx);
        oldpiece = board(oy,ox);
        if isempty(newpiece) == 0
            if contains(newpiece,"king") && contains(oldpiece,"king")
                kingtakesking = 1;
            else
                kingtakesking = 0;
            end
            
        end
    val = contains(board(oy,ox),piece1);
    if isempty(ny) || isempty(nx)
        val = 0;
    end
        
    end

    
    % Processes user input

    newboardpos = pos(boardn,oldpos,newpos,ppos,pieces,mpiece);
    board = takes(board,boardn,piece1,oldpos,newpos,t,pieces,mpiece);
    board = realposition(board,oldpos,newpos,boardn);
    board = refresh(board,bpieces,bpieces1);
    for i=1:1:40
    fprintf('\n')
    end
    else
    memboard = board;
    mpiece = picpiece(piece1,t,bpieces,bpieces1);
    newboardpos = pos(boardn,oldpos,newpos,ppos,pieces,mpiece);
    board = takes(board,boardn,piece1,oldpos,newpos,t,pieces,mpiece);
    board = realposition(board,oldpos,newpos,boardn);
    board = refresh(board,bpieces,bpieces1);
    for i=1:1:40
    fprintf('\n')
    end
    end

    
t = t + 1;    
end





%% Functions



% refresh board function

function board = refresh(board,bpieces,bpieces1)
clf
x = 1;
y = 0;
plot(x,y); hold on; grid on
%xline(0)
%xline(8)
%yline(0)
%yline(8)
axis([-1 9 -1 9])
ppos = text(0.5,-0.5,"A");
ppos = text(1.5,-0.5,"B");
ppos = text(2.5,-0.5,"C");
ppos = text(3.5,-0.5,"D");
ppos = text(4.5,-0.5,"E");
ppos = text(5.5,-0.5,"F");
ppos = text(6.5,-0.5,"G");
ppos = text(7.5,-0.5,"H");
for i =0:1:7
    istr = int2str(i+1);
    ppos = text(-0.5,i + 0.5,istr);
end

[wpawn,~,palpha] = imread('wpawn.png');
wpawn = flipud(wpawn);

bpawn = imread('bpawn.png');
bpawn = flipud(bpawn);

[wrook,~,ralpha] = imread('wrook.png');
wrook = flipud(wrook);

brook = imread('brook.png');
brook = flipud(brook);

[wknight,~,kalpha] = imread('wknight.png');
wknight = flipud(wknight);

bknight = imread('bknight.png');
bknight = flipud(bknight);

[wbishop,~,balpha] = imread('wbishop.png');
wbishop = flipud(wbishop);

bbishop = imread('bbishop.png');
bbishop = flipud(bbishop);

[wqueen,~,qalpha] = imread('wqueen.png');
wqueen = flipud(wqueen);

bqueen = imread('bqueen.png');
bqueen = flipud(bqueen);

[wking,~,Kalpha] = imread('wking.png');
wking = flipud(wking);

bking = imread('bking.png');
bking = flipud(bking);


background = imread('background.jpg');
background = flipud(background);
image(background,'xdata',[0,8],'ydata',[0,8])


%white pieces
for j = 1:6
    for i = 1:8
        [p,q] = find(board == (bpieces1(1,j) + num2str(i)));
        if isempty([p,q])
            i = i + 1;
            [p,q] = find(board == (bpieces1(1,j) + num2str(i)));
        end
        

        if j == 1
            if isempty([p,q]) == 0
                image(flipud(wpawn),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',palpha);
            end
        end
        if j == 2
            if i <=2
                if isempty([p,q]) == 0
                    image(flipud(wrook),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',ralpha);
                end
            end
        end
        if j == 3
            if i <= 2
                if isempty([p,q]) == 0
                    image(flipud(wknight),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',kalpha);
                end
            end
        end
        if j == 4
            if i <= 2
                if isempty([p,q]) == 0
                    image(flipud(wbishop),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',balpha);
                end
            end
        end
    end
for l = 1:2
    [p,q] = find(board == bpieces1(1,j));
    if j == 5
        if isempty([p,q]) == 0
            image(flipud(wqueen),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',qalpha);
        end
    end

    if j == 6
        if isempty([p,q]) == 0
            image(flipud(wking),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',Kalpha);
        end 
    end
end

end

%black pieces
for j = 1:6
    for i = 1:8
        [p,q] = find(board == (bpieces1(2,j) + num2str(i)));
        if isempty([p,q])
            if i < 8
                i = i + 1;
                [p,q] = find(board == (bpieces1(2,j) + num2str(i)));
                
            end
        end
        if j == 1
            if isempty([p,q]) == 0
                if isempty([p,q]) == 0
                    image(flipud(bpawn),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',palpha);
                end
            end
        end
        if j == 2
            
            if i <=2
                if isempty([p,q]) == 0
                    image(flipud(brook),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',ralpha);
                end
            end
        end
        if j == 3
            if i <= 2
                if isempty([p,q]) == 0
                    image(flipud(bknight),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',kalpha);
                end
            end
        end
        if j == 4
            if i <= 2
                if isempty([p,q]) == 0
                    image(flipud(bbishop),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',balpha);
                end
            end
        end
    end
for l = 1:2
    [p,q] = find(board == bpieces1(2,j));
    if j == 5
        if isempty([p,q]) == 0
            image(flipud(bqueen),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',qalpha);
        end
    end

    if j == 6
        if isempty([p,q]) == 0
            image(flipud(bking),'xdata',[q-1,q],'ydata',[8-p+1,8-p],'AlphaData',Kalpha);
        end 
    end
end

end

end


% Taking piece function
 
function board = takes(board,boardn,piece1,oldpos,newpos,t,pieces,mpiece)
n = rem(t,2);
[oldy,oldx] = find(boardn == oldpos);
[newy,newx] = find(boardn == newpos);
oldpiece = board(oldy,oldx);
ispiece = board(newy,newx);
ispiece1 = erase(ispiece,pieces);
if ismissing(ispiece) == 0
    ispiece = char(ispiece);
    ispiece2 = ispiece(2:end-1);
    ispiece2 = string(ispiece2);
    mat = matches(pieces(1:5),ispiece2);
    if nonzeros(mat) == 1
        mat = 1;
    end
end

contains(ispiece1,'b');
contains(ispiece1,'w');



if contains(ispiece1,'b')
    if n == 1
        if mat == 1
            board(newy,newx) = oldpiece;
            image(mpiece,'xdata',[newx-1,newx],'ydata',[8-newy,8-newy+1]);
        end
    end
end
if contains(ispiece1,'w')
    if n == 0
        if mat == 1
            board(newy,newx) = oldpiece;
            image(mpiece,'xdata',[newx-1,newx],'ydata',[8-newy,8-newy+1]);
        end
    end

end


end





%Identifies piece to use as png for move

function mpiece = picpiece(piece1,t,bpieces,bpieces1)
n = rem(t,2);
if n == 1
    piece1 = "w" + piece1;
end
if n == 0
    piece1 = "b" + piece1;
end
[p,q] = find(bpieces1 == piece1);
q = q * 60;
o = q - 59;
p = p * 60;
k = p - 59;
mpiece = bpieces(k:p,o:q);

end


%moves pieces on visible board

function newboardpos = pos(boardn,oldpos,newpos,ppos,pieces,mpiece)
[oldy,oldx] = find(boardn == oldpos);
[newy,newx] = find(boardn == newpos);
newboardpos = image(mpiece,'xdata',[newx-1,newx],'ydata',[8-newy,8-newy+1]);
end


function board = realposition(board,oldpos,newpos,boardn)
[oldy,oldx] = find(boardn == oldpos);
[newy,newx] = find(boardn == newpos);
board(newy,newx) = board(oldy,oldx);
board(oldy,oldx) = missing;


end


%Board numbers and letters

function boardn = bnum(boardid,i)
boardid(8,8) = "1h";
%adds a1-a8
for i = 1:1:8
        boardid(i,1) = "a" + i;
end
%adds b1-b8
for i = 1:1:8
        boardid(i,2) = "b" + i;
end
%adds c1-c8
for i = 1:1:8
        boardid(i,3) = "c" + i;
end
%adds d1-d8
for i = 1:1:8
        boardid(i,4) = "d" + i;
end
%adds e1-e8
for i = 1:1:8
        boardid(i,5) = "e" + i;
end
%adds f1-f8
for i = 1:1:8
        boardid(i,6) = "f" + i;
end
%adds g1-g8
for i = 1:1:8
        boardid(i,7) = "g" + i;
end
%adds h1-h8
for i = 1:1:8
        boardid(i,8) = "h" + i;
end
for i = 1:1:8
    boardid;
end
boardn(1,:) = boardid(8,:);
boardn(2,:) = boardid(7,:);
boardn(3,:) = boardid(6,:);
boardn(4,:) = boardid(5,:);
boardn(5,:) = boardid(4,:);
boardn(6,:) = boardid(3,:);
boardn(7,:) = boardid(2,:);
boardn(8,:) = boardid(1,:);
end

