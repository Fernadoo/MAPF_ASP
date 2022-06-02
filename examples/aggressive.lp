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


p1((1,1),nil).
p1((1,2),left).
p1((1,3),left).
p1((1,4),left).
p1((1,5),left).
p1((1,6),left).
p1((1,7),left).
p1((1,8),left).
p1((1,9),left).
p1((1,10),down).
p1((2,1),up).
p1((2,2),down).
p1((2,3),right).
p1((2,4),right).
p1((2,5),right).
p1((2,6),right).
p1((2,7),right).
p1((2,8),right).
p1((2,9),right).
p1((2,10),down).
p1((3,1),up).
p1((3,2),right).
p1((3,3),right).
p1((3,4),right).
p1((3,5),right).
p1((3,6),right).
p1((3,7),right).
p1((3,8),right).
p1((3,9),right).
p1((3,10),down).
p1((4,1),up).
p1((4,2),down).
p1((4,3),right).
p1((4,4),right).
p1((4,5),right).
p1((4,6),right).
p1((4,7),right).
p1((4,8),right).
p1((4,9),right).
p1((4,10),down).
p1((5,1),up).
p1((5,2),right).
p1((5,3),right).
p1((5,4),right).
p1((5,5),right).
p1((5,6),right).
p1((5,7),right).
p1((5,8),right).
p1((5,9),down).
p1((5,10),left).
p1((6,1),up).
p1((6,2),right).
p1((6,3),right).
p1((6,4),right).
p1((6,5),right).
p1((6,6),right).
p1((6,7),right).
p1((6,8),down).
p1((6,9),down).
p1((6,10),up).
p1((7,1),up).
p1((7,2),right).
p1((7,3),right).
p1((7,4),right).
p1((7,5),right).
p1((7,6),right).
p1((7,7),right).
p1((7,8),down).
p1((7,9),left).
p1((7,10),up).
p1((8,1),up).
p1((8,2),right).
p1((8,3),right).
p1((8,4),right).
p1((8,5),right).
p1((8,6),down).
p1((8,7),left).
p1((8,8),left).
p1((8,9),left).
p1((8,10),up).
p1((9,1),up).
p1((9,2),right).
p1((9,3),right).
p1((9,4),down).
p1((9,5),down).
p1((9,6),down).
p1((9,7),down).
p1((9,8),up).
p1((9,9),right).
p1((9,10),up).
p1((10,1),up).
p1((10,2),left).
p1((10,3),left).
p1((10,4),left).
p1((10,5),left).
p1((10,6),left).
p1((10,7),right).
p1((10,8),right).
p1((10,9),right).
p1((10,10),up).
dist1(((1,1),(1,1)),0).
dist1(((2,1),(1,1)),1).
dist1(((1,2),(1,1)),1).
dist1(((1,3),(1,1)),2).
dist1(((3,1),(1,1)),2).
dist1(((4,1),(1,1)),3).
dist1(((1,4),(1,1)),3).
dist1(((1,5),(1,1)),4).
dist1(((5,1),(1,1)),4).
dist1(((6,1),(1,1)),5).
dist1(((1,6),(1,1)),5).
dist1(((1,7),(1,1)),6).
dist1(((7,1),(1,1)),6).
dist1(((8,1),(1,1)),7).
dist1(((1,8),(1,1)),7).
dist1(((1,9),(1,1)),8).
dist1(((9,1),(1,1)),8).
dist1(((10,1),(1,1)),9).
dist1(((10,2),(1,1)),10).
dist1(((10,3),(1,1)),11).
dist1(((10,4),(1,1)),12).
dist1(((9,4),(1,1)),13).
dist1(((10,5),(1,1)),13).
dist1(((10,6),(1,1)),14).
dist1(((9,5),(1,1)),14).
dist1(((9,3),(1,1)),14).
dist1(((9,2),(1,1)),15).
dist1(((9,6),(1,1)),15).
dist1(((8,6),(1,1)),16).
dist1(((8,5),(1,1)),17).
dist1(((8,7),(1,1)),17).
dist1(((8,8),(1,1)),18).
dist1(((8,4),(1,1)),18).
dist1(((8,3),(1,1)),19).
dist1(((9,8),(1,1)),19).
dist1(((7,8),(1,1)),19).
dist1(((8,9),(1,1)),19).
dist1(((7,9),(1,1)),20).
dist1(((6,8),(1,1)),20).
dist1(((7,7),(1,1)),20).
dist1(((8,2),(1,1)),20).
dist1(((7,6),(1,1)),21).
dist1(((6,7),(1,1)),21).
dist1(((6,9),(1,1)),21).
dist1(((5,9),(1,1)),22).
dist1(((6,6),(1,1)),22).
dist1(((7,5),(1,1)),22).
dist1(((7,4),(1,1)),23).
dist1(((6,5),(1,1)),23).
dist1(((5,8),(1,1)),23).
dist1(((5,10),(1,1)),23).
dist1(((4,10),(1,1)),24).
dist1(((6,10),(1,1)),24).
dist1(((5,7),(1,1)),24).
dist1(((6,4),(1,1)),24).
dist1(((7,3),(1,1)),24).
dist1(((7,2),(1,1)),25).
dist1(((6,3),(1,1)),25).
dist1(((5,6),(1,1)),25).
dist1(((7,10),(1,1)),25).
dist1(((4,9),(1,1)),25).
dist1(((3,10),(1,1)),25).
dist1(((2,10),(1,1)),26).
dist1(((3,9),(1,1)),26).
dist1(((4,8),(1,1)),26).
dist1(((8,10),(1,1)),26).
dist1(((5,5),(1,1)),26).
dist1(((6,2),(1,1)),26).
dist1(((5,4),(1,1)),27).
dist1(((9,10),(1,1)),27).
dist1(((4,7),(1,1)),27).
dist1(((3,8),(1,1)),27).
dist1(((2,9),(1,1)),27).
dist1(((1,10),(1,1)),27).
dist1(((2,8),(1,1)),28).
dist1(((3,7),(1,1)),28).
dist1(((4,6),(1,1)),28).
dist1(((10,10),(1,1)),28).
dist1(((9,9),(1,1)),28).
dist1(((5,3),(1,1)),28).
dist1(((5,2),(1,1)),29).
dist1(((10,9),(1,1)),29).
dist1(((4,5),(1,1)),29).
dist1(((3,6),(1,1)),29).
dist1(((2,7),(1,1)),29).
dist1(((2,6),(1,1)),30).
dist1(((3,5),(1,1)),30).
dist1(((4,4),(1,1)),30).
dist1(((10,8),(1,1)),30).
dist1(((4,2),(1,1)),30).
dist1(((10,7),(1,1)),31).
dist1(((4,3),(1,1)),31).
dist1(((3,4),(1,1)),31).
dist1(((2,5),(1,1)),31).
dist1(((2,4),(1,1)),32).
dist1(((3,3),(1,1)),32).
dist1(((9,7),(1,1)),32).
dist1(((3,2),(1,1)),33).
dist1(((2,3),(1,1)),33).
dist1(((2,2),(1,1)),34).

