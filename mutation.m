function mutant = mutation(position)
    n = numel(position);
    i = randi([1 n]);
    while position(i) == 1
        i = randi([1 n]);
    end
    po = find(position == position(i)-1);
    x = randi([min(i, po) max(i, po)]);
    
    % precedence preserving shift mutation
    if x < i
        mutant = [position(1:x-1) position(i) position(x:i-1) position(i+1:end)];
    elseif x > i
        mutant = [position(1:i-1) position(i+1:x-1) position(i) position(x:end)];
    else
        mutant = mutation(position);
    end
    
end