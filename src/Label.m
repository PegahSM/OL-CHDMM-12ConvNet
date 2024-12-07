% load frontHHf;
% load frontHLf;
% load frontLHf;
% load frontLLf;
% 
% load sideHHf;
% load sideHLf;
% load sideLHf;
% load sideLLf;
% 
% load topHHf;
% load topHLf;
% load topLHf;
% load topLLf;
% 
% load ttscenario2feature;
% load stscenario2feature;
% load sfscenario2feature;
%%++  +frontHHf+frontHLf+frontLHf+frontLLf+sideHHf +sideHLf + sideLHf+ sideLLf
features=zeros(15,20);
c=zeros(1,5);
label=zeros(275,1);
for i=1 : 275
 
        features(1,:)=frontHHf(i,:);
         features(2,:)=frontHLf(i,:);
          features(3,:)=frontLHf(i,:);
           features(4,:)=frontLLf(i,:);
           
            features(5,:)=sideHHf(i,:);
             features(6,:)=sideHLf(i,:);
              features(7,:)=sideLHf(i,:);
               features(8,:)=sideLLf(i,:);
               
                features(9,:)=topHHf(i,:);
                 features(10,:)=topHLf(i,:);
                  features(11,:)=topLHf(i,:);
                   features(12,:)=topLLf(i,:);
                   
                    features(13,:)=ttscenario2feature(i,:);
                     features(14,:)=stscenario2feature(i,:);
                      features(15,:)=sfscenario2feature(i,:);
                      
% %                       p=features;
% %                       ssp=reshape(features,[1,300])
% %                       sp=sort(ssp,'descend');
% %                       mx=sp(1);
% %                       mx2=sp(2);
% %                       mx3=sp(3);
% %                       mx4=sp(4);
% %                       mx5=sp(5);
% %                      [row ,column ]=find(features(:,:)==mx);
% %                      [row ,column1 ]=find(features(:,:)==mx2);
% %                      [row ,column2 ]=find(features(:,:)==mx3);
% %                      [row ,column3 ]=find(features(:,:)==mx4);
% %                      [row ,column4 ]=find(features(:,:)==mx5);
% % 
% %                      c(1,1)=column;
% %                      c(1,2)=column1;
% %                      c(1,3)=column2;
% %                      c(1,4)=column3;
% %                      c(1,5)=column4;
                     p=prod(features);
                     [a,t]=find(p==max(p));
                     label(i,1)=t;
end
        
% % featuretest=(topHHf +topHLf +topLHf+topLLf+ttscenario2feature+stscenario2feature+sfscenario2feature)/7;
% % class=featuretest';
% % [row,column]=find(class==max(class));
% % label=row;
imdstTest=imageDatastore('HighHighTestTop','IncludeSubfolders',true,'LabelSource','foldernames');
 YTest = imdstTest.Labels;
 a = str2double(cellstr(YTest));
  accuracy =sum( eq(label,a))/275;
  