function [nsmallitems, originalindices] = nsmall(inputMatrix, n)
% Takes a matrix and a number as input,
% Returns n smallest elements in every row of matrix and corresponding indices.

    [sortedInput, index] = sort(inputMatrix,2);
    nsmallitems = sortedInput(:,1:n);
    originalindices = index(:,1:n);
end