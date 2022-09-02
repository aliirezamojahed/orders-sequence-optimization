function [profit, penalty, refused] = evaluation(position)
    global tasks;
    time = 0;
    profit = 0;
    penalty = 0;
    refused = [];
    
    for i = position
        time = time + tasks(i).time;
        if time > tasks(i).deadline
            if not(tasks(i).is_vip) && ...
                tasks(i).profit <= tasks(i).penalty * (time - tasks(i).deadline)
                refused = [refused i];
                time = time - tasks(i).time;
                continue
            else 
                penalty = penalty + tasks(i).penalty * (time - tasks(i).deadline);
            end
        end
        profit = profit + tasks(i).profit;
    end
end