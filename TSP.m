% Code repository: http://www.mathworks.com/matlabcentral/fileexchange/13680-traveling-salesman-problem-genetic-algorithm

xy = loadcitylocations;
[nCityNodes,nDimentions] = size(xy);
array = meshgrid(1:nCityNodes);
cityDistancesMatrix = reshape(sqrt(sum((xy(array,:)-xy(array',:)).^2,2)),nCityNodes,nCityNodes);
populationSize = 500;
numberOfIterations = 1000;
pCrossover = 0.4;
mutationProbability = 0.001;
tournamentProbability = 0.95;
[nCityNodes,nDimentions] = size(xy);
population = zeros(populationSize,nCityNodes);   % 500*50
globalMinimum = Inf;                % positive infinity
pathLength = zeros(1,populationSize);
distanceHistory = zeros(1,numberOfIterations);

tempPopulation = zeros(4,nCityNodes);
newPopulation = zeros(populationSize,nCityNodes);

for k = 1:populationSize
    population(k,:) = randperm(nCityNodes);
end

pfig = figure('Name','TSP','Numbertitle','off');

for i = 1:numberOfIterations
    for p = 1:populationSize
        d = cityDistancesMatrix(population(p,nCityNodes),population(p,1));
        for k = 2:nCityNodes
            d = d + cityDistancesMatrix(population(p,k-1),population(p,k));
        end
        pathLength(p) = d;
    end
    
    [minDistance,index] = min(pathLength);
    distanceHistory(i) = minDistance;
    if minDistance < globalMinimum
        globalMinimum = minDistance;
        bestPath = population(index,:);
        % plot
        figure(pfig);
        path = bestPath([1:nCityNodes 1]);
        plot(xy(path,1),xy(path,2),'b.:');
    end
    % 
    randomPair = randperm(populationSize);
    for p = 4:4:populationSize
        paths = population(randomPair(p-3:p),:);
        dists = pathLength(randomPair(p-3:p));
        [~,idx] = min(dists);
        best_of_4_rte = paths(idx,:);
        ins_pts = sort(ceil(nCityNodes*rand(1,2)));
        I = ins_pts(1);
        J = ins_pts(2);
        for k = 1:4
            tempPopulation(k,:) = best_of_4_rte;
            switch k
                case 2
                    tempPopulation(k,I:J) = fliplr(tempPopulation(k,I:J));
                case 3
                    tempPopulation(k,[I J]) = tempPopulation(k,[J I]);
                case 4
                    tempPopulation(k,I:J) = tempPopulation(k,[I+1:J I]);
                otherwise
            end
        end
        newPopulation(p-3:p,:) = tempPopulation;
    end
    population = newPopulation;
    xy;
    
end

minDistance, bestPath

