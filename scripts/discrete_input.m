Ti = 50.0;
A_prim = expm(A1*Ti);
integ = A1\(expm(A1*Ti)-eye(4));
B_prim = integ*B1;

