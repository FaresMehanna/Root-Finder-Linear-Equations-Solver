function [ isValid, xl, xu, root, totalTime, itr_count ,errors ] = Bisection( equation, max_itr, epsilon, xlower, xupper )

%make equation numerical not string
equation = inline(equation);

%set errors array
errors(1) = 1;
isValid =0;
if(equation(xlower) * equation(xupper) > 0)
    isValid = 0;
    return;
end

%check if you find the root in first iteration
found = 0;

%set arrays
xu(1) = xupper;
xl(1) = xlower;
root(1) = (xu(1) + xl(1))/2;

%time starts
t = cputime; 

if(equation(xl(1)) == 0)
    root(2) = xl(1);
    found = 1;
    isValid = 1;
elseif(equation(xu(1)) == 0)
    root(2) = xu(1);
    found = 1;
    isValid = 1;
elseif(equation(root(1)) * equation(xl(1)) < 0)
    xl(2) = xl(1);
    xu(2) = root(1);
    i = 2;
elseif(equation(root(1)) * equation(xl(1)) > 0)
    xu(2) = xu(1);
    xl(2) = root(1);
    i = 2;
else
    isValid = 1;
    found = 1;
    i = 1;
end

while(i <= max_itr && found == 0)
    root(i) = (xu(i) + xl(i))/2;
    if(equation(root(i)) * equation(xl(i)) < 0)
        xl(i+1) = xl(i);
        xu(i+1) = root(i);
    elseif(equation(root(i)) * equation(xl(i)) > 0)
        xu(i+1) = xu(i);
        xl(i+1) = root(i);
    else
        isValid = 1;
        break;    
    end
  
    errors(i) = abs(root(i) - root(i-1));
    
    %check error
    if(errors(i) < epsilon)
        isValid = 1;
        break;
    end
    
    %increase counter
    i = i+1;
end

itr_count = i;
%compute total time
totalTime = (cputime-t) * 1000;

end
