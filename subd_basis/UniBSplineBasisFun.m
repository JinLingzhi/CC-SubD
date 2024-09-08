function B = UniBSplineBasisFun(u)

knots = [-3 -2 -1 0 1 2 3 4];

B = eye(1,4);
left = zeros(4,1);
right = zeros(4,1);

for i = 1:3
    left(i+1) = u-knots(5-i);
    right(i+1) = knots(4+i)-u;
    saved = 0;
    for j = 1:i
        temp = B(j)/(left(i-j+2)+right(j+1));
        B(j) = saved+right(j+1)*temp;
        saved = left(i-j+2)*temp;
    end
    B(i+1) = saved;
end

end
