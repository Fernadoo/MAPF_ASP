cell(0..11, 0..11).
block(0, 0).
block(0, 1).
block(0, 2).
block(0, 3).
block(0, 4).
block(0, 5).
block(0, 6).
block(0, 7).
block(0, 8).
block(0, 9).
block(0, 10).
block(0, 11).
block(1, 0).
block(1, 11).
block(2, 0).
block(2, 11).
block(3, 0).
block(3, 1).
block(3, 2).
block(3, 3).
block(3, 4).
block(3, 5).
block(3, 6).
block(3, 7).
block(3, 8).
block(3, 11).
block(4, 0).
block(4, 1).
block(4, 2).
block(4, 3).
block(4, 4).
block(4, 5).
block(4, 6).
block(4, 7).
block(4, 8).
block(4, 11).
block(5, 0).
block(5, 1).
block(5, 2).
block(5, 3).
block(5, 4).
block(5, 5).
block(5, 6).
block(5, 7).
block(5, 8).
block(5, 11).
block(6, 0).
block(6, 1).
block(6, 2).
block(6, 3).
block(6, 4).
block(6, 5).
block(6, 6).
block(6, 7).
block(6, 8).
block(6, 11).
block(7, 0).
block(7, 1).
block(7, 2).
block(7, 3).
block(7, 4).
block(7, 5).
block(7, 6).
block(7, 7).
block(7, 8).
block(7, 11).
block(8, 0).
block(8, 1).
block(8, 2).
block(8, 3).
block(8, 4).
block(8, 5).
block(8, 6).
block(8, 7).
block(8, 8).
block(8, 11).
block(9, 0).
block(9, 1).
block(9, 2).
block(9, 3).
block(9, 4).
block(9, 5).
block(9, 6).
block(9, 7).
block(9, 8).
block(9, 11).
block(10, 0).
block(10, 1).
block(10, 2).
block(10, 3).
block(10, 4).
block(10, 5).
block(10, 6).
block(10, 7).
block(10, 8).
block(10, 11).
block(11, 0).
block(11, 1).
block(11, 2).
block(11, 3).
block(11, 4).
block(11, 5).
block(11, 6).
block(11, 7).
block(11, 8).
block(11, 9).
block(11, 10).
block(11, 11).
goal1(G) :- G = (X, Y), X == 2, 1 <= Y, Y <= 10, cell(X, Y).
goal1(G) :- G = (X, Y), Y == 9, 2 <= X, X <= 10, cell(X, Y).
goal2(G) :- G = (X, Y), X == 2, 1 <= Y, Y <= 10, cell(X, Y).
goal2(G) :- G = (X, Y), Y == 9, 2 <= X, X <= 10, cell(X, Y).

init(Pos) :- Pos = (X, Y), 1 <= X, X <= 2, 1 <= Y, Y <= 10, cell(X, Y).
init(Pos) :- Pos = (X, Y), 9 <= Y, Y <= 10, 1 <= X, X <= 10, cell(X, Y).

gState(S) :- S = (L1, L2),
    L1 != L2,
    L1 = (X1, Y1), init(L1), cell(X1, Y1), not block(X1, Y1),
    L2 = (X2, Y2), init(L2), cell(X2, Y2), not block(X2, Y2).

trans(S1, A1, A2, S2) :- gState(S1), gState(S2), 
    S1 = (L11, L12),
    S2 = (L21, L22),
    L11 = (X11, Y11), L12 = (X12, Y12),
    L21 = (X21, Y21), L22 = (X22, Y22),
    move(X11, Y11, A1, X21, Y21),
    move(X12, Y12, A2, X22, Y22),
    (L11, L12) != (L22, L21).

move(X, Y, up, X-1, Y) :- action(X, Y, up).
move(X, Y, down, X+1, Y) :- action(X, Y, down).
move(X, Y, left, X, Y-1) :- action(X, Y, left).
move(X, Y, right, X, Y+1) :- action(X, Y, right).
move(X, Y, nil, X, Y) :- action(X, Y, nil).

action(X, Y, up) :- cell(X, Y), cell(X-1, Y),
    not block(X, Y), not block(X-1, Y).
action(X, Y, down) :- cell(X, Y), cell(X+1, Y),
    not block(X, Y), not block(X+1, Y).
action(X, Y, left) :- cell(X, Y), cell(X, Y-1),
    not block(X, Y), not block(X, Y-1).
action(X, Y, right) :- cell(X, Y), cell(X, Y+1),
    not block(X, Y), not block(X, Y+1).
action(X, Y, nil) :- cell(X, Y), cell(X, Y),
    not block(X, Y), not block(X, Y).

goal_gState(S) :- gState(S),
    S = (G1, G2), G1 != G2,
    goal1(G1), goal2(G2).

aState(AS) :- AS = (Self, Other2),
    Self = (X, Y), init(Self), cell(X, Y), not block(X, Y),
    near(Self, Other2).

near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 2, |Y1-Y2| <= 2,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

avai_action(AS, Action) :- aState(AS),
    AS = (Self, _),
    Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, _), goal1(G1).
goal2_aState(AS) :- aState(AS), AS = (G2, _), goal2(G2).

obs1(S, AS) :- gState(S),
    S = (L1, L2), 
    Self = L1, (Others2) = (L2),
    aState(AS), AS = (Self, L2),
    near(Self, L2).
obs1(S, AS) :- gState(S),
    S = (L1, L2), 
    Self = L1, (Others2) = (L2),
    aState(AS), AS = (Self, empty),
    not near(Self, L2).
obs2(S, AS) :- gState(S),
    S = (L1, L2), 
    Self = L2, (Others2) = (L1),
    aState(AS), AS = (Self, L1),
    near(Self, L1).
obs2(S, AS) :- gState(S),
    S = (L1, L2), 
    Self = L2, (Others2) = (L1),
    aState(AS), AS = (Self, empty),
    not near(Self, L1).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, _), not goal1(Self).
do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, _), not goal2(Self).

reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
    obs1(S1, AS1), do1(AS1, A1),
    obs2(S1, AS2), do2(AS2, A2),
    trans(S1, A1, A2, S2).
:- gState(S), not reached(S).

% cost(0..9900).
% dist(S, 0) :- goal_gState(S).
% dist(S1, C) :- not goal_gState(S1), reached(S1),
%     obs1(S1, AS1), do1(AS1, A1),
%     obs2(S1, AS2), do2(AS2, A2),
%     trans(S1, A1, A2, S2),
%     dist(S2, C-1), cost(C).

% #minimize {C, dist(S, C): dist(S, C)}.

p1(L1, L2, A) :- do1((L1, L2), A).
p2(L1, L2, A) :- do2((L1, L2), A).
% #show gState/1.
% #show goal1/1.
% #show goal2/1.
% #show aState/1.
#show p1/3.
#show p2/3.
% #show reached/1.
% #show dist/2.
