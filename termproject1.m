clear all; close all; clc

I = VideoReader('TermProject_test1.mp4');

writer = VideoWriter("termproject1.avi");
open(writer);

while hasFrame(I)
    frame = readFrame(I);

    rgb = frame;
    
%     R = uint8(zeros(size(frame))); R(:,:,1) = frame(:,:,1); figure(1), subplot(1,3,1), imshow(R)
%     G = uint8(zeros(size(frame))); G(:,:,2) = frame(:,:,2); figure(1), subplot(1,3,2), imshow(G)
%     B = uint8(zeros(size(frame))); B(:,:,3) = frame(:,:,3); figure(1), subplot(1,3,3), imshow(B)
%     RRGGBB = R+G+B; figure(2), imshow(RRGGBB)   

%     RR = frame(:,:,1); figure(1), subplot(1,3,1), imshow(RR)
%     GG = frame(:,:,2); figure(1), subplot(1,3,2), imshow(GG)
%     BB = frame(:,:,3); figure(1), subplot(1,3,3), imshow(BB)
%     RGB = RR+GG+BB; figure(2), imshow(RGB)

    one = frame(98:402,338:350,1) + frame(98:402,338:350,2) + frame(98:402,338:350,3);
    [a, b] = size(one);
    one_a = sum(one(:))/(a*b);
    %figure(2), subplot(1,3,1), imshow(one)

    two = frame(148:352,350:422,1) + frame(148:352,350:422,2) + frame(148:352,350:422,3);
    [c, d] = size(two);
    two_a = sum(two(:))/(c*d);
    %figure(2), subplot(1,3,2), imshow(two)

    three = frame(98:402,422:437,1) + frame(98:402,422:437,2) + frame(98:402,422:437,3);
    [e, f] = size(three);
    three_a = sum(three(:))/(e*f);
    %figure(2), subplot(1,3,3), imshow(three) 

%     % 네모 1
%     for i = 98:402
%         for j = 338:350
%             frame(i,j,1) = 50; frame(i,j,2) = 50; frame(i,j,3) = 50;
%         end
%     end
%     for i = 100:400
%         for j = 340:348
%             frame(i,j,:) = rgb(i,j,:);
%         end
%     end

    % 네모 2
    for i = 148:352
        for j = 350:422
            frame(i,j,1) = 0; frame(i,j,2) = 0; frame(i,j,3) = 255;
        end
    end
    for i = 150:350
        for j = 352:420
            frame(i,j,:) = rgb(i,j,:);
        end
    end

%     % 네모 3
%     for i = 98:402
%         for j = 422:437
%             frame(i,j,1) = 50; frame(i,j,2) = 50; frame(i,j,3) = 50;
%         end
%     end
%     for i = 100:400
%         for j = 424:435
%             frame(i,j,:) = rgb(i,j,:);
%         end
%     end

    if (one_a > 254) & (two_a < 254) & (three_a < 254)
        for i = 148:352
            for j = 350:422
                frame(i,j,1) = 255; frame(i,j,2) = 0; frame(i,j,3) = 0;
            end
        end
        for i = 150:350
            for j = 352:420
                frame(i,j,:) = rgb(i,j,:);
            end
        end
    elseif (one_a < 254) & (two_a < 254) & (three_a > 254)
        for i = 148:352
            for j = 350:422
                frame(i,j,1) = 255; frame(i,j,2) = 0; frame(i,j,3) = 0;
            end
        end
        for i = 150:350
            for j = 352:420
                frame(i,j,:) = rgb(i,j,:);
            end
        end
    end

    %figure(1), imshow(frame)
    writeVideo(writer,frame);

end

close(writer);


