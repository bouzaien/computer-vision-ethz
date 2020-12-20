function [descriptors,patches] = descriptors_hog(img,vPoints,cellWidth,cellHeight)

    nBins = 8;
    nCellsW = 4; % number of cells, hard coded so that descriptor dimension is 128
    nCellsH = 4; 

    w = cellWidth; % set cell dimensions
    h = cellHeight;   

    pw = w*nCellsW; % patch dimensions
    ph = h*nCellsH; % patch dimensions

    descriptors = zeros(0,nBins*nCellsW*nCellsH); % one histogram for each of the 16 cells
    patches = zeros(0,pw*ph); % image patches stored in rows    
    
    [grad_x,grad_y] = gradient(img);    
    Gdir = (atan2(grad_y, grad_x)); 
    
    for i = 1:size(vPoints,1) % for all local feature points
        g_point = vPoints(i,:);
        local_patch = img(g_point(1)-pw/2:g_point(1)+pw/2-1,...
            g_point(2)-ph/2:g_point(2)+ph/2-1);
        patches(i,:) = reshape(local_patch,1,pw*ph);
        
        local_grad = Gdir(g_point(1)-pw/2:g_point(1)+pw/2-1,...
            g_point(2)-ph/2:g_point(2)+ph/2-1);
        
        temp_h = [];
        
        for cw=1:nCellsW
            for ch=1:nCellsH
                c = local_grad((cw-1)*w+1:cw*w,(ch-1)*h+1:ch*h);
                temp_h = [temp_h,histcounts(c,nBins,'BinLimits',[-pi,pi])];
            end
        end
        
        descriptors(i,:) = temp_h;
        
    end % for all local feature points
    
end
