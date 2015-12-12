function [nSmallItems, originalIndex] = nSmallWithIndex(inputMatrix, n)
%Takes a matrix and a number as input,
%Returns n smallest elements in the matrix and corresponding index.
    [sortedInput, index] = sort(inputMatrix,2);
    nSmallItems = sortedInput(:,1:n);
    originalIndex = index(:,1:n);
end