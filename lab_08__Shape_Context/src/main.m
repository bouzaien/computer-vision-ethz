clear;
objects = load('dataset.mat').objects;

num_classes = 3;
cum_samples = 5;


figure()
for c=1:num_classes
    for s=1:cum_samples
        subplot(num_classes,cum_samples,(c-1)*cum_samples+s)
        imshow(objects((c-1)*cum_samples+s).img);
    end
end

X = objects(1).X;
Y = objects(2).X;

nsamp = 100;
X = get_samples(X, nsamp);
Y = get_samples(Y, nsamp);

matchingCost = shape_matching(X,Y,1);