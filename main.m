close all
clearvars
clc

% parameters definition
no_tasks = input('Enter number of tasks: ');
no_iteration = 5 * no_tasks;        % number of iteration
no_population = 100;                % number of population
cp = 0.4;                           % childs precentage / 2
nc = 2 * round(cp * no_population / 2);     % half of number of childs
mp = 0.1;                           % mutants precentage
nm = 2 * round(mp * nc);            % number of mutants

% initialization
prompt = 'Enter every task in one line in this format: [time, profit, deadline, penalty, is_vip]';
task.time = NaN;
task.profit = NaN;
task.deadline = NaN;
task.penalty = NaN;
task.is_vip = NaN;
bestprofit = zeros(no_iteration);

global tasks
tasks = repmat(task, no_tasks, 1);

disp(prompt)
for i = 1:no_tasks
    data = input(['task ', num2str(i), ': ']);
    tasks(i).time = data(1);
    tasks(i).profit = data(2);
    tasks(i).deadline = data(3);
    tasks(i).penalty = data(4);
    tasks(i).is_vip = data(5);
end

population = generate_population(no_population, no_tasks, true);

% main loop
for i = 1:no_iteration
    % crossover
    popc = generate_population(nc, 0, false);
    for j = 0:nc
        % parent selection
        p1 = population(randi([1 no_population]));
        p2 = population(randi([1 no_population]));
        [popc(2*j+1).position, popc(2*j+2).position] = ...
            crossover(p1.position, p2.position);
        % offspring evaluation 
        [popc(2*j+1).profit, popc(2*j+1).penalty, popc(2*j+1).refused] ...
                = evaluation(popc(2*j+1).position);
        [popc(2*j+2).profit, popc(2*j+2).penalty, popc(2*j+2).refused] ...
                = evaluation(popc(2*j+2).position);
    end
    % mutation
    popm = generate_population(nm, 0, false);
    for j = 1:nm
        popm(j).position = mutation(popc(randi([1 nc])).position);
        [popm(j).profit, popm(j).penalty, popm(j).refused] = evaluation(popm(j).position);
    end
    
    % merge
    population = [population; popc; popm];
    % sort population
    profit = [population.profit];
    penalty = [population.penalty];
    [profit, order] = sort(profit-penalty, 'descend');
    population = population(order);
    % truncation
    population = population(1:no_population);
    
    bestprofit(i) = population(1).profit - population(1).penalty;
end

% show results
plot(1:no_iteration, bestprofit(1:no_iteration), 'LineWidth', 1)
hold on
plot(1:no_iteration, repmat(bestprofit(no_iteration), 1, no_iteration), '--r')
xlabel('iteration'); ylabel('best profit');title('Optimization')
grid on
result = setdiff(population(1).position, population(1).refused);
index = ismember(population(1).position, result);
disp(['optimal solution for order of tasks: ', num2str(population(1).position(index))])
disp(['refused tasks: ', num2str(population(1).refused)])
