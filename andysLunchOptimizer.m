function andysLunchOptimizer

hungry = input('How hungry are you now (0--10)? Hit enter directly if you don''t know or don''t care: ');
mood = input('What''s in your mood for lunch (pizza,sandwitch,burger,salad,soup)? Hit enter directly if you don''t know or don''t care: ','s');
distance = input('How many blocks can you walk to get your food (0--10)? Hit enter directly if you don''t know or don''t care: ');

places = {'Essen','Hestia','CafeDelSol','TwoBrothers'};
paraH = [0 0 1 1];
paraM = {'saladsoup','burgersalad','saladsandwitchsoup','pizza'};
paraD = [3 4 2 0];

fprintf('\n\n');
fprintf('Warning! Use this program at your own risk. This is just for fun and\n');
fprintf('the result is solely based on Andy''s personal knowledge. Andy is not\n');
fprintf('responsible for any bad experience during your lunch including but not limited to: \n');
fprintf('you got something you don''t like;\n');
fprintf('you walked too long to get the food;\n');
fprintf('the food cost you too much.\n');
fprintf('\n\n');

disp('Calculating...')

if ~isempty(hungry) && ~isempty(mood) && ~isempty(distance)
    
    if hungry>5
        indH = find(paraH==1); % resH = {'twobrothers'};
    else
        indH = find(paraH==0); % resH = {'essen','hestia','cafedelsol'};
    end
    
    indM = [];
    for i=1:length(paraM)
        if strfind(paraM{i},mood)
            indM = [indM;i];
        end
    end
    
    indD = find(paraD==distance);
    
    %     switch mood
    %         case 'pizza', resM = {'twobrothers'};
    %         case 'sandwitch', resM = {'cafedelsol'};
    %         case 'burger', resM = {'hestia'};
    %         case 'salad', resM = {'essen','hestia','cafedelsol'};
    %         case 'soup', resM = {'essen','cafedelsol'};
    %     end
    %     switch distance
    %         case [0 1], resD = {'twobrothers'};
    %         case 2, resD = {'cafedelsol'};
    %         case 3, resD = {'essen'};
    %         case 4, resD = {'hestia'};
    %         otherwise, resD = {};
    %     end
    % just database look up for each criterion
    %     res = intersect(resH,resM,resD);
    % intersect each result
    if ~isempty(intersect(intersect(indH,indM),indD))
        ind = intersect(intersect(indH,indM),indD);
        fprintf('Andy recommends you to go to the following place(s):\n');
        %         for i=1:length(res), fprintf('%s\t',res{i}); end
        for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
        fprintf('\n');
    elseif ~isempty(intersect(indH,indM)) || ~isempty(intersect(indH,indD)) || ~isempty(intersect(indM,indD))
        disp('You are such a picky luncher, andy''s lunch optimization does not converge under your preferences. However, here''s some advice after loosen your constraint:');
        if ~isempty(intersect(indH,indM))
            ind = intersect(indH,indM);
            fprintf('If you don''t care walking distance, here''s the place(s) you should go:\n');
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        elseif ~isempty(intersect(indH,indD))
            ind = intersect(indH,indD);
            fprintf('If you don''t care what kind of food to eat, here''s the place(s) you should go:\n');
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        elseif ~isempty(intersect(indM,indD))
            ind = intersect(indM,indD);
            fprintf('If you don''t care if you can fill up your stomach, here''s the place(s) you should go:\n');
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        end
    elseif ~isempty(indH) || ~isempty(indM) || ~isempty(indD)
        disp('You are such a picky luncher, andy''s lunch optimization does not converge under your preferences. However, here''s some advice after loosen your constraint:');
        if ~isempty(indH)
            fprintf('If you don''t care walking distance and food type, here''s the place(s) you should go:\n');
            ind = indH;
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        elseif ~isempty(indM)
            fprintf('If you don''t care walking distance and food amount, here''s the place(s) you should go:\n');
            ind = indM;
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        elseif ~isempty(indD)
            fprintf('If you don''t care food type and amount, here''s the place(s) you should go:\n');
            ind = indD;
            for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
            fprintf('\n');
        end
    else
        disp('No results found under your preferences. Please Google or Yelp yourself.');
    end % give advice based on each criterion, according to priority
    
elseif isempty(hungry) && ~isempty(mood) && ~isempty(distance)
    fprintf('You don''t even know about your stomach, then anything can feed you, here''s a good suggestion:\n');
    fprintf('%s\n',places{randi(length(places))}); % will fix
elseif ~isempty(hungry) && isempty(mood) && ~isempty(distance)
    fprintf('When you don''t know what to eat, always eat healthy. There''s lots of salad at:\n');
    indM = [];
    for i=1:length(paraM)
        if strfind(paraM{i},'salad')
            indM = [indM;i];
        end
    end
    ind = indM;
    for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
    fprintf('\n');
elseif ~isempty(hungry) && ~isempty(mood) && isempty(distance)
    fprintf('Just go to these places ''cuz they''re just downstairs\n');
    indD = find(paraD==0);
    ind = indD;
    for i=1:length(ind), fprintf('%s\t',places{ind(i)}); end
    fprintf('\n');
    
elseif isempty(hungry) && isempty(mood) || isempty(hungry) && isempty(distance) || isempty(mood) && isempty(distance)
    % elseif isempty(hungry) && isempty(distance) && isempty(mood)
    disp('You are such an easy-going guy, anything can feed you. Here''s a random pick:');
    fprintf('%s\n',places{randi(length(places))});%     do random pick
end