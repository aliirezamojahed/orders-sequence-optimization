function pop = generate_population(n, m, init)

    empty_individual.position = [];
    empty_individual.profit = 0;
    empty_individual.penalty = 0;
    empty_individual.refused = [];
    pop = repmat(empty_individual, n, 1);
    
    if init
        for i = 1:n
            rp = randperm(m); % random permutation of cells
            pop(i).position = rp;
            [pop(i).profit, pop(i).penalty, pop(i).refused] = fit_func(rp);
        end
    end
end