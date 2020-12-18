function [particles particles_w] = resample(particles,particles_w)
%RESAMPLE Summary of this function goes here
%   Detailed explanation goes here
N = size(particles,1);
new_particles = datasample(particles, N, 'replace', true, 'Weights', particles_w);

new_particles_w = zeros(N,1);

for i = 1:N
    old_index = find(new_particles(i,:) == particles(:,:), 1);
    new_particles_w(i) = particles_w(old_index);
end

particles_w = new_particles_w / sum(new_particles_w);
particles = new_particles;
end


