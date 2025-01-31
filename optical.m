clear all; close all; clc

I = VideoReader('TermProject_test1.mp4');
opticFlow = opticalFlowLK('NoiseThreshold',0.009);
h = figure;
movegui(h);
hViewPanel = uipanel(h,'Position',[0 0 1 1],'Title','Plot of Optical Flow Vectors');
hPlot = axes(hViewPanel);

% writer = VideoWriter("temproject1.avi");
% writer.FrameRate = I.FrameRate;
% open(writer);

while hasFrame(I)
    frame = readFrame(I);
    frameGray = im2gray(frame);
    flow = estimateFlow(opticFlow,frameGray);
%     imshow(frame)
%     hold on
%     plot(flow,'DecimationFactor',[5 5],'ScaleFactor',10,'Parent',hPlot);
%     hold off
%     pause(10^-3)
    orientation = flow.Orientation(148:352,350:422);
    [m, n] = size(orientation);
    s = sum(orientation)/(m*n);
    R = uint8(zeros(size(frame))); R(:,:,1) = frame(:,:,1);
    G = uint8(zeros(size(frame))); G(:,:,2) = frame(:,:,2);
    B = uint8(zeros(size(frame))); B(:,:,3) = frame(:,:,3);
    rgb = frame;

    % RGB가 없는 부분은 까맣게 출력됨
    one = R(98:402,338:350,1) + G(98:402,338:350,2) + B(98:402,338:350,3);
    [a, b] = size(one);
    one_a = sum(one(:))/(a*b);
    %figure(2), subplot(1,3,1), imshow(one)

    two = R(148:352,350:422,1) + G(148:352,350:422,2) + B(148:352,350:422,3);
    [c, d] = size(two);
    two_a = sum(two(:))/(c*d);
    %figure(2), subplot(1,3,2), imshow(two)

    three = R(98:402,422:437,1) + G(98:402,422:437,2) + B(98:402,422:437,3);
    [e, f] = size(three);
    three_a = sum(three(:))/(e*f);
    %figure(2), subplot(1,3,3), imshow(three) 

%     % 네모 1
%     for i = 98:402
%         for j = 338:350
%             R(i,j,1) = 0; G(i,j,2) = 255; B(i,j,3) = 0; % 범위를 확인하기위해 G=255
%             frame(i,j,1) = R(i,j,1); frame(i,j,2) = G(i,j,2); frame(i,j,3) = B(i,j,3);
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
            R(i,j,1) = 0; G(i,j,2) = 0; B(i,j,3) = 255;
            frame(i,j,1) = R(i,j,1); frame(i,j,2) = G(i,j,2); frame(i,j,3) = B(i,j,3);
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
%             R(i,j,1) = 0; G(i,j,2) = 255; B(i,j,3) = 0; % 범위를 확인하기위해 G=255
%             frame(i,j,1) = R(i,j,1); frame(i,j,2) = G(i,j,2); frame(i,j,3) = B(i,j,3);
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
                R(i,j,1) = 255; G(i,j,2) = 0; B(i,j,3) = 0;
                frame(i,j,1) = R(i,j,1); frame(i,j,2) = G(i,j,2); frame(i,j,3) = B(i,j,3);
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
                R(i,j,1) = 255; G(i,j,2) = 0; B(i,j,3) = 0; 
                frame(i,j,1) = R(i,j,1); frame(i,j,2) = G(i,j,2); frame(i,j,3) = B(i,j,3);
            end
        end
        for i = 150:350
            for j = 352:420
                frame(i,j,:) = rgb(i,j,:);
            end
        end
    end

    figure(1), imshow(frame)
    %writeVideo(writer,frame);

end

%close(writer);