% Taken off the internet. Function is supposed to adapt a gaussian plot to
% given data.

function fitobject = Gauss(x,y)
% Fits the gaussian peak 
% a*exp(-(x-b)^2/c) + d
% fitobject = gauss(x,y)

sx=size(x);
sy=size(y);

if sx(2)>sx(1)
    x=x';
end

if sy(2)>sy(1)
    y=y';
end




%Calculate starting point.
a = max(y)-min(y);
[mx,mxind]=max(y);
b = x(mxind);
c = length(find(y>(mx/2)))*(x(2)-x(1));
d = min(y);
start = [a, b, c, d];

low = [0 x(1) 0.5*diff(x(1:2)) min(y)-0.3*a];

upp = [2*a x(end) x(end)-x(1) mx];


opcjedopasowania = fitoptions('Method', 'NonlinearLeastSquares','Lower',low, ...
'Startpoint', start, 'Upper', upp); 
typdopasowania = fittype('a*exp(-(x-b)^2/c^2) + d', 'options', opcjedopasowania);

fitobject=fit(x,y,typdopasowania);

end
