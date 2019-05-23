function [ Sharp_Image , Edge_Image , Blur_Image ] = Sharpening(Image,FilterSize,Rate,KindofFilter)
if isempty(Rate) || Rate==0
    Rate=1;
end

if strcmp(KindofFilter,'Weighted Average')
    FilterSize = 3;
    WA_Filter = [1 2 1
                 2 4 2
                 1 2 1];
end

Image=double(Image);
Image_P=padarray(Image,[(FilterSize-1)/2 (FilterSize-1)/2]);
Blur_Image=zeros(size(Image_P));
for i=ceil(FilterSize/2):size(Image_P,1)-floor(FilterSize/2)
    for j=ceil(FilterSize/2):size(Image_P,2)-floor(FilterSize/2)
        win = Image_P(i-floor(FilterSize/2):i+floor(FilterSize/2),j-floor(FilterSize/2):j+floor(FilterSize/2));
        if strcmp(KindofFilter,'Average')
            Blur_Image(i,j) = mean(win(:));
        elseif strcmp(KindofFilter,'Median')
            Blur_Image(i,j) = median(win(:));
        else
            Blur_Image(i,j) = sum(sum((win .* WA_Filter)/16));
        end
    end
end
Blur_Image = Blur_Image(floor(FilterSize/2)+1:end-floor(FilterSize/2),...
    floor(FilterSize/2)+1:end-floor(FilterSize/2));
Edge_Image = (Image - Blur_Image);
Sharp_Image = Image + Rate * Edge_Image ;
Blur_Image = uint8(Blur_Image);
Sharp_Image = uint8(Sharp_Image);
end

