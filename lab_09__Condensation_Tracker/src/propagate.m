function new_particles = propagate(particles,sizeFrame,params)
%PROPAGATE Summary of this function goes here
%   Detailed explanation goes here
if params.model == 0
    A = eye(2);
    new_particles = A * particles' + normrnd(0,params.sigma_position,2,params.num_particles);
else
    A = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
    new_particles = A * particles' + [normrnd(0,params.sigma_position,2,params.num_particles); normrnd(0,params.sigma_velocity,2,params.num_particles)];
end

x = sizeFrame(1);
y = sizeFrame(2);

% if the center is outside the frame, limit it to max or min dimensions
new_particles(1,:) = min(new_particles(1,:),y);
new_particles(1,:) = max(new_particles(1,:),1);
new_particles(2,:) = min(new_particles(2,:),x);
new_particles(2,:) = max(new_particles(2,:),1);

new_particles = new_particles';
end

