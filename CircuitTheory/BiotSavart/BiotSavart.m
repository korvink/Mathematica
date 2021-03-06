(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
BeginPackage["BiotSavart`"]

bsUnitVectorPotential::usage =     "bsSegmentVectorPotential[{start,end},point] returns an expression for the vector potential of the wire segment with 3D start and end coordinates at a given 3D point. Any of the three coordinates can be provided as symbols or numbers. Unit current in the wire segment is assumed.

bsSegmentVectorPotential[{pt1, pt2, ...},point] adds up the vector fields of the segments of a line specified as a list of 3D points.

bsSegmentVectorPotential[{line1, line2, ...},point] adds up the vector fields of the segments of numerous lines, each specified as a list of 3D points.
";

bsUnitMagneticInduction::usage="bs_SegmentMagneticInduction[{start,end},point] returns an expression for the magnetic induction field of the wire segment with 3D start and end coordinates at a given 3D point. Any of the three coordinates can be provided as symbols or numbers. Unit current in the wire segment is assumed.

bsUnitMagneticInduction[{pt1, pt2, ...},point] adds up the magnetic induction fields of the segments of a line specified as a list of 3D points.

bsUnitMagneticInduction[{line1, line2, ...},point] adds up the magnetic induction fields of the segments of numerous lines, each specified as a list of 3D points.";

bsAbsMagneticInduction::usage="bsAbsMagneticInduction[{start,end},point] returns an expression for the magnitude of the magnetc induction field of the wire segment with 3D start and end coordinates at a given 3D point. Any of the three coordinates can be provided as symbols or numbers. Unit current in the wire segment is assumed.

bsAbsMagneticInduction[{pt1, pt2, ...},point] adds up the magnetic induction fields of the segments of a line specified as a list of 3D points.

bsAbsMagneticInduction[{line1, line2, ...},point] adds up the magnetic induction fields of the segments of numerous lines, each specified as a list of 3D points.";

bsDipoleVectorPotential::usage="bsDipoleVectorPotential[position,point,direction] returns an expression for the dipole vector potential of a moment pointing in direction, centered at position, and evaluated at point. To achieve the classical expression, multiply the result by \[Micro]0|m|/4\[Pi].

bsDipoleVectorPotential[positions,point,moment] adds up the vector potential field for a list of dipole moments of the same strength.";

bsDipoleMagneticInduction::usage="bsDipoleMagneticInduction[position,point,direction] returns an expression for the magnetic induction dipole field of a moment pointing in direction, centered at position, and evaluated at point. To achieve the classical expression, multiply the result by \[Micro]0|m|/4\[Pi].

bsDipoleMagneticInduction[positions,point,moment] adds up the induction field for a list of dipole sources of the same strength.";


(* ::Input::Initialization:: *)
Begin["`Private`"]


(* ::Input::Initialization:: *)
(* First the vector potential *)

bsUnitVectorPotential[{xi:{_,_,_},xf:{_,_,_}},x:{_,_,_}] := Block[{ri=x-xi,rf=x-xf,l=xf-xi,L=Sqrt[l.l],evec=l/L,Ri=Sqrt[ri.ri],Rf=Sqrt[rf.rf]},
If[L>=0,N[evec Log[(Ri+Rf+L)/(Ri+Rf-L)]],\[Infinity]]
];

bsUnitVectorPotential[coil:{{_,_,_},{_,_,_},{_,_,_}..},x:{_,_,_}] := Plus@@(bsUnitVectorPotential[#,x]&/@Drop[Transpose[{coil,RotateLeft[coil]}],-1]);

bsUnitVectorPotential[coils_List,x:{_,_,_}]:=Plus@@(bsUnitVectorPotential[#,x]&/@coils);



(* ::Input::Initialization:: *)
(* Next the induction field  *)

bsUnitMagneticInduction[{xi:{_,_,_},xf:{_,_,_}},x:{_,_,_}]:=Block[{ri=x-xi,rf=x-xf,l=xf-xi,L=N[Sqrt[l.l]],evec=l/L,Ri=Sqrt[ri.ri],Rf=Sqrt[rf.rf]},
If[L>=0,N[Cross[evec,ri] (2L(Ri+Rf))/(Ri Rf) 1/((Ri+Rf)^2+L^2)],\[Infinity]]
];

bsUnitMagneticInduction[coil:{{_,_,_},{_,_,_},{_,_,_}..},x:{_,_,_}] := Plus@@(bsUnitMagneticInduction[#,x]&/@Drop[Transpose[{coil,RotateLeft[coil]}],-1]);

bsUnitMagneticInduction[coils_List,x:{_,_,_}]:=Plus@@(bsUnitMagneticInduction[#,x]&/@coils);



(* ::Input::Initialization:: *)
(* Nest the absolute value of the induction field  *)

bsAbsMagneticInduction[coil_List,x:{_,_,_}]:=Block[{f},f=bsUnitMagneticInduction[coil,x];Sqrt[f.f]];



(* ::Input::Initialization:: *)
(* Dipole expressions  *)

bsDipoleVectorPotential[position:{_,_,_},x:{_,_,_},direction:{_,_,_}]:=Block[{dist=x-position,dir = direction/(direction.direction)},Cross[dir,dist]/((dist.dist)^(3/2))];

bsDipoleVectorPotential[positions:{{_,_,_}..},x:{_,_,_},direction:{_,_,_}]:=Plus@@(bsDipoleVectorPotential[#,x,direction]&/@positions);

bsDipoleMagneticInduction[position:{_,_,_},x:{_,_,_},direction:{_,_,_}]:=Block[{dist=x-position,dir = direction/(direction.direction)},3 dist (dir.dist)/((dist.dist)^(5/2))-dir/((dist.dist)^(3/2))];

bsDipoleMagneticInduction[positions:{{_,_,_}..},x:{_,_,_},direction:{_,_,_}]:=Plus@@(bsDipoleMagneticInduction[#,x,direction]&/@positions);


(* ::Input::Initialization:: *)
End[ ]

EndPackage[ ]
