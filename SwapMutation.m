function cNew = SwapMutation(c, mutationProbability, nGenes)

for j = 1:nGenes
    index1 = 1 + fix(rand*(nGenes-1));
    index2 = 1 + fix(rand*(nGenes-1));
    r = rand;
    if (r < mutationProbability)
        c(index1) = c(index2);
        c(index2) = c(index1);
    end
end
cNew = c;