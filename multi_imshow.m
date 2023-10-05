function y=multi_imshow(A)
% imshow 2D multi XY image, A=[X,Y,index], multi_imshow(A,scale)
A=squeeze(A);
sz = size(A);
for idx=1:sz(end)
    figure(77); imagesc(A(:,:,idx)); colormap gray; title([num2str(idx) '/' num2str(sz(end))]);
    pause
end
end