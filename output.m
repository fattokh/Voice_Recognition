%% Identify the frequency of each frame

function output(filter, name)

if filter>165   % set the threshold
    fprintf('Estimated frequency %s is %3.2f Hz. Female voice\n',name,filter);

else
    fprintf('Estimated frequency %s is %3.2f Hz. Male voice\n',name,filter);

    


end