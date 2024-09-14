function Bd = UbspBasis2ndDer(u)
Bd(1,1) = ((1-u)^3)/6;
Bd(1,2) = (3*u^3-6*u^2+4)/6;
Bd(1,3) = (-3*u^3+3*u^2+3*u+1)/6;
Bd(1,4) = (u^3)/6;
Bd(2,1) = (-(1-u)^2)/2;
Bd(2,2) = (3*u^2-4*u)/2;
Bd(2,3) = (-3*u^2+2*u+1)/2;
Bd(2,4) = (u^2)/2;
Bd(3,1) = (1-u);
Bd(3,2) = (3*u-2);
Bd(3,3) = (-3*u+1);
Bd(3,4) = (u);
end