function [x] = rld(val,len)
% RLD   Run Length Decoding
%    X = RLD(VAL,LEN) decodes the run values, VAL, and run lengths, LEN, into
%    vector X.
%
%    Example:
%       >> VAL = [1 3 8]
%       >> LEN = [4 2 6]
%       >> X = RLD(VAL,LEN)
%    Returns:
%       VAL =
%            1     3     8
%       LEN =
%            4     2     6
%       X =
%            1     1     1     1     3     3     8     8     8     8     8     8
%
%    See also RLE.

% Steve Hoelzer
% 2003-09-04

% Error checking
if ~any(size(len)==1) | ~any(size(val)==1)
    error('len and val must be vectors.')
end
if (length(len)~=length(val))
    error('len and val vectors must be the same length.')
end

% Transpose len vector if necessary
if (size(len,2)==1)
    len = len.';
end

% Decode
i = cumsum([ 1 len ]);
k = zeros(1, i(end)-1);
k(i(1:end-1)) = 1;
x = val(cumsum(k));