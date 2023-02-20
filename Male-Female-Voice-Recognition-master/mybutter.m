
%creating mybutter function which gets W value and return B,A values
function [B,A] = mybutter(W)  

%the tangent of W multiplied by pi/2 
% and assigns the result to the variable "V".
V  = tan(W * pi/2);   
%square of "V"   
Sg = V ^ 2;   

Sp = V * [-1-1i, -1+1i] / sqrt(2);  
P = (1 + Sp) ./ (1 - Sp);
G = real(Sg / prod(1 - Sp));
B = G * [1, 2, 1];
A = real(poly(P));
end
