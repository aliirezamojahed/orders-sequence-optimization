function [c1, c2] = crossover(p1, p2)
    n = randi([1 2]);
    i = numel(p1);

    if n == 1
        % single point order crossover
        r = randi([1 i-1]);
        
        sp1 = p1(1:r);
        a = setdiff(p2, sp1);
        index = ismember(p2,a);
        c1 = [sp1 p2(index)];
        
        sp2 = p2(1:r);
        a = setdiff(p1, sp2);
        index = ismember(p1, a);
        c2 = [sp2 p1(index)];
    elseif n == 2
        % two point order crossover
        r = randi([1 i-1], [1 2]);
        r1 = min(r);
        r2 = max(r);

        sp1 = p1(r1:r2);
        a = setdiff(p2, sp1);
        index = ismember(p2,a);
        c2 = [p2(index) sp1];
        
        sp2 = p2(r1:r2);
        a = setdiff(p1, sp2);
        index = ismember(p1,a);
        c1 = [p1(index) sp2];
    end
end