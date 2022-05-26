cell(0..4, 0..4).
block(0, 0).
block(0, 1).
block(0, 2).
block(0, 3).
block(0, 4).
block(1, 0).
block(1, 4).
block(2, 0).
block(2, 4).
block(3, 0).
block(3, 4).
block(4, 0).
block(4, 1).
block(4, 2).
block(4, 3).
block(4, 4).
goal1(G) :- G = (1, 1).
goal2(G) :- G = (1, 2).
goal3(G) :- G = (1, 3).
goal4(G) :- G = (2, 2).
goal5(G) :- G = (3, 1).
goal6(G) :- G = (3, 2).
goal7(G) :- G = (3, 3).

gState(S) :-S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	L1 != L2, L1 != L3, L1 != L4, L1 != L5, L1 != L6, L1 != L7, 
	L2 != L3, L2 != L4, L2 != L5, L2 != L6, L2 != L7, 
	L3 != L4, L3 != L5, L3 != L6, L3 != L7, 
	L4 != L5, L4 != L6, L4 != L7, 
	L5 != L6, L5 != L7, 
	L6 != L7, 
	goal1(G1), goal2(G2), goal3(G3), goal4(G4), goal5(G5), goal6(G6), goal7(G7), 
	L1 = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
	L2 = (X2, Y2), cell(X2, Y2), not block(X2, Y2),
	L3 = (X3, Y3), cell(X3, Y3), not block(X3, Y3),
	L4 = (X4, Y4), cell(X4, Y4), not block(X4, Y4),
	L5 = (X5, Y5), cell(X5, Y5), not block(X5, Y5),
	L6 = (X6, Y6), cell(X6, Y6), not block(X6, Y6),
	L7 = (X7, Y7), cell(X7, Y7), not block(X7, Y7).

trans(S1, A1, A2, A3, A4, A5, A6, A7, S2) :- gState(S1), gState(S2), 
	S1 = (L11, L12, L13, L14, L15, L16, L17, G11, G12, G13, G14, G15, G16, G17),
	S2 = (L21, L22, L23, L24, L25, L26, L27, G21, G22, G23, G24, G25, G26, G27),
	L11 = (X11, Y11), L12 = (X12, Y12), L13 = (X13, Y13), L14 = (X14, Y14), L15 = (X15, Y15), L16 = (X16, Y16), L17 = (X17, Y17),
	L21 = (X21, Y21), L22 = (X22, Y22), L23 = (X23, Y23), L24 = (X24, Y24), L25 = (X25, Y25), L26 = (X26, Y26), L27 = (X27, Y27),
	move(X11, Y11, A1, X21, Y21),
	move(X12, Y12, A2, X22, Y22),
	move(X13, Y13, A3, X23, Y23),
	move(X14, Y14, A4, X24, Y24),
	move(X15, Y15, A5, X25, Y25),
	move(X16, Y16, A6, X26, Y26),
	move(X17, Y17, A7, X27, Y27),
	(L11, L12) != (L22, L21), (L11, L13) != (L23, L21), (L11, L14) != (L24, L21), (L11, L15) != (L25, L21), (L11, L16) != (L26, L21), (L11, L17) != (L27, L21), 
	(L12, L13) != (L23, L22), (L12, L14) != (L24, L22), (L12, L15) != (L25, L22), (L12, L16) != (L26, L22), (L12, L17) != (L27, L22), 
	(L13, L14) != (L24, L23), (L13, L15) != (L25, L23), (L13, L16) != (L26, L23), (L13, L17) != (L27, L23), 
	(L14, L15) != (L25, L24), (L14, L16) != (L26, L24), (L14, L17) != (L27, L24), 
	(L15, L16) != (L26, L25), (L15, L17) != (L27, L25), 
	(L16, L17) != (L27, L26).

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
	S = (G1, G2, G3, G4, G5, G6, G7, G1, G2, G3, G4, G5, G6, G7),
	goal1(G1), goal2(G2), goal3(G3), goal4(G4), goal5(G5), goal6(G6), goal7(G7).

aState(AS) :- AS = (Self, Other2, Other3, Other4, Other5, Other6, Other7, Goal),
	Self = (X, Y), cell(X, Y), not block(X, Y),
	Goal = (Xg, Yg), cell(Xg, Yg), not block(Xg, Yg),
	near(Self, Other2), near(Self, Other3), near(Self, Other4), near(Self, Other5), near(Self, Other6), near(Self, Other7).

