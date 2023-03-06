function Fx = iden_frame(y,Fs,b0,a0, frame,nth )

for i=1:length(y)/frame
    x=y(1+(i-1)*frame:i*frame);
    xin1 = abs(x);
   % xin=myfilter(b0,a0,xin); 
raw=xin1;
filtered = zeros(size(raw));

switch nth

    case 1
        for n = nth+1:size(raw,1)

        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) ...                
                                          - a0(2)*filtered(n-1,1) ;
        end

    case 2
        for n = nth+1:size(raw,1)

        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1) ...                
                                           - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1) ;
        end
    

    case 3
        for n = nth+1:size(raw,1)

        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1)+b0(4)* raw(n-3,1) ...                
                                           - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)- a0(4)*filtered(n-3,1) ;
        end

    case 4
        for n = nth+1:size(raw,1)

        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1)     + b0(3)* raw(n-2,1)        + b0(4)* raw(n-3,1)     + b0(5)* raw(n-4,1) ...                
                                          - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)    - a0(4)*filtered(n-3,1) - a0(5)*filtered(n-4,1) ;
        end
    
    case 5
        for n = nth+1:size(raw,1)
        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1)+ b0(4)* raw(n-3,1) + b0(5)* raw(n-4,1)+ b0(6)* raw(n-5,1) ...                
                                            - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)- a0(4)*filtered(n-3,1) - a0(5)*filtered(n-4,1)- a0(6)*filtered(n-5,1) ;
        end

    case 6
        for n = nth+1:size(raw,1)
        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1)+ b0(4)* raw(n-3,1) + b0(5)* raw(n-4,1)+ b0(6)* raw(n-5,1)+ b0(7)* raw(n-6,1) ...                
                                         - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)- a0(4)*filtered(n-3,1) - a0(5)*filtered(n-4,1)- a0(6)*filtered(n-5,1)- a0(7)*filtered(n-6,1) ;
        end
    case 7
        for n = nth+1:size(raw,1)
        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1)+ b0(4)* raw(n-3,1) + b0(5)* raw(n-4,1)+ b0(6)* raw(n-5,1)+ b0(7)* raw(n-6,1)+ b0(7)* raw(n-6,1)+ b0(8)* raw(n-7,1) ...                
                                          - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)- a0(4)*filtered(n-3,1) - a0(5)*filtered(n-4,1)- a0(6)*filtered(n-5,1)- a0(7)*filtered(n-6,1) - a0(8)*filtered(n-7,1) ;
        end

    case 8
        for n = nth+1:size(raw,1)
        filtered(n,1) = b0(1)* raw(n,1)   + b0(2)* raw(n-1,1) + b0(3)* raw(n-2,1)+ b0(4)* raw(n-3,1) + b0(5)* raw(n-4,1)+ b0(6)* raw(n-5,1)+ b0(7)* raw(n-6,1)+ b0(7)* raw(n-6,1)+ b0(8)* raw(n-7,1)+ b0(9)* raw(n-8,1) ...                
                                          - a0(2)*filtered(n-1,1) - a0(3)*filtered(n-2,1)- a0(4)*filtered(n-3,1) - a0(5)*filtered(n-4,1)- a0(6)*filtered(n-5,1)- a0(7)*filtered(n-6,1)- a0(8)*filtered(n-7,1)-a0(9)*filtered(n-8,1) ;
        end
end
    
xin = filtered;
    xin = xin-mean(xin);   
    x2=zeros(length(xin),1);
    x2(1:length(x)-1)=xin(2:length(x));
    zc=length(find((xin>0 & x2<0) | (xin<0 & x2>0)));
    F0(i)=0.5*Fs*zc/length(x);
    
end
Fx=mean(F0); % Take mean of all the frequency for each frame

