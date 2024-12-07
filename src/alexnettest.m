imdstTest=imageDatastore('LowLowTestTop','IncludeSubfolders',true,'LabelSource','foldernames');
load topLLnet;
HHnet=topLLnet;
inputSize =topLLnet.Layers(1).InputSize;
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdstTest);
        layer = 'softmax';
        featurestTest = activations(topLLnet,augimdsTest,layer,'OutputAs','rows'); 

