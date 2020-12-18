function meanState = estimate(particles,particles_w)
%ESTIMATE Summary of this function goes here
%   Detailed explanation goes here

meanState = sum(particles .* particles_w,1);
end

