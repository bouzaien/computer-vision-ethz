function particles_w = observe(particles,frame,H,W,hist_bin,hist_target,sigma_observe)
%OBSERVE Summary of this function goes here
%   Detailed explanation goes here

N = size(particles,1);
particles_w = zeros(N,1); 
[y, x, ~] = size(frame);

for i = 1:N
    xMin = max(particles(i,1) - W/2, 1);
    xMax = min(particles(i,1) + W/2, x);
    yMin = max(particles(i,2) - H/2, 1);
    yMax = min(particles(i,2) + H/2, y);
    particule_hist = color_histogram(xMin,yMin,xMax,yMax,frame,hist_bin);
    distance = chi2_cost(hist_target,particule_hist);
    particles_w(i) = 1/(sqrt(2*pi)*sigma_observe) * exp(-(distance^2)/(2*sigma_observe^2));
end
particles_w = particles_w / sum(particles_w);
end

