goal1(G) :- G = (4, 1).
goal2(G) :- G = (3, 6).
cell(0..7, 0..7).
block(0, 0).
block(0, 1).
block(0, 2).
block(0, 3).
block(0, 4).
block(0, 5).
block(0, 6).
block(0, 7).
block(1, 0).
block(1, 7).
block(2, 0).
block(2, 7).
block(3, 0).
block(3, 7).
block(4, 0).
block(4, 7).
block(5, 0).
block(5, 7).
block(6, 0).
block(6, 7).
block(7, 0).
block(7, 1).
block(7, 2).
block(7, 3).
block(7, 4).
block(7, 5).
block(7, 6).
block(7, 7).


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
    |X1-X2| <= 3, |Y1-Y2| <= 3,
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


{ traffic(Self, Rel_pos, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2), Others2 != empty,
    Self = (X1, Y1), Others2 = (X2, Y2), Rel_pos = (X2 - X1, Y2 - Y1),
    Self != Goal.

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): traffic(Self, Rel_pos, A) } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2), Others2 != empty,
    Self = (X1, Y1), Others2 = (X2, Y2), Rel_pos = (X2 - X1, Y2 - Y1),
    Self != Goal, goal1(Goal).

{ do1(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal1(Goal).

do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): traffic(Self, Rel_pos, A) } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2), Others2 != empty,
    Self = (X1, Y1), Others2 = (X2, Y2), Rel_pos = (X2 - X1, Y2 - Y1),
    Self != Goal, goal2(Goal).

{ do2(AS, A): avai_action(AS, A),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5 } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal2(Goal).


reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
    obs1(S1, AS1), do1(AS1, A1),
    obs2(S1, AS2), do2(AS2, A2),
    trans(S1, A1, A2, S2).

:- gState(S), not reached(S).

p1(L1, L2, A) :- do1((L1, L2, _), A).
p2(L1, L2, A) :- do2((L1, L2, _), A).
% #show p1/3.
% #show p2/3.
#show traffic/3.
