function extractFramesAndFeatures(video, outDir, step)
    %create video reader
    reader = VideoReader(video);
    nFrames = reader.NumberOfFrames;
    k=1;
    for i = 110:step:nFrames
        %extract frame
        frame = read(reader,i);
%         figure(1);
%         imshow(frame)
%         title(num2str(i))
%         pause;
        imwrite(frame, [outDir,'frame_',num2str(k),'.jpg'])
        k=k+1;
    end
end