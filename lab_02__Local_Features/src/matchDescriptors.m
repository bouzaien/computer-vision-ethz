% Match descriptors.
%
% Input:
%   descr1        - k x q descriptor of first image
%   descr2        - k x q' descriptor of second image
%   matching      - matching type ('one-way', 'mutual', 'ratio')
%   
% Output:
%   matches       - 2 x m matrix storing the indices of the matching
%                   descriptors
function matches = matchDescriptors(descr1, descr2, matching)
    distances = ssd(descr1, descr2);
    [s1,s2] = size(distances);    
    
    if strcmp(matching, 'one-way')
        [~,b] = min(distances,[],2);
        matches = [[1:s1]; b'];
    elseif strcmp(matching, 'mutual')
        [~,b] = min(distances,[],2);
        matches_1 = [[1:s1]; b'];
        [~,c] = min(distances,[],1);
        matches_2 = [c;[1:s2]];
        matches = intersect(matches_1',matches_2','rows')';
    elseif strcmp(matching, 'ratio')
        t = 0.5;
        [a,b] = min(distances,[],2);
        matches = [[1:s1]; b'];
        matches = matches(:,a<=t);
    else
        error('Unknown matching type.');
    end
end

function distances = ssd(descr1, descr2)
    distances = pdist2(descr1',descr2');
end