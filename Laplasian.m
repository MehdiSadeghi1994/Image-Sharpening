function [ Sharp_Image , Edge_Image ] = Laplasian( Image , Mode , Scale )

if isempty(Scale) || Scale==0 
   Scale=1; 
end
Image=double(Image);
Image_P=padarray(Image,[2 2]);
Edge_Image=zeros(size(Image_P));

LaplasianWin_v(:,:,1)=[0 0 0; ...
                      -2 2 0; ...
                       0 0 0];
LaplasianWin_v(:,:,2)=[-1 0 0; ...
                        0 1 0; ...
                        0 0 0];
LaplasianWin_v(:,:,3)=[0 -2 0; ...
                       0  2 0; ...
                       0  0 0];
LaplasianWin_v(:,:,4)=[ 0 0 -1; ...
                        0 1 0; ...
                        0 0 0];
LaplasianWin_v(:,:,5)=[0 0 0; ...
                       0  2 -2; ...
                       0  0 0];     
LaplasianWin_v(:,:,6)=[ 0 0 0; ...
                        0 1 0; ...
                        0 0 -1];    
LaplasianWin_v(:,:,7)=[0 0 0; ...
                       0  2 0; ...
                       0  -2 0]; 
LaplasianWin_v(:,:,8)=[ 0 0 0; ...
                        0 1 0; ...
                        -1 0 0];                    
if strcmp(Mode,'Unadaptiv')
    LaplasianWin=[-1 -2 -1; ...
                  -2 12 -2; ...
                  -1 -2 -1];
    for i=2:size(Image_P,1)-1
        for j=2:size(Image_P,2)-1
            win = Image_P(i-1:i+1,j-1:j+1);
            Edge_Image(i,j) = sum(sum(win .* LaplasianWin))/16;
        end
    end
    
else
    
    for i=2:size(Image_P,1)-1
        for j=2:size(Image_P,2)-1
            win = Image_P(i-1:i+1,j-1:j+1);
            for p=1:8
                LaplasianWin(p)= sum(sum(win .* LaplasianWin_v(:,:,p)));
            end
            [~ , idx]= find(LaplasianWin>mean(LaplasianWin));
            Edge_Image(i,j) = sum(LaplasianWin(idx))/16;
            
            
        end
    end
end


Sharp_Image = Image - Scale *  Edge_Image(3:end-2,3:end-2);
Sharp_Image = Sharp_Image - min(Sharp_Image(:));
Sharp_Image = Sharp_Image * (255/max(Sharp_Image(:)));
Sharp_Image = uint8(Sharp_Image);

end