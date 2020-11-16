function err = B_error(B,solution,xVals,yVals,Tend)
[X,Y] = meshgrid(xVals,yVals);
exact = @(x,y,t) 1/(sqrt(2)*pi*B) * sin(B*pi*x).*sin(B*pi*y).*sin(sqrt(2)*B*pi*t);
exactVals = exact(X,Y,Tend);
err = max(max(abs(exactVals(:,:,end) - solution(:,:,end))));
end