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
block(3, 11).
block(4, 0).
block(4, 11).
block(5, 0).
block(5, 11).
block(6, 0).
block(6, 11).
block(7, 0).
block(7, 11).
block(8, 0).
block(8, 11).
block(9, 0).
block(9, 11).
block(10, 0).
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
goal1(G) :- G = (1, 1).
goal2(G) :- G = (10, 10).


% p1((1,1),nil).
% p1((1,2),left).
% p1((1,3),left).
% p1((1,4),left).
% p1((1,5),left).
% p1((1,6),left).
% p1((1,7),left).
% p1((1,8),left).
% p1((1,9),left).
% p1((1,10),down).
% p1((2,1),up).
% p1((2,2),down).
% p1((2,3),right).
% p1((2,4),right).
% p1((2,5),right).
% p1((2,6),right).
% p1((2,7),right).
% p1((2,8),right).
% p1((2,9),right).
% p1((2,10),down).
% p1((3,1),up).
% p1((3,2),right).
% p1((3,3),right).
% p1((3,4),right).
% p1((3,5),right).
% p1((3,6),right).
% p1((3,7),right).
% p1((3,8),right).
% p1((3,9),right).
% p1((3,10),down).
% p1((4,1),up).
% p1((4,2),down).
% p1((4,3),right).
% p1((4,4),right).
% p1((4,5),right).
% p1((4,6),right).
% p1((4,7),right).
% p1((4,8),right).
% p1((4,9),right).
% p1((4,10),down).
% p1((5,1),up).
% p1((5,2),right).
% p1((5,3),right).
% p1((5,4),right).
% p1((5,5),right).
% p1((5,6),right).
% p1((5,7),right).
% p1((5,8),right).
% p1((5,9),down).
% p1((5,10),left).
% p1((6,1),up).
% p1((6,2),right).
% p1((6,3),right).
% p1((6,4),right).
% p1((6,5),right).
% p1((6,6),right).
% p1((6,7),right).
% p1((6,8),down).
% p1((6,9),down).
% p1((6,10),up).
% p1((7,1),up).
% p1((7,2),right).
% p1((7,3),right).
% p1((7,4),right).
% p1((7,5),right).
% p1((7,6),right).
% p1((7,7),right).
% p1((7,8),down).
% p1((7,9),left).
% p1((7,10),up).
% p1((8,1),up).
% p1((8,2),right).
% p1((8,3),right).
% p1((8,4),right).
% p1((8,5),right).
% p1((8,6),down).
% p1((8,7),left).
% p1((8,8),left).
% p1((8,9),left).
% p1((8,10),up).
% p1((9,1),up).
% p1((9,2),right).
% p1((9,3),right).
% p1((9,4),down).
% p1((9,5),down).
% p1((9,6),down).
% p1((9,7),down).
% p1((9,8),up).
% p1((9,9),right).
% p1((9,10),up).
% p1((10,1),up).
% p1((10,2),left).
% p1((10,3),left).
% p1((10,4),left).
% p1((10,5),left).
% p1((10,6),left).
% p1((10,7),right).
% p1((10,8),right).
% p1((10,9),right).
% p1((10,10),up).


% p2((1,10),nil).
% p2((1,1),right).
% p2((1,2),right).
% p2((1,3),right).
% p2((1,4),right).
% p2((1,5),right).
% p2((1,6),right).
% p2((1,7),right).
% p2((1,8),right).
% p2((1,9),right).
% p2((2,1),up).
% p2((2,2),down).
% p2((2,3),left).
% p2((2,4),left).
% p2((2,5),left).
% p2((2,6),left).
% p2((2,7),left).
% p2((2,8),left).
% p2((2,9),down).
% p2((2,10),up).
% p2((3,1),up).
% p2((3,2),left).
% p2((3,3),left).
% p2((3,4),left).
% p2((3,5),left).
% p2((3,6),left).
% p2((3,7),left).
% p2((3,8),left).
% p2((3,9),down).
% p2((3,10),up).
% p2((4,1),up).
% p2((4,2),left).
% p2((4,3),left).
% p2((4,4),left).
% p2((4,5),left).
% p2((4,6),left).
% p2((4,7),left).
% p2((4,8),left).
% p2((4,9),down).
% p2((4,10),up).
% p2((5,1),up).
% p2((5,2),left).
% p2((5,3),left).
% p2((5,4),left).
% p2((5,5),left).
% p2((5,6),left).
% p2((5,7),left).
% p2((5,8),left).
% p2((5,9),left).
% p2((5,10),up).
% p2((6,1),up).
% p2((6,2),left).
% p2((6,3),left).
% p2((6,4),left).
% p2((6,5),left).
% p2((6,6),left).
% p2((6,7),left).
% p2((6,8),left).
% p2((6,9),down).
% p2((6,10),left).
% p2((7,1),up).
% p2((7,2),down).
% p2((7,3),down).
% p2((7,4),left).
% p2((7,5),left).
% p2((7,6),left).
% p2((7,7),left).
% p2((7,8),left).
% p2((7,9),left).
% p2((7,10),up).
% p2((8,1),up).
% p2((8,2),right).
% p2((8,3),down).
% p2((8,4),left).
% p2((8,5),left).
% p2((8,6),left).
% p2((8,7),left).
% p2((8,8),left).
% p2((8,9),down).
% p2((8,10),up).
% p2((9,1),up).
% p2((9,2),left).
% p2((9,3),left).
% p2((9,4),up).
% p2((9,5),left).
% p2((9,6),left).
% p2((9,7),left).
% p2((9,8),left).
% p2((9,9),left).
% p2((9,10),up).
% p2((10,1),up).
% p2((10,2),left).
% p2((10,3),left).
% p2((10,4),right).
% p2((10,5),up).
% p2((10,6),up).
% p2((10,7),right).
% p2((10,8),right).
% p2((10,9),right).
% p2((10,10),up).


