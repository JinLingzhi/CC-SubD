function Bd = UniBSplineBasis2ndDer(p,u)
B = zeros(p+1,p+3);
Bd = zeros(3,p+1);

right = 1-u;
B(1,3) = 1.0;

for i = 2:p+1
    saved = 0.0;
    for j = 3:i+1
        temp = B(i-1,j);
        B(i,j) = saved+right*temp;
        saved = u*temp;
    end
    B(i,i+2) = saved;
end

Bd(1,:) = B(end,3:end);
Bd(2,:) = (B(end-1,2:end-1)-B(end-1,3:end))*p;
Bd(3,:) = (B(end-2,1:end-2)-2*B(end-2,2:end-1)+B(end-2,3:end))*p*(p-1);

end