near(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
near(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 1, |Y1-Y2| <= 1,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

avai_action(AS, Action) :- aState(AS),
	AS = (Self, _, _, _, _, _, _, _),
	Self = (X, Y), action(X, Y, Action).

goal1_aState(AS) :- aState(AS), AS = (G1, _, _, _, _, _, _, G1), goal1(G1).
goal2_aState(AS) :- aState(AS), AS = (G2, _, _, _, _, _, _, G2), goal2(G2).
goal3_aState(AS) :- aState(AS), AS = (G3, _, _, _, _, _, _, G3), goal3(G3).
goal4_aState(AS) :- aState(AS), AS = (G4, _, _, _, _, _, _, G4), goal4(G4).
goal5_aState(AS) :- aState(AS), AS = (G5, _, _, _, _, _, _, G5), goal5(G5).
goal6_aState(AS) :- aState(AS), AS = (G6, _, _, _, _, _, _, G6), goal6(G6).
goal7_aState(AS) :- aState(AS), AS = (G7, _, _, _, _, _, _, G7), goal7(G7).

obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, L5, L6, L7, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, L5, L6, empty, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, L5, empty, L7, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, L5, empty, empty, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, empty, L6, L7, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, empty, L6, empty, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, empty, empty, L7, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, L4, empty, empty, empty, G1),
	near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, L5, L6, L7, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, L5, L6, empty, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, L5, empty, L7, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, L5, empty, empty, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, empty, L6, L7, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, empty, L6, empty, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, empty, empty, L7, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, L3, empty, empty, empty, empty, G1),
	near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, L5, L6, L7, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, L5, L6, empty, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, L5, empty, L7, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, L5, empty, empty, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, empty, L6, L7, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, empty, L6, empty, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, empty, empty, L7, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, L4, empty, empty, empty, G1),
	near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, L5, L6, L7, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, L5, L6, empty, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, L5, empty, L7, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, L5, empty, empty, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, empty, L6, L7, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, empty, L6, empty, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, empty, empty, L7, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L2, empty, empty, empty, empty, empty, G1),
	near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, L6, L7, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, L6, empty, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, empty, L7, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, empty, empty, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, L6, L7, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, L6, empty, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, empty, L7, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, empty, empty, G1),
	not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, L6, L7, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, L6, empty, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, empty, L7, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, empty, empty, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, L6, L7, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, L6, empty, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, empty, L7, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, empty, empty, G1),
	not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, L7, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, empty, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, L7, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, empty, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, L7, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, empty, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, L7, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, empty, G1),
	not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, L7, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, empty, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, L7, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, empty, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, L7, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, empty, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs1(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L1, (Others2, Others3, Others4, Others5, Others6, Others7) = (L2, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G1),
	not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, L5, L6, L7, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, L5, L6, empty, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, L5, empty, L7, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, L5, empty, empty, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, empty, L6, L7, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, empty, L6, empty, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, empty, empty, L7, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, L4, empty, empty, empty, G2),
	near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, L5, L6, L7, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, L5, L6, empty, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, L5, empty, L7, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, L5, empty, empty, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, empty, L6, L7, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, empty, L6, empty, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, empty, empty, L7, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L3, empty, empty, empty, empty, G2),
	near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, L6, L7, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, L6, empty, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, empty, L7, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, empty, empty, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, L6, L7, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, L6, empty, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, empty, L7, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, empty, empty, G2),
	near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, L7, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, empty, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, L7, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, empty, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, L7, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, empty, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L7, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G2),
	near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, L6, L7, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, L6, empty, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, empty, L7, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, L5, empty, empty, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, L6, L7, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, L6, empty, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, empty, L7, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, L4, empty, empty, empty, G2),
	not near(Self, L1), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, L6, L7, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, L6, empty, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, empty, L7, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, L5, empty, empty, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, L6, L7, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, L6, empty, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, empty, L7, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L3, empty, empty, empty, empty, G2),
	not near(Self, L1), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, L7, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, empty, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, L7, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, empty, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, L7, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, empty, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, L7, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, empty, G2),
	not near(Self, L1), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, L7, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, empty, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, L7, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, empty, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, L7, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, empty, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs2(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L2, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L3, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G2),
	not near(Self, L1), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, L5, L6, L7, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, L5, L6, empty, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, L5, empty, L7, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, L5, empty, empty, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, empty, L6, L7, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, empty, L6, empty, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, empty, empty, L7, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L4, empty, empty, empty, G3),
	near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, L6, L7, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, L6, empty, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, empty, L7, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, empty, empty, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, L7, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, empty, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, L7, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, empty, G3),
	near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, L6, L7, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, L6, empty, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, empty, L7, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, L5, empty, empty, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, L6, L7, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, L6, empty, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, empty, L7, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L4, empty, empty, empty, G3),
	near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, L7, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, empty, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, L7, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, empty, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, L7, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, empty, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L7, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G3),
	near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, L5, L6, L7, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, L5, L6, empty, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, L5, empty, L7, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, L5, empty, empty, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, empty, L6, L7, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, empty, L6, empty, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, empty, empty, L7, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L4, empty, empty, empty, G3),
	not near(Self, L1), near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, L6, L7, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, L6, empty, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, empty, L7, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, empty, empty, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, L7, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, empty, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, L7, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, empty, G3),
	not near(Self, L1), near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, L7, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, L6, empty, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, L7, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, L5, empty, empty, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, L7, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, L6, empty, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, L7, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L4, empty, empty, empty, G3),
	not near(Self, L1), not near(Self, L2), near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, L7, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, empty, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, L7, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, empty, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, L7, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, empty, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs3(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L3, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L4, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G3),
	not near(Self, L1), not near(Self, L2), not near(Self, L4), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L5, L6, L7, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L5, L6, empty, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L5, empty, L7, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L5, empty, empty, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L6, L7, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L6, empty, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, L7, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, empty, G4),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, L6, L7, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, L6, empty, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, empty, L7, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L5, empty, empty, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, L7, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, empty, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, L7, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, empty, G4),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L5, L6, L7, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L5, L6, empty, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L5, empty, L7, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L5, empty, empty, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L6, L7, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L6, empty, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, L7, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, empty, G4),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, L7, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, L6, empty, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, L7, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L5, empty, empty, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, L7, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, empty, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L7, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G4),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L5, L6, L7, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L5, L6, empty, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L5, empty, L7, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L5, empty, empty, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L6, L7, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L6, empty, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, L7, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, empty, G4),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, L6, L7, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, L6, empty, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, empty, L7, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L5, empty, empty, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, L7, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, empty, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, L7, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, empty, G4),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L5, L6, L7, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L5, L6, empty, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L5, empty, L7, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L5, empty, empty, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L6, L7, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L6, empty, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, L7, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, empty, G4),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, L7, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, L6, empty, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, L7, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L5, empty, empty, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L5), not near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, L7, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, empty, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), near(Self, L6), not near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), near(Self, L7).
