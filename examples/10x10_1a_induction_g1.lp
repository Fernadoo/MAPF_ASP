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

gState(S) :-S = (L1, G1), 
    goal1(G1), 
    L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1).

trans(S1, A1, S2) :- gState(S1), gState(S2), 
    S1 = (L11, G11),
    S2 = (L21, G21),
    L11 = (X11, Y11),
    L21 = (X21, Y21),
    move(X11, Y11, A1, X21, Y21).

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
    S = (G1, G1),
    goal1(G1).

aState(AS) :- AS = (Self, Goal),
    Self = (X, Y), cell(X, Y), not block(X, Y),
    Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg).

avai_action(AS, Action) :- aState(AS),
    AS = (Self, _),
    Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, G1), goal1(G1).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, Goal), Self != Goal, goal1(Goal).

reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
    do1(S1, A1),
    trans(S1, A1, S2).
:- gState(S), not reached(S).

cost(0..100).
dist1(S, 0) :- goal_gState(S).
dist1(S1, C) :- not goal_gState(S1), reached(S1),
    do1(S1, A1),
    trans(S1, A1, S2),
    dist1(S2, C-1), cost(C).

#minimize {C, dist1(S, C): dist1(S, C)}.

p1(L1, A) :- do1((L1, _), A).
#show p1/2.
#show dist1/2.