gState(S) :-S = (L1, L2, G1, G2), 
    L1 != L2, 
    goal1(G1), goal2(G2), 
    L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
    L2 = (X2, Y2), cell(X2, Y2), not block(X2, Y2).

trans(S1, A1, A2, S2) :- gState(S1), gState(S2), 
    S1 = (L11, L12, G11, G12),
    S2 = (L21, L22, G21, G22),
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
    S = (G1, G2, G1, G2),
    goal1(G1), goal2(G2).

aState(AS) :- AS = (Self, Other2, Goal),
    Self = (X, Y), cell(X, Y), not block(X, Y),
    Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),
    near(Self, Other2).

near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 2, |Y1-Y2| <= 2,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

avai_action(AS, Action) :- aState(AS),
    AS = (Self, _, _),
    Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, _, G1), goal1(G1).
goal2_aState(AS) :- aState(AS), AS = (G2, _, G2), goal2(G2).

obs1(S, AS) :- gState(S),
    S = (L1, L2, G1, G2), 
    Self = L1, (Others2) = (L2),
    aState(AS), AS = (Self, L2, G1),
    near(Self, L2).
obs1(S, AS) :- gState(S),
    S = (L1, L2, G1, G2), 
    Self = L1, (Others2) = (L2),
    aState(AS), AS = (Self, empty, G1),
    not near(Self, L2).
obs2(S, AS) :- gState(S),
    S = (L1, L2, G1, G2), 
    Self = L2, (Others2) = (L1),
    aState(AS), AS = (Self, L1, G2),
    near(Self, L1).
obs2(S, AS) :- gState(S),
    S = (L1, L2, G1, G2), 
    Self = L2, (Others2) = (L1),
    aState(AS), AS = (Self, empty, G2),
    not near(Self, L1).

nextTo(Loc1, Action, Loc2) :- Loc1 = (X1, Y1), Loc2 = (X2, Y2),
    cell(X1, Y1), not block(X1, Y1),
    cell(X2, Y2), not block(X2, Y2),
    move(X1, Y1, Action, X2, Y2).

cost(AS, Action, C) :- aState(AS), AS = (Self, empty, Goal),
    Self = (X, Y), Goal = (Xg, Yg),
    move(X, Y, Action, Xs, Ys),
    C = 1 + |Xg - Xs| + |Yg - Ys|.
cost(AS, Action, C) :- aState(AS), AS = (Self, Others2, Goal),
    near(Self, Others2), not nextTo(Self, Action, Others2),
    Self = (X, Y), Goal = (Xg, Yg),
    move(X, Y, Action, Xs, Ys),
    C = 1 + |Xg - Xs| + |Yg - Ys|.
cost(AS, Action, 99999) :- aState(AS), AS = (Self, Others2, Goal),
    near(Self, Others2), nextTo(Self, Action, Others2),
    Self = (X, Y), Others2 = (Xs, Ys),
    move(X, Y, Action, Xs, Ys).
isAction(up). isAction(down). isAction(right). isAction(left). isAction(nil).
cost(AS, Action, 99999) :- aState(AS), isAction(Action), not avai_action(AS, Action).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2), Others2 != empty,
    Self != Goal, goal1(Goal).

{ do1(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal1(Goal).
    % p1(Self, A).


do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2), Others2 != empty,
    Self != Goal, goal2(Goal).

{ do2(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal2(Goal).
    % p2(Self, A).


reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
    obs1(S1, AS1), do1(AS1, A1),
    obs2(S1, AS2), do2(AS2, A2),
    trans(S1, A1, A2, S2).
loop(S) :- gState(S), not reached(S).
% :- gState(S), not reached(S).

:- gState(S1), not goal_gState(S1),
    obs1(S1, AS1), do1(AS1, A1),
    obs2(S1, AS2), do2(AS2, A2),
    trans(S1, A1, A2, S1).

p1(L1, L2, A) :- do1((L1, L2, _), A).
p2(L1, L2, A) :- do2((L1, L2, _), A).
% #show p1/3.
% #show p2/3.
% #show deadlock/1.
#show loop/1.
% #show cost/3.
