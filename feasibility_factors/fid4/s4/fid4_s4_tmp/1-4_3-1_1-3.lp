goal1(G) :- G = (1, 4).
goal2(G) :- G = (3, 1).
goal3(G) :- G = (1, 3).
cell(0..4, 0..6).
block(0, 0).
block(0, 1).
block(0, 2).
block(0, 3).
block(0, 4).
block(0, 5).
block(0, 6).
block(1, 0).
block(1, 6).
block(2, 0).
block(2, 1).
block(2, 3).
block(2, 5).
block(2, 6).
block(3, 0).
block(3, 6).
block(4, 0).
block(4, 1).
block(4, 2).
block(4, 3).
block(4, 4).
block(4, 5).
block(4, 6).

gState(S) :-S = (L1, L2, L3, G1, G2, G3), 
	L1 != L2, L1 != L3, 
	L2 != L3, 
	goal1(G1), goal2(G2), goal3(G3), 
	L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
	L2 = (X2, Y2), cell(X2, Y2), not block(X2, Y2),
	L3 = (X3, Y3), cell(X3, Y3), not block(X3, Y3).

trans(S1, A1, A2, A3, S2) :- gState(S1), gState(S2), 
	S1 = (L11, L12, L13, G11, G12, G13),
	S2 = (L21, L22, L23, G21, G22, G23),
	L11 = (X11, Y11), L12 = (X12, Y12), L13 = (X13, Y13),
	L21 = (X21, Y21), L22 = (X22, Y22), L23 = (X23, Y23),
	move(X11, Y11, A1, X21, Y21),
	move(X12, Y12, A2, X22, Y22),
	move(X13, Y13, A3, X23, Y23),
	(L11, L12) != (L22, L21), (L11, L13) != (L23, L21), 
	(L12, L13) != (L23, L22).

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
	S = (G1, G2, G3, G1, G2, G3),
	goal1(G1), goal2(G2), goal3(G3).

aState(AS) :- AS = (Self, Other2, Other3, Goal),
	Self = (X, Y), cell(X, Y), not block(X, Y),
	Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),
	near(Self, Other2), near(Self, Other3).

near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 4, |Y1-Y2| <= 4,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

avai_action(AS, Action) :- aState(AS),
	AS = (Self, _, _, _),
	Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, _, _, G1), goal1(G1).
goal2_aState(AS) :- aState(AS), AS = (G2, _, _, G2), goal2(G2).
goal3_aState(AS) :- aState(AS), AS = (G3, _, _, G3), goal3(G3).

obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L1, (Others2, Others3) = (L2, L3),
	aState(AS), AS = (Self, L2, L3, G1),
	near(Self, L2), near(Self, L3).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L1, (Others2, Others3) = (L2, L3),
	aState(AS), AS = (Self, L2, empty, G1),
	near(Self, L2), not near(Self, L3).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L1, (Others2, Others3) = (L2, L3),
	aState(AS), AS = (Self, empty, L3, G1),
	not near(Self, L2), near(Self, L3).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L1, (Others2, Others3) = (L2, L3),
	aState(AS), AS = (Self, empty, empty, G1),
	not near(Self, L2), not near(Self, L3).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L2, (Others2, Others3) = (L1, L3),
	aState(AS), AS = (Self, L1, L3, G2),
	near(Self, L1), near(Self, L3).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L2, (Others2, Others3) = (L1, L3),
	aState(AS), AS = (Self, L1, empty, G2),
	near(Self, L1), not near(Self, L3).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L2, (Others2, Others3) = (L1, L3),
	aState(AS), AS = (Self, empty, L3, G2),
	not near(Self, L1), near(Self, L3).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L2, (Others2, Others3) = (L1, L3),
	aState(AS), AS = (Self, empty, empty, G2),
	not near(Self, L1), not near(Self, L3).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L3, (Others2, Others3) = (L1, L2),
	aState(AS), AS = (Self, L1, L2, G3),
	near(Self, L1), near(Self, L2).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L3, (Others2, Others3) = (L1, L2),
	aState(AS), AS = (Self, L1, empty, G3),
	near(Self, L1), not near(Self, L2).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L3, (Others2, Others3) = (L1, L2),
	aState(AS), AS = (Self, empty, L2, G3),
	not near(Self, L1), near(Self, L2).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, G1, G2, G3), 
	Self = L3, (Others2, Others3) = (L1, L2),
	aState(AS), AS = (Self, empty, empty, G3),
	not near(Self, L1), not near(Self, L2).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, Goal), Self != Goal, goal1(Goal).
do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, Goal), Self != Goal, goal2(Goal).
do3(AS, nil) :- goal3_aState(AS).
{ do3(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, Goal), Self != Goal, goal3(Goal).

reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
	obs1(S1, AS1), do1(AS1, A1),
	obs2(S1, AS2), do2(AS2, A2),
	obs3(S1, AS3), do3(AS3, A3),
	trans(S1, A1, A2, A3, S2).
:- gState(S), not reached(S).

p1(L1, L2, L3, A) :- do1((L1, L2, L3, _), A).
p2(L1, L2, L3, A) :- do2((L1, L2, L3, _), A).
p3(L1, L2, L3, A) :- do3((L1, L2, L3, _), A).
#show p1/4.
#show p2/4.
#show p3/4.
