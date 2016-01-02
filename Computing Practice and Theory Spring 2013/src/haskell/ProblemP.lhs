Prove 1 + r + ... + r^n = (1 - r^n+1) / (1 - r):

Base Case: Prove for n = 0;

	r^0	= (1 - r^1) / (1 - r)
	1 	= (1 - r) / (1 - r)
	1	= 1
	I.H. true for n = 0.

Inductive Step: Show for n + 1.

	(1 - r^n+1) / (1 - r) + r^n+1 = (1 - r^n+2) / (1 - r)
	(1 - r^n+1) / (1 - r) + ((1 - r)*r^n+1 / (1 - r)) = (1 - r^n+2) / (1-r)
	(1 - r^n+2) / (1 - r) = (1 - r^n+2) / (1 - r)
	I.H. true

PROBLEM P:

The precondition for Puff() is that the carState may have reached the appopriate distance for rolling down the other side of the hill by PushCar()

This is simply a do-while problem; where at least one procedural instance of a loop is guarenteed a run through before running through the loop
	
	int s = 3;
	do {
		push();
		puff();
		roll();
	} while (carState < 50) 

This Haskell simulation runs and recursively counts the puffs; run with an initial state of 3.  This is the invariant.

Reasoning Table
State		Code			Assume			Confirm
0					s=>0			s < 50
		npuffs=npuffs+1			
1					npuffs=#npuffs+1	s < 50
		s += 3						
2					s = #s+3		s < 50
		s -= 2
3					s = #s-2		s => 50		

> carState s pPuffs
> 	| s < 50 	= carState (s + push s) (pPuffs + 1)
> 	| otherwise	= pPuffs

> push n = roll 3

> roll :: Int -> Int
> roll n = n - 2

Program Run:

*Main> carState 3 0
47