p2((10,10),nil).
p2((1,1),down).
p2((1,2),left).
p2((1,3),left).
p2((1,4),right).
p2((1,5),down).
p2((1,6),right).
p2((1,7),right).
p2((1,8),right).
p2((1,9),right).
p2((1,10),down).
p2((2,1),down).
p2((2,2),right).
p2((2,3),up).
p2((2,4),down).
p2((2,5),down).
p2((2,6),up).
p2((2,7),left).
p2((2,8),left).
p2((2,9),left).
p2((2,10),down).
p2((3,1),down).
p2((3,2),right).
p2((3,3),up).
p2((3,4),down).
p2((3,5),left).
p2((3,6),left).
p2((3,7),left).
p2((3,8),left).
p2((3,9),up).
p2((3,10),down).
p2((4,1),down).
p2((4,2),left).
p2((4,3),up).
p2((4,4),left).
p2((4,5),left).
p2((4,6),left).
p2((4,7),left).
p2((4,8),left).
p2((4,9),left).
p2((4,10),left).
p2((5,1),down).
p2((5,2),left).
p2((5,3),right).
p2((5,4),up).
p2((5,5),left).
p2((5,6),left).
p2((5,7),left).
p2((5,8),left).
p2((5,9),left).
p2((5,10),down).
p2((6,1),down).
p2((6,2),up).
p2((6,3),left).
p2((6,4),up).
p2((6,5),left).
p2((6,6),up).
p2((6,7),left).
p2((6,8),left).
p2((6,9),left).
p2((6,10),down).
p2((7,1),down).
p2((7,2),left).
p2((7,3),left).
p2((7,4),left).
p2((7,5),left).
p2((7,6),left).
p2((7,7),left).
p2((7,8),left).
p2((7,9),left).
p2((7,10),down).
p2((8,1),down).
p2((8,2),left).
p2((8,3),left).
p2((8,4),left).
p2((8,5),left).
p2((8,6),left).
p2((8,7),left).
p2((8,8),left).
p2((8,9),left).
p2((8,10),down).
p2((9,1),down).
p2((9,2),up).
p2((9,3),left).
p2((9,4),left).
p2((9,5),left).
p2((9,6),left).
p2((9,7),left).
p2((9,8),left).
p2((9,9),left).
p2((9,10),down).
p2((10,1),right).
p2((10,2),right).
p2((10,3),right).
p2((10,4),right).
p2((10,5),right).
p2((10,6),right).
p2((10,7),right).
p2((10,8),right).
p2((10,9),right).
dist2(((10,10),(10,10)),0).
dist2(((9,10),(10,10)),1).
dist2(((10,9),(10,10)),1).
dist2(((10,8),(10,10)),2).
dist2(((8,10),(10,10)),2).
dist2(((7,10),(10,10)),3).
dist2(((10,7),(10,10)),3).
dist2(((10,6),(10,10)),4).
dist2(((6,10),(10,10)),4).
dist2(((5,10),(10,10)),5).
dist2(((10,5),(10,10)),5).
dist2(((10,4),(10,10)),6).
dist2(((10,3),(10,10)),7).
dist2(((10,2),(10,10)),8).
dist2(((10,1),(10,10)),9).
dist2(((9,1),(10,10)),10).
dist2(((8,1),(10,10)),11).
dist2(((7,1),(10,10)),12).
dist2(((8,2),(10,10)),12).
dist2(((8,3),(10,10)),13).
dist2(((7,2),(10,10)),13).
dist2(((6,1),(10,10)),13).
dist2(((9,2),(10,10)),13).
dist2(((9,3),(10,10)),14).
dist2(((5,1),(10,10)),14).
dist2(((7,3),(10,10)),14).
dist2(((8,4),(10,10)),14).
dist2(((8,5),(10,10)),15).
dist2(((7,4),(10,10)),15).
dist2(((5,2),(10,10)),15).
dist2(((4,1),(10,10)),15).
dist2(((9,4),(10,10)),15).
dist2(((6,2),(10,10)),16).
dist2(((9,5),(10,10)),16).
dist2(((3,1),(10,10)),16).
dist2(((4,2),(10,10)),16).
dist2(((7,5),(10,10)),16).
dist2(((8,6),(10,10)),16).
dist2(((8,7),(10,10)),17).
dist2(((7,6),(10,10)),17).
dist2(((2,1),(10,10)),17).
dist2(((9,6),(10,10)),17).
dist2(((6,3),(10,10)),17).
dist2(((9,7),(10,10)),18).
dist2(((1,1),(10,10)),18).
dist2(((7,7),(10,10)),18).
dist2(((8,8),(10,10)),18).
dist2(((8,9),(10,10)),19).
dist2(((7,8),(10,10)),19).
dist2(((1,2),(10,10)),19).
dist2(((9,8),(10,10)),19).
dist2(((9,9),(10,10)),20).
dist2(((1,3),(10,10)),20).
dist2(((7,9),(10,10)),20).
dist2(((2,3),(10,10)),21).
dist2(((2,2),(10,10)),22).
dist2(((3,3),(10,10)),22).
dist2(((4,3),(10,10)),23).
dist2(((3,2),(10,10)),23).
dist2(((4,4),(10,10)),24).
dist2(((4,5),(10,10)),25).
dist2(((3,4),(10,10)),25).
dist2(((5,4),(10,10)),25).
dist2(((5,3),(10,10)),26).
dist2(((6,4),(10,10)),26).
dist2(((5,5),(10,10)),26).
dist2(((2,4),(10,10)),26).
dist2(((3,5),(10,10)),26).
dist2(((4,6),(10,10)),26).
dist2(((4,7),(10,10)),27).
dist2(((3,6),(10,10)),27).
dist2(((2,5),(10,10)),27).
dist2(((5,6),(10,10)),27).
dist2(((6,5),(10,10)),27).
dist2(((6,6),(10,10)),28).
dist2(((5,7),(10,10)),28).
dist2(((1,5),(10,10)),28).
dist2(((3,7),(10,10)),28).
dist2(((4,8),(10,10)),28).
dist2(((4,9),(10,10)),29).
dist2(((3,8),(10,10)),29).
dist2(((5,8),(10,10)),29).
dist2(((1,4),(10,10)),29).
dist2(((6,7),(10,10)),29).
dist2(((6,8),(10,10)),30).
dist2(((5,9),(10,10)),30).
dist2(((4,10),(10,10)),30).
dist2(((3,10),(10,10)),31).
dist2(((6,9),(10,10)),31).
dist2(((2,10),(10,10)),32).
dist2(((1,10),(10,10)),33).
dist2(((1,9),(10,10)),34).
dist2(((1,8),(10,10)),35).
dist2(((1,7),(10,10)),36).
dist2(((1,6),(10,10)),37).
dist2(((2,6),(10,10)),38).
dist2(((2,7),(10,10)),39).
dist2(((2,8),(10,10)),40).
dist2(((2,9),(10,10)),41).
dist2(((3,9),(10,10)),42).

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
    Self = (X, Y), Goal = (Xg, Yg),
    move(X, Y, Action, Xs, Ys).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2),
    Self != Goal, goal1(Goal),
    not nextTo(Self, A ,Others2),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5.

{ do1(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal1(Goal),
    p1(Self, A).


do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, Others2, Goal), near(Self, Others2),
    Self != Goal, goal2(Goal),
    not nextTo(Self, A ,Others2),
    cost(AS, A, C0),
    cost(AS, up, C1), cost(AS, down, C2), cost(AS, right, C3), cost(AS, left, C4), cost(AS, nil, C5),
    C0 <= C1, C0 <= C2, C0 <= C3, C0 <= C4, C0 <= C5.

{ do2(AS, A): avai_action(AS, A) } = 1 :- 
    aState(AS), AS = (Self, empty, Goal),
    Self != Goal, goal2(Goal),
    p2(Self, A).


reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
    obs1(S1, AS1), do1(AS1, A1),
    obs2(S1, AS2), do2(AS2, A2),
    trans(S1, A1, A2, S2).
:- gState(S), not reached(S).

p1(L1, L2, A) :- do1((L1, L2, _), A).
p2(L1, L2, A) :- do2((L1, L2, _), A).
#show p1/3.
#show p2/3.
% #show cost/3.
