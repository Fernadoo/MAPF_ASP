goal1(G) :- G = (1, 1).
goal2(G) :- G = (6, 6).
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


isAction(up). isAction(down). isAction(left). isAction(right).
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
move(X, Y, up, X-1, Y) :- action(X, Y, up).
move(X, Y, down, X+1, Y) :- action(X, Y, down).
move(X, Y, left, X, Y-1) :- action(X, Y, left).
move(X, Y, right, X, Y+1) :- action(X, Y, right).
move(X, Y, nil, X, Y) :- action(X, Y, nil).
% adj(init, L) :- L = (X, Y), cell(X, Y), not block(X, Y).
adj(L1, L2) :- L1 = (X1, Y1), L2 = (X2, Y2),
    cell(X1, Y1), not block(X1, Y1),
    cell(X2, Y2), not block(X2, Y2),
    isAction(A), move(X1, Y1, A, X2, Y2).


gState(S) :-S = (L1, L2, G1, G2), 
    L1 != L2, 
    goal1(G1), goal2(G2), 
    L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
    L2 = (X2, Y2), cell(X2, Y2), not block(X2, Y2).
m_gState(S) :-S = (S1, S2, G1, G2),
    S1 = (init, M11), S2 = (init, M21),
    gState((M11, M21, G1, G2)).
m_gState(S) :-S = (S1, S2, G1, G2),
    S1 = (M10, M11), S2 = (M20, M21),
    M10 != init, M20 != init,
    adj(M10, M11), adj(M20, M21),
    gState((M11, M21, G1, G2)).
goal_m_gState(S) :- m_gState(S),
    S = (S1, S2, G1, G2),
    S1 = (_, M11), S2 = (_, M21),
    M11 = G1, M21 = G2,
    goal1(G1), goal2(G2).


trans(S1, A1, A2, S2) :- gState(S1), gState(S2), 
    S1 = (L11, L12, G1, G2),
    S2 = (L21, L22, G1, G2),
    L11 = (X11, Y11), L12 = (X12, Y12),
    L21 = (X21, Y21), L22 = (X22, Y22),
    move(X11, Y11, A1, X21, Y21),
    move(X12, Y12, A2, X22, Y22),
    (L11, L12) != (L22, L21).
m_trans(S1, A1, A2, S2) :- m_gState(S1), m_gState(S2), 
    S1 = (S11, S12, G1, G2),
    S2 = (S21, S22, G1, G2),
    S11 = (M110, M111), S12 = (M120, M121),
    S21 = (M210, M211), S22 = (M220, M221),
    M111 = M210, M121 = M220,
    trans((M111, M121, G1, G2), A1, A2, (M211, M221, G1, G2)).

near(init, init).
near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 2, |Y1-Y2| <= 2,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).
aState(AS) :- AS = (Self, Other, Goal),
    Self = (X, Y), cell(X, Y), not block(X, Y),
    Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),
    near(Self, Other).
m_aState(AS) :- AS = ((init, init), (Self1, Other1), Goal),
    aState((Self1, Other1, Goal)).
m_aState(AS) :- AS = ((Self0, Other0), (Self1, Other1), Goal),
    Self0 != init, Other0 != init,
    adj(Self0, Self1),
    aState((Self0, Other0, Goal)), aState((Self1, Other1, Goal)).
goal1_m_aState(AS) :- m_aState(AS), AS = ((_, _), (G1, _), G1), goal1(G1).
goal2_m_aState(AS) :- m_aState(AS), AS = ((_, _), (G2, _), G2), goal2(G2).


obs1(S, AS) :- S = (init, init, G1, G2), AS = (init, init, G1),
    goal1(G1), goal2(G2).
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
obs2(S, AS) :- S = (init, init, G1, G2), AS = (init, init, G2),
    goal1(G1), goal2(G2).
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
m_obs1(S, AS) :- m_gState(S), m_aState(AS),
    S = (S1, S2, G1, G2),
    S1 = (M10, M11), S2 = (M20, M21),
    AS = ((Self0, Other0), (Self1, Other1), G1),
    obs1((M10, M20, G1, G2), (Self0, Other0, G1)),
    obs1((M11, M21, G1, G2), (Self1, Other1, G1)).
m_obs2(S, AS) :- m_gState(S), m_aState(AS),
    S = (S1, S2, G1, G2),
    S1 = (M10, M11), S2 = (M20, M21),
    AS = ((Self0, Other0), (Self1, Other1), G2),
    obs2((M10, M20, G1, G2), (Self0, Other0, G2)),
    obs2((M11, M21, G1, G2), (Self1, Other1, G2)).


avai_action(AS, Action) :- m_aState(AS),
    AS = ((_, _), (Self, _), _),
    Self = (X, Y), action(X, Y, Action).
do1(AS, nil) :- goal1_m_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
    m_aState(AS), AS = ((Self0, Other0), (Self1, Other1), Goal), Self1 != Goal, goal1(Goal).
do2(AS, nil) :- goal2_m_aState(AS).
{ do2(AS, A): avai_action(AS, A) } = 1 :- 
    m_aState(AS), AS = ((Self0, Other0), (Self1, Other1), Goal), Self1 != Goal, goal2(Goal).


reached(S) :- goal_m_gState(S).
reached(S1) :- m_gState(S1), reached(S2),
    m_obs1(S1, AS1), do1(AS1, A1),
    m_obs2(S1, AS2), do2(AS2, A2),
    m_trans(S1, A1, A2, S2).
:- m_gState(S), 
    S = (S1, S2, G1, G2),
    S1 = (init, _), S2 = (init, _),
    not reached(S).


p1((Self0, Other0), (Self1, Other1), A) :- do1(((Self0, Other0), (Self1, Other1), Goal), A).
p2((Self0, Other0), (Self1, Other1), A) :- do2(((Self0, Other0), (Self1, Other1), Goal), A).
#show p1/3.
#show p2/3.
