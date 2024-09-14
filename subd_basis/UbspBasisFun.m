function B = UbspBasisFun(u)
B(1,1) = ((1-u)^3)/6;
B(1,2) = (3*u^3-6*u^2+4)/6;
B(1,3) = (-3*u^3+3*u^2+3*u+1)/6;
B(1,4) = (u^3)/6;
end
