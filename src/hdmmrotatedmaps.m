    % Human action recognition
%my first try with h1 subband level 2 and svm 
% Test dataset : MSR Action3D
% Cross Subject Test
% by Chen Chen, The University of Texas at Dallas
% chenchen870713@gmail.com

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Subjects for training and testing are FIXED.
%%%%%%% Subject 1 3 5 7 9 as training subjects, the rest as testing subjects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



file_dir = 'MSR-Action3D2\';
ActionNum = ['02', '03', '05', '06', '10', '13', '18', '20'; % first row corresponds to action subset 'AS1'
             '01', '04', '07', '08', '09', '11', '14', '12'; % second row corresponds to action subset 'AS2'
             '06', '14', '15', '16', '17', '18', '19', '20']; % third row corresponds to action subset 'AS3'1','a12','a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a19', 'a20']; % third row corresponds to action subset 'AS3'
            
NumAct = 8;          % number of actions in each subset

max_subject = 10;    % maximum number of subjects for one action
max_experiment = 3;  % maximum number of experiments performed by one subject
lambda = 0.001;
%frame_remove = 5;    % remove the first and last five frames (mostly the subject is in stand-still position in these frames)



fix_size_front = [104;52]; fix_size_side = [104;84]; fix_size_top = [84;52];

%%
%subset = 1;
%subset = 2;
subset =1;
TargetSet = ActionNum(subset,:);

%% Generate DMM for all depth sequences in one action set

subject_ind = cell(1,NumAct);
OneActionSample = zeros(1,NumAct);

