function Bd = UniBSplineBasis1stDer(p,u)
B = zeros(p+1,p+2);
Bd = zeros(2,p+1);

right = 1-u;
B(1,2) = 1.0;

for i = 2:p+1
    saved = 0.0;
    for j = 2:i
        temp = B(i-1,j);
        B(i,j) = saved+right*temp;
        saved = u*temp;
    end
    B(i,i+1) = saved;
end

Bd(1,:) = B(end,2:end);
Bd(2,:) = (B(end-1,1:end-1)-B(end-1,2:end))*p;

end