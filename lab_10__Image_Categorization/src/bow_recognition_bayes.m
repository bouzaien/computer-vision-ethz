function label = bow_recognition_bayes(histogram, vBoWPos, vBoWNeg)


    [muPos, sigmaPos] = computeMeanStd(vBoWPos);
    [muNeg, sigmaNeg] = computeMeanStd(vBoWNeg);

    % Calculating the probability of appearance each word in observed histogram
    % according to normal distribution in each of the positive and negative bag of words
    
    pos = 0;
    neg = 0;
    
    N = size(vBoWPos,2);
    for i = 1:N
        p = log(normpdf(histogram(:,i), muPos(i), sigmaPos(i)));
        n = log(normpdf(histogram(:,i), muNeg(i), sigmaNeg(i)));
        if ~isnan(p)
            pos = pos + p;
        end
        if ~isnan(n)
            neg = neg + n;
        end
    end
    
    pos = exp(pos);
    neg = exp(neg);
    
    if pos > neg
        label = 1;
    else
        label = 0;
    end

end