error = zeros(1,NumAct);
count=0;
c=cell(2,231);
%direction='01';
%parpool('local',4);
for i = 1:NumAct
    action = TargetSet((i-1)*2+1:i*2);
    action_dir = strcat(file_dir,action,'\');
    fpath = fullfile(action_dir, '*.mat');
    depth_dir = dir(fpath);
    ind = zeros(1,length(depth_dir));
       for j = 1:length(depth_dir)
       
        depth_name = depth_dir(j).name;
        sub_num = str2double(depth_name(3:4));
        %constant cross valiation
       
            
        count=count+1;     
        ind(j) = sub_num;
        load(strcat(action_dir,depth_name));
        Rimg = value(:,:,1:end);
       
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
         energys = ahdepthProject(Rimg);
        [side] = ahdepthProject3(Rimg,energys);
         x2=double(side);
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          x=imresize(x2,[228 228]);
% % %            n3name=action;
% % %        
% % %              if (exist (n3name,'dir'))
% % %           
% % %              else
% % %                 direction3= n3name;
% % %                 mkdir(direction3);
% % %              end
% % %               m3name=strcat(n3name,'\',depth_name(1:end-4));
% % %              %ddd3=strcat(n3name,depth_name(5:end-4));
% % %              %dd=strcat(ddd,'d-45');
% % %              d3=strcat(m3name,'.','jpg');
% % %              imwrite(x2,d3);
% % %         % featureVectorfront=normalize(side);
% % %         x=imresize(x2,[228 228]);
% % %          [af, sf] = farras;
% % %         w = dwt2D(x,1,af);
% % %         v=w{1,2};
% % %         %figure, imshow(v)
% % %         b=w{1,1};
% % %         b1=b{1,1};
% % %         b2=b{1,2};
% % %         b3=b{1,3};
% % %         v1= cat (3,v,v,v);
% % %        % b = cat(3, b, b, b);
% % %         b1= cat(3, b1, b1, b1);
% % %         b2= cat(3, b2, b2, b2);
% % %         b3= cat(3, b3, b3, b3);
% % %         a= action ;
% % %         a1=a;
% % %         a2=a;
% % %         a3=a;
% % %         
% % %   
% % %         % spmd
% % %              %channel 1 
% % %          mname=strcat('LowLow','\',a);
% % %    
% % %          direction= mname;
% % %          if (exist (mname,'dir'))
% % %          else
% % %          % direction= mname;
% % %           mkdir(direction);
% % %          end
% % %        
% % %           ddd=strcat(mname,'\',depth_name(1:end-4));
% % %           d=strcat(ddd,'.','jpg');
% % %           imwrite( v1,d);
% % %          %channel2
% % %          m1name=strcat('HighLow','\',a1);
% % %          direction1= m1name;
% % %          if (exist (m1name,'dir'))
% % %           
% % %          else
% % %             mkdir(direction1);
% % %          end
% % %          
% % %          ddd1=strcat(m1name,'\',depth_name);
% % %          
% % %          d1=strcat(ddd1,'.','jpg');
% % %          imwrite( b1,d1);
% % %          %channel 3
% % %          m2name=strcat('LowHigh','\',a2);
% % %          direction2= m2name;
% % %          if (exist (m2name,'dir'))
% % %           
% % %          else
% % %           
% % %           mkdir(direction2);
% % %          end
% % %         
% % %          ddd2=strcat(m2name,'\',depth_name);
% % %         
% % %          d2=strcat(ddd2,'.','jpg');
% % %          imwrite( b2,d2);
% % %          %channel 4
% % %          m3name=strcat('HighHigh','\',a3);
% % %          direction3= m3name;
% % %          if (exist (m3name,'dir'))
% % %           
% % %          else
% % %           direction3= m3name;
% % %           mkdir(direction3);
% % %          end
% % %         
% % %         ddd3=strcat(m3name,'\',depth_name);
% % %         % dd=strcat(ddd,'d-45');
% % %         d3=strcat(ddd3,'.','jpg');
% % %         imwrite(b3,d3);
        % end
         
         [af, sf] = farras;
        w = dwt2D(x,1,af);
        v1=w{1,2};
        jp=find(v1<=0);
        v1(jp)=0;
        nn=max(v1);
      n=max(nn);
      v1=(v1)/n;
        %figure, imshow(v)
        b=w{1,1};
        b1=b{1,1};
          jp1=find(b1<=0);
        b1(jp1)=0;
        nn1=max(b1);
      n1=max(nn1);
      b1=(b1)/n1;
        b2=b{1,2};
          jp2=find(b2<=0);
        b2(jp2)=0;
          nn2=max(b2);
      n2=max(nn2);
      b2=(b2)/n2;
        b3=b{1,3};
        jp3=find(b3<=0);
        b3(jp3)=0;
          nn3=max(b3);
      n3=max(nn3);
      b3=(b3)/n3;
        v=psoudo(v1);
        b1=psoudo(b1);
        b2=psoudo(b2);
        b3=psoudo(b3);
         
        a=action;
        a1=a;
        a2=a;
        a3=a;
        
        s=depth_name(3:4);
        s1=depth_name(3:4);
        s2=depth_name(3:4);
        s3=depth_name(3:4);

        %% spmd
         mname=strcat('LowLowfront','\',a);
   
         direction= mname;
         if (exist (mname,'dir'))
         else
         % direction= mname;
          mkdir(direction);
         end
          ddd=strcat(mname,'\',depth_name(1:end-4));
        % ddd=strcat(nnname,);
         % dd=strcat(ddd,'d-45');
         d=strcat(ddd,'.','jpg');
         imwrite( v,d);
         %end
         %spmd
         m1name=strcat('HighLowfront','\',a1);
        direction1= m1name;
         if (exist (m1name,'dir'))
          
         else
          direction1= m1name;
          mkdir(direction1);
         end
         ddd1=strcat(m1name,'\',depth_name(1:end-4));
         %ddd1=strcat(n1name,depth_name(1:end-4));
         % dd=strcat(ddd,'d-45');
         d1=strcat(ddd1,'.','jpg');
         imwrite( b1,d1);
         %end
         %spmd
    
         m2name=strcat('LowHighfront','\',a2);
         direction2= m2name;
         if (exist (m2name,'dir'))
          
         else
          direction2= m2name;
          mkdir(direction2);
         end
         ddd2=strcat(m2name,'\',depth_name(1:end-4));
       %  ddd2=strcat(n2name,depth_name(1:end-4));
         % dd=strcat(ddd,'d-45');
         d2=strcat(ddd2,'.','jpg');
         imwrite( b2,d2);
        % end
        % spmd
        m3name=strcat('HighHighfront','\',a3);
        direction3= m3name;
         if (exist (m3name,'dir'))
          
         else
          direction3= m3name;
          mkdir(direction3);
         end
        ddd3=strcat(m3name,'\',depth_name(1:end-4));
       
        % dd=strcat(ddd,'d-45');
        d3=strcat(ddd3,'.','jpg');
        imwrite(b3,d3);
         end
   
           
        end
         



         
       %end

%delete(gcp('nocreate'));




