cell(0..6, 0..11).
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
block(6, 1).
block(6, 2).
block(6, 3).
block(6, 4).
block(6, 5).
block(6, 6).
block(6, 7).
block(6, 8).
block(6, 9).
block(6, 10).
block(6, 11).
goal1(G) :- G = (5, 10).

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

p2(L1, A) :- do1((L1, _), A).
#show p2/2.
