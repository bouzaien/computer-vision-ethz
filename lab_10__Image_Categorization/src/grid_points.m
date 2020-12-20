function vPoints = grid_points(img,nPointsX,nPointsY,border)

    [x,y] = size(img);
    [gX,gY] = meshgrid(round(linspace(border+1, y-border, nPointsX)),round(linspace(border+1, x-border, nPointsY)));
    vPoints = [reshape(gY,[],1),reshape(gX,[],1)]; % Nx2 = (nPointsX.nPointsY)x2
    
end
