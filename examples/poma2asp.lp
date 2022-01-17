%*
Map
...
.#.
...

Sensor
...
.o.
...
*%

% Grid world
cell(0..2, 0..2).
block(1,1).


% Set goals to any pair of different positions
goal1(G) :- G = (0, 1).
goal2(G) :- G = (2, 0).


% Formatting global states
gState(S) :- S = (L1, L2, G1, G2),
    L1 != L2, goal1(G1), goal2(G2),
    L1 = (X1, Y1), L2 = (X2, Y2),
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).


% Global state transition and goal state
trans(S1, A, B, S2) :- gState(S1), gState(S2),
    S1 = (L1, L2, G1, G2), S2 = (L3, L4, G1, G2),
    (L1, L2) != (L4, L3), L3 != L4, % two types of collisions
    L1 = (X1, Y1), L2 = (X2, Y2), L3 = (X3, Y3), L4 = (X4, Y4),
    move(X1, Y1, A, X3, Y3), move(X2, Y2, B, X4, Y4).

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

goal_gState(S) :- gState(S), S = (G1, G2, G1, G2),
    goal1(G1), goal2(G2).


% Formatting agent states
aState(AS) :- AS = (Self, Other, Goal),
    Self = (X1, Y1), cell(X1, Y1), not block(X1, Y1),
    Goal = (X3, Y3), cell(X3, Y3), not block(X3, Y3),
    detect(Self, Other).

detect(Self, empty) :- Self = (X1, Y1), cell(X1, Y1).
detect(Self, Other) :- Self != Other,
    Self = (X1, Y1), Other = (X2, Y2),
    |X1-X2| <= 1, |Y1-Y2| <= 1,
    cell(X1, Y1), cell(X2, Y2),
    not block(X1, Y1), not block(X2, Y2).

% Available actions for an agent state
avai_action(AS, Action) :- aState(AS), AS = (Self, _, _),
    Self = (X, Y), action(X, Y, Action).

% Reach the goal from an agent's perspective
goal1_aState(AS) :- aState(AS), AS = (G1, _, G1), goal1(G1).
goal2_aState(AS) :- aState(AS), AS = (G2, _, G2), goal2(G2).


% Observation functionality
obs1(S, AS) :- gState(S), aState(AS),
    S = (L1, L2, G1, G2), AS = (L1, L2, G1),
    detect(L1, L2).
obs1(S, AS) :- gState(S), aState(AS),
    S = (L1, L2, G1, G2), AS = (L1, empty, G1),
    not detect(L1, L2).

obs2(S, AS) :- gState(S), aState(AS),
    S = (L1, L2, G1, G2), AS = (L2, L1, G2),
    detect(L2, L1).
obs2(S, AS) :- gState(S), aState(AS),
    S = (L1, L2, G1, G2), AS = (L2, empty, G2),
    not detect(L2, L1).


% Define a policy as a set of mappings {AS -> Action}     
do1(AS, nil) :- goal1_aState(AS).
do2(AS, nil) :- goal2_aState(AS).
{ do1(AS, A): avai_action(AS, A) } = 1 :-
    aState(AS), AS = (Self, _, Goal), Self != Goal, goal1(Goal).
{ do2(AS, A): avai_action(AS, A) } = 1 :-
    aState(AS), AS = (Self, _, Goal), Self != Goal, goal2(Goal).


% Reachability
reached(S) :- goal_gState(S).
reached(S1) :- gState(S1), obs1(S1, AS1), obs2(S1, AS2), do1(AS1, A), do2(AS2, B),
    trans(S1, A, B, S2), reached(S2).

% Eliminate answer sets where not every state is reachable to the goal
:- gState(S), not reached(S).


% shorter notation
p1(L1,L2,A) :- do1((L1, L2, _), A).
p2(L1,L2,A) :- do2((L1, L2, _), A).


#show p1/3.
#show p2/3.
% #show do1/2.
% #show do2/2.
% #show obs1/2.
% #show reached/1.
% #show gState/1.
% #show detect/2.
% #show aState/1.
% #show action/3.
% #show goal1_aState/1.
% #show goal_gState/1.