obs4(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L4, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L5, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G4),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L5), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, L6, L7, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, L6, empty, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, L7, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, empty, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L6, L7, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L6, empty, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, L7, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, empty, G5),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, L6, L7, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, L6, empty, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, L7, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, empty, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, L7, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L6, empty, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, L7, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, empty, G5),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, L6, L7, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, L6, empty, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, L7, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, empty, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L6, L7, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L6, empty, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, L7, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, empty, G5),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, L6, L7, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, L6, empty, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, L7, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, empty, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, L7, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L6, empty, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L7, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G5),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, L6, L7, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, L6, empty, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, L7, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, empty, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L6, L7, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L6, empty, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, L7, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, empty, G5),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, L6, L7, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, L6, empty, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, L7, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, empty, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, L7, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L6, empty, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, L7, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, empty, G5),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, L6, L7, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, L6, empty, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, L7, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, empty, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L6, L7, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L6, empty, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, L7, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, empty, G5),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, L6, L7, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, L6, empty, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, L7, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, empty, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, L7, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L6, empty, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L6), not near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), near(Self, L7).
obs5(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L5, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L6, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G5),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L6), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, L5, L7, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, L5, empty, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, L7, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, empty, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L5, L7, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, L5, empty, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, L7, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, empty, G6),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, L5, L7, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, L5, empty, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, L7, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, empty, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L5, L7, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, L5, empty, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, L7, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, empty, G6),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, L5, L7, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, L5, empty, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, L7, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, empty, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L5, L7, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, L5, empty, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, L7, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, empty, G6),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, L5, L7, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, L5, empty, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, L7, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, empty, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L5, L7, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, L5, empty, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L7, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G6),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, L5, L7, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, L5, empty, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, L7, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, empty, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L5, L7, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, L5, empty, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, L7, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, empty, G6),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, L5, L7, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, L5, empty, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, L7, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, empty, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L5, L7, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, L5, empty, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, L7, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, empty, G6),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, L5, L7, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, L5, empty, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, L7, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, empty, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L5, L7, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, L5, empty, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, L7, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, empty, G6),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, L5, L7, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, L5, empty, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, L7, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, empty, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L5, L7, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, L5, empty, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L7, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L7).
obs6(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L6, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L7),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G6),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L7).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, L4, L5, L6, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, L4, L5, empty, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, L6, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, L4, empty, empty, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, empty, L5, L6, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, empty, L5, empty, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, L6, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, L3, empty, empty, empty, G7),
	near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, L4, L5, L6, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, L4, L5, empty, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, L6, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, L4, empty, empty, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, empty, L5, L6, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, empty, L5, empty, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, L6, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, L2, empty, empty, empty, empty, G7),
	near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, L4, L5, L6, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, L4, L5, empty, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, L6, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, L4, empty, empty, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, empty, L5, L6, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, empty, L5, empty, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, L6, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, L3, empty, empty, empty, G7),
	near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, L4, L5, L6, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, L4, L5, empty, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, L6, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, L4, empty, empty, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, empty, L5, L6, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, empty, L5, empty, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, L6, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, L1, empty, empty, empty, empty, empty, G7),
	near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, L4, L5, L6, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, L4, L5, empty, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, L6, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, L4, empty, empty, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, empty, L5, L6, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, empty, L5, empty, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, L6, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, L3, empty, empty, empty, G7),
	not near(Self, L1), near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, L4, L5, L6, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, L4, L5, empty, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, L6, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, L4, empty, empty, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, empty, L5, L6, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, empty, L5, empty, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, L6, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, L2, empty, empty, empty, empty, G7),
	not near(Self, L1), near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, L4, L5, L6, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, L4, L5, empty, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, L6, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, L4, empty, empty, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, empty, L5, L6, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, empty, L5, empty, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, L6, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, L3, empty, empty, empty, G7),
	not near(Self, L1), not near(Self, L2), near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, L4, L5, L6, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, L4, L5, empty, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, L6, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, L4, empty, empty, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), near(Self, L4), not near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, empty, L5, L6, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, empty, L5, empty, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), near(Self, L5), not near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, L6, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), near(Self, L6).
