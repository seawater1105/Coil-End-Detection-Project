clear all; close all; clc

I = VideoReader('TermProject_test2.mp4');

writer = VideoWriter("termproject2.avi");
writer.FrameRate = I.FrameRate;
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

    one = frame(130:570,535:555,1) + frame(130:570,535:555,2) + frame(130:570,535:555,3);
    [a, b] = size(one);
    one_a = sum(one(:))/(a*b);
    %figure(2), subplot(1,3,1), imshow(one)

    two = frame(198:522,555:655,1) + frame(198:522,555:655,2) + frame(198:522,555:655,3);
    [c, d] = size(two);
    two_a = sum(two(:))/(c*d);
    %figure(2), subplot(1,3,2), imshow(two)

    three = frame(130:570,655:675,1) + frame(130:570,655:675,2) + frame(130:570,655:675,3);
    [e, f] = size(three);
    three_a = sum(three(:))/(e*f);
    %figure(2), subplot(1,3,3), imshow(three) 

%     % 네모 1
%     for i = 130:570
%         for j = 535:555
%             frame(i,j,1) = 50; frame(i,j,2) = 50; frame(i,j,3) = 50;
%         end
%     end
%     for i = 132:568
%         for j = 537:553
%             frame(i,j,:) = rgb(i,j,:);
%         end
%     end

    % 네모 2
    for i = 198:522
        for j = 555:655
            frame(i,j,1) = 0; frame(i,j,2) = 0; frame(i,j,3) = 255;
        end
    end
    for i = 200:520
        for j = 557:653
            frame(i,j,:) = rgb(i,j,:);
        end
    end

%     % 네모 3
%     for i = 170:540
%         for j = 655:675
%             frame(i,j,1) = 50; frame(i,j,2) = 50; frame(i,j,3) = 50;
%         end
%     end
%     for i = 172:538
%         for j = 657:673
%             frame(i,j,:) = rgb(i,j,:);
%         end
%     end

    if (one_a > 254) & (two_a < 254) & (three_a < 254)
        for i = 198:522
            for j = 555:655
                frame(i,j,1) = 255; frame(i,j,2) = 0; frame(i,j,3) = 0;
            end
        end
        for i = 200:520
            for j = 557:653
                frame(i,j,:) = rgb(i,j,:);
            end
        end
    elseif (one_a < 254) & (two_a < 254) & (three_a > 254)
        for i = 198:522
            for j = 555:655
                frame(i,j,1) = 255; frame(i,j,2) = 0; frame(i,j,3) = 0;
            end
        end
        for i = 200:520
            for j = 557:653
                frame(i,j,:) = rgb(i,j,:);
            end
        end
    end

    %figure(1), imshow(frame)
    writeVideo(writer,frame);

end

close(writer);