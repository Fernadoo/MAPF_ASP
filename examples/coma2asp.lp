% 2-agent fully observable with pre-defined goals in ASP. In a syntax acceptable by clingo 5.5.0


% grid world - cells
cell(0..2,0..2).

% Set goal positions - set them to be any pair of different cells

goal_position1(G1) :- G1 = (0,1).
goal_position2(G2) :- G2 = (2,0).



% states
state(S) :- S = (L1,L2,G1,G2), L1 != L2, G1 != G2,
   L1 = (X1,Y1), L2 = (X2,Y2), G1 = (X3,Y3), G2 = (X4,Y4),
   cell(X1,Y1),cell(X2,Y2),cell(X3,Y3),cell(X4,Y4).

% agent states
agent_state(S) :- S = (Obs,Goal), Obs = (Self,Other), Self != Other,
  Self = (X1,Y1), Other = (X2,Y2), Goal = (X3,Y3),
  cell(X1,Y1),cell(X2,Y2),cell(X3,Y3).

% observations
obs1(S,AS) :- state(S), S = (L1,L2,G1,G2), AS = ((L1,L2),G1).
obs2(S,AS) :- state(S), S = (L1,L2,G1,G2), AS = ((L2,L1),G2).

% available actions: available_action(S,A) - A is available in agent state S, defined in
% terms of action(X,Y,A) means action A is available when an agent is in cell (X,Y)

available_action(S,A) :- agent_state(S), S = (Obs,_), Obs = (Self,_), Self = (X,Y),
  action(X,Y,A).

action(0..1,0..2,down).
action(1..2,0..2,up).
action(0..2,1..2,left).
action(0..2,0..1,right).
action(0..2,0..2,nil).

% transitions: trans(S1,A,B,S2) - the result of performing the joint action (A,B) in S1 yields S2

trans(S1,A,B,S2) :- state(S1), S1 = (L1,L2,G1,G2), S2 = (L3,L4,G1,G2),
  L1 = (X1,Y1), L2 = (X2,Y2), L3 = (X3,Y3), L4 = (X4,Y4),
  trans1(X1,Y1,A,X3,Y3),
  trans1(X2,Y2,B,X4,Y4),
  (L1,L2) != (L4,L3), % no immediate swap
  L3 != L4.  % no collision

trans1(X1,Y1,down,X1+1,Y1) :- cell(X1,Y1).
trans1(X1,Y1,up,X1-1,Y1) :- cell(X1,Y1).
trans1(X1,Y1,left,X1,Y1-1) :- cell(X1,Y1).
trans1(X1,Y1,right,X1,Y1+1) :- cell(X1,Y1).
trans1(X1,Y1,nil,X1,Y1) :- cell(X1,Y1).

% goal state
goal(S) :- state(S), S = (G1,G2,G1,G2), goal_position1(G1), goal_position2(G2).


% agent has achieved their goal

goal_agent1(S) :- agent_state(S), S = ((G,L),G), goal_position1(G).
goal_agent2(S) :- agent_state(S), S = ((G,L),G), goal_position2(G).

% policies do1(S,A) and do2(S,A): S is an agent's state with the fixed goal

% Stop at goal
do1(X,nil) :- goal_agent1(X).
do2(X,nil) :- goal_agent2(X).
% Try an available action otherwise
{ do1(S,A) : available_action(S,A) } = 1 :-
  agent_state(S), S = ((L1,L2),G), goal_position1(G), L1 != G.
{ do2(S,A) : available_action(S,A) } = 1 :-
  agent_state(S), S = ((L1,L2),G), goal_position2(G), L1 != G.


% Define reachable states
reached(S) :- goal(S).
reached(S) :- state(S), obs1(S,Y1), obs2(S,Y2), do1(Y1,A1), do2(Y2,A2), trans(S,A1,A2,S1), reached(S1).

% check that all legal states are reachable

:- state(S), S = (L1,L2,G1,G2), goal_position1(G1), goal_position2(G2), not reached(S).

% output the two policies

% a shorter notation for policies by omitting the goal argument
p1(L1,L2,A) :- do1(((L1,L2),_),A).
p2(L1,L2,A) :- do2(((L1,L2),_),A).

#show p1/3.
#show p2/3.