obs7(S, AS) :- gState(S),
	S = (L1, L2, L3, L4, L5, L6, L7, G1, G2, G3, G4, G5, G6, G7), 
	Self = L7, (Others2, Others3, Others4, Others5, Others6, Others7) = (L1, L2, L3, L4, L5, L6),
	aState(AS), AS = (Self, empty, empty, empty, empty, empty, empty, G7),
	not near(Self, L1), not near(Self, L2), not near(Self, L3), not near(Self, L4), not near(Self, L5), not near(Self, L6).

do1(AS, nil) :- goal1_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal1(Goal).
do2(AS, nil) :- goal2_aState(AS).
{ do2(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal2(Goal).
do3(AS, nil) :- goal3_aState(AS).
{ do3(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal3(Goal).
do4(AS, nil) :- goal4_aState(AS).
{ do4(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal4(Goal).
do5(AS, nil) :- goal5_aState(AS).
{ do5(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal5(Goal).
do6(AS, nil) :- goal6_aState(AS).
{ do6(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal6(Goal).
do7(AS, nil) :- goal7_aState(AS).
{ do7(AS, A): avai_action(AS, A) } = 1 :- 
	aState(AS), AS = (Self, _, _, _, _, _, _, Goal), Self != Goal, goal7(Goal).

reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), reached(S2),
	obs1(S1, AS1), do1(AS1, A1),
	obs2(S1, AS2), do2(AS2, A2),
	obs3(S1, AS3), do3(AS3, A3),
	obs4(S1, AS4), do4(AS4, A4),
	obs5(S1, AS5), do5(AS5, A5),
	obs6(S1, AS6), do6(AS6, A6),
	obs7(S1, AS7), do7(AS7, A7),
	trans(S1, A1, A2, A3, A4, A5, A6, A7, S2).
:- gState(S), not reached(S).

p1(L1, L2, L3, L4, L5, L6, L7, A) :- do1((L1, L2, L3, L4, L5, L6, L7, _), A).
p2(L1, L2, L3, L4, L5, L6, L7, A) :- do2((L1, L2, L3, L4, L5, L6, L7, _), A).
p3(L1, L2, L3, L4, L5, L6, L7, A) :- do3((L1, L2, L3, L4, L5, L6, L7, _), A).
p4(L1, L2, L3, L4, L5, L6, L7, A) :- do4((L1, L2, L3, L4, L5, L6, L7, _), A).
p5(L1, L2, L3, L4, L5, L6, L7, A) :- do5((L1, L2, L3, L4, L5, L6, L7, _), A).
p6(L1, L2, L3, L4, L5, L6, L7, A) :- do6((L1, L2, L3, L4, L5, L6, L7, _), A).
p7(L1, L2, L3, L4, L5, L6, L7, A) :- do7((L1, L2, L3, L4, L5, L6, L7, _), A).
#show p1/8.
#show p2/8.
#show p3/8.
#show p4/8.
#show p5/8.
#show p6/8.
#show p7/8.
