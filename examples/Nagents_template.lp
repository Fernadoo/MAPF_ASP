% Pre-specified parameters
cell().
block().

goal1(G) :- G = (, ).
...,
goaln(G) :- G = (, ).


% Global settings
gState(S) :- S = (L1, ..., Ln, G1, ...,Gn),
    Li != Lj, ...  % n(n-1)/2
    goal1(G1), ..., goaln(Gn),
    L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
    ...,
    Ln = (Xn, Yn), cell(Xn, Yn), not block(Xn, Yn).

trans(S1, A1, ..., An, S2) :- gState(S1), gState(S2),
    S1 = (L11, ..., L1n, G11, ..., G1n),
    S2 = (L21, ..., L2n, G21, ..., G2n),
    L11 = (X11, Y11), ..., L1n = (X1n, Y1n),
    L21 = (X21, Y21), ..., L2n = (X2n, Y2n),
    move(X11, Y11, A1, X21, Y21),
    ...,
    move(X1n, Y1n, An, X2n, Y2n),
    % vertex conflict subsumed in gState(S2)
    % only need to avoid edge conflict (immediate swap)
    (L1i, L1j) != (L2j, L2i).

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
    S = (G1, ..., Gn, G1, ..., Gn),
    goal1(G1), ..., goaln(Gn).


% Agent settings
aState(AS) :- AS = (Self, Other2, ..., Othern, Goal),
    Self = (X, Y), cell(X, Y), not block(X, Y),
    Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),
    near(Self, Other2), ..., near(Self, Othern).

near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= {Radius}, |Y1-Y2| <= {Radius},
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

avai_action(AS, Action) :- aState(AS), AS = (Self, _, ..., _),
    Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, _, ..., G1), goal1(G1).
...,
goaln_aState(AS) :- aState(AS), AS = (Gn, _, ..., Gn), goaln(Gn).


% Observation model
obs1(S, AS) :- % 2^{n-1}
    gState(S), S = (L1, ..., Ln, G1, ..., Gn),
    Self = L1, (Other2, ..., Othern) = (L1, ..., Ln)\Self
    aState(AS), AS = (Self, {empty}/Other2, ..., {empty}/Othern, G1),
    {not} near(Self, Other2), ..., {not} near(Self, Othern).
...,
obsn(S, AS) :- % 2^{n-1}
    gState(S), S = (L1, ..., Ln, G1, ..., Gn),
    Self = Ln, (Other2, ..., Othern) = (L1, ..., Ln)\Self
    aState(AS), AS = (Self, {empty}/Other2, ..., {empty}/Othern, Gn),
    {not} near(Self, Other2), ..., {not} near(Self, Othern).


% Policy restrictions
do1(AS, nil) :- goal1_aState(AS).
...,
don(AS, nil) :- goaln_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :-
    aState(AS), AS = (Self, _, ..., Goal), Self != Goal, goal1(Goal).
...,
{ don(AS, A): avai_action(AS, A) } = 1 :-
    aState(AS), AS = (Self, _, ..., Goal), Self != Goal, goaln(Goal).


% Reachability
reached(S) :- goal_gState(S).
reached(S1) :- gState(S1),
    obs1(S1, AS1), ..., obsn(S1, ASn),
    do1(AS1, A1), ..., don(ASn, An),
    trans(S1, A1, ..., An, S2),
    reached(S2).

:- gState(S), not reached(S).


% induction on dist from any reachable global state to goal state
cost(0..#UP).
dist(S, 0) :- goal_gState(S).
dist(S1, C) :- not goal_gState(S1), reached(S1),
    obs1(S1, AS1), do1(AS1, A1),
    ...,
    obsn(Sn, ASn), don(ASn, An),
    trans(S1, A1, ..., An, S2),
    dist(S2, C-1), cost(C).

#minimize {C, dist(S, C): dist(S, C)}.


% shorter notation
p1(L1, ..., Ln, A) :- do1((L1, ..., Ln, _), A).
...,
pn(L1, ..., Ln, A) :- don((L1, ..., Ln, _), A).


#show p1/{n+1}.
...,
#show pn/{n+1}.