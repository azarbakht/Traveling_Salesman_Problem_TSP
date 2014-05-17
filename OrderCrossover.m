function [c1new, c2new] = OrderCrossover(c1, c2)

numberOfGenes = length(c1);

breakIndex1 = 1 + fix(rand*(numberOfGenes-1));
breakIndex2 = 1 + fix(rand*(numberOfGenes-1));

if breakIndex1 > breakIndex2
    temp = breakIndex1;
    breakIndex1 = breakIndex2;
    breakIndex2 = temp;
end

lengthOfIntactPart = breakIndex2 - breakIndex1;
for i = 0:(lengthOfIntactPart)
    temp1(i+1) = c1(i+breakIndex1);
    temp2(i+1) = c2(i+breakIndex1);
end

c1(breakIndex1:breakIndex2) = [];
c2(breakIndex1:breakIndex2) = [];

for j = 1:(numberOfGenes-breakIndex2)
    c1 = c1([end 1:end-1]);
    c2 = c2([end 1:end-1]);
end

c1 = [c1(1:(breakIndex1-1)); temp2'; c1((breakIndex1):end)];
c2 = [c2(1:(breakIndex1-1)); temp1'; c2((breakIndex1):end)];

c1new = c1;
c2new = c2;

