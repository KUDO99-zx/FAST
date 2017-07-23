function [ x,y ] = FAST( img,k,bool )
%Find corner point detection using FAST-9 algorithm, threshold is 50
%  IΪ����ͼ��
threshold=50;  %��ֵ
nth = 9; %FAST-9
pic = img;
[H W D]=size(pic);
if D==3
    pic=rgb2gray(pic);
end

%%
S = [-3,0;-3,1;-2,2;-1,3;0,3;1,3;2,2;3,1;3,0;3,-1;2,-2;1,-3;0,-3;-1,-3;-2,-2;-3,-1]+[4,4]; %16��������λ��
figure(3);imshow(img);title('FAST�ǵ���');hold on;
pic = double(pic);
tic;
s = zeros(H,W);
for px=4:H-3
    for py=4:W-3%��I1��I9������I0�Ĳ��С����ֵ�����Ǻ�ѡ��
        delta(1) = abs(pic(px-3,py)-pic(px,py))<threshold;
        delta(2) = abs(pic(px+3,py)-pic(px,py))<threshold;
        delta(3) = abs(pic(px,py+3)-pic(px,py))<threshold;
        delta(4) = abs(pic(px,py-3)-pic(px,py))<threshold;
        if sum(delta) <3 
            IS =[];
            block=pic(px-3:px+3,py-3:py+3);
            for i = 1:16
                IS = [IS,block(S(i,1),S(i,2))];  %Բ����16�������ε����� Intensity set
            end
            d = IS - pic(px,py);
            lv = d>threshold;
            if nConti(lv,nth) == 1
                s(px,py) = sum(lv.*d);
            else 
                lv = -d>threshold;
                if nConti(lv,nth)==1
                    s(px,py) = -sum(lv.*(d));
                end
            end
        end
    end
end



%% Non Maximal Suppression �Ǽ���ֵ���� 5x5
[x,y] = find(s~=0);

for m = 1:length(x)
    area = s(x(m)-2:x(m)+2,y(m)-2:y(m)+2);
    if s(x(m),y(m)) ~= 0
        if length(find(area)) ~= 1
            mask = zeros(5,5);
            [mx,my] = find(area == max(max(area)));
            mask(mx(1),my(1)) = 1;
            s(x(m)-2:x(m)+2,y(m)-2:y(m)+2) = mask.*area;
        end
    end
    
end


%% select Strongest point ѡ����ǿ��
if bool == true
[m,n] = size(s);
[val,index] = sort(s(:),'descend');
b=zeros(m*n,1);
b(index(1:k))=val(1:k);
s = reshape(b,[m,n]);
end

%%
[y,x] = find(s~=0);  %���������������

for n = 1:length(x)
    plot(x(n),y(n),'g+'); hold on;
end
hold off;

toc;
%%

end

