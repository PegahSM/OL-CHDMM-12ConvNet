imds = imageDatastore('top3test', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%khat zir marbut be joda sazi train va validation data ba nesbat .7 ast
%[imdsTrain,imdsTest] = splitEachLabel(imds,0.7,'randomized');
%analyzeNetwork(net) baraye barasi va moshahede sakhtar shabake be kar
%miravad
%analyzeNetwork(net)
net = top3mainnet;

inputSize = net.Layers(1).InputSize;% size of images
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);
%To automatically resize the validation images without performing further data augmentation, use an augmented image datastore without specifying any additional preprocessing operations.

layer = 'fc7';
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows');
YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;
mdl = fitcecoc(featuresTrain,YTrain);
YPred = predict(mdl,featuresTest);
idx = [1 5 10 15];
figure
for i = 1:numel(idx)
    subplot(2,2,i)
    I = readimage(imdsTest,idx(i));
    label = YPred(idx(i));
    
    imshow(I)
    title(label)
end
accuracy = mean(YPred == YTest);