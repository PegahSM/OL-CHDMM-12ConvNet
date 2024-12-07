% Human action recognition
%my first try with h1 subband level 2 and svm 
% Test dataset : MSR Action3D
% Cross Subject Test
% by Chen Chen, The University of0 Texas at Dallas
% chenchen870713@gmail.com

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Subjects for training and testing are FIXED.
%%%%%%% Subject 1 3 5 7 9 as training subjects, the rest as testing subjects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



file_dir = 'MSR-Action3D\';
ActionNum = ['a02', 'a03', 'a05', 'a06', 'a10', 'a13', 'a18', 'a20'; % first row corresponds to action subset 'AS1'
             'a01', 'a04', 'a07', 'a08', 'a09', 'a11', 'a14', 'a12'; % second row corresponds to action subset 'AS2'
             'a06', 'a14', 'a15', 'a16', 'a17', 'a18', 'a19', 'a20']; % third row corresponds to action subset 'AS3'1','a12','a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a19', 'a20']; % third row corresponds to action subset 'AS3'
            
NumAct = 8;          % number of actions in each subset

max_subject = 10;    % maximum number of subjects for one action
max_experiment = 3;  % maximum number of experiments performed by one subject
lambda = 0.001;
%frame_remove = 5;    % remove the first and last five frames (mostly the subject is in stand-still position in these frames)



fix_size_front = [104;52]; fix_size_side = [104;84]; fix_size_top = [84;52];

%%
%subset = 1;
%subset = 2;
subset = 1;
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
    action = TargetSet((i-1)*3+1:i*3);
    action_dir = strcat(file_dir,action,'\');
    fpath = fullfile(action_dir, '*.mat');
    depth_dir = dir(fpath);
    ind = zeros(1,length(depth_dir));
    
    
    
   
      for j = 1:length(depth_dir)
       
        depth_name = depth_dir(j).name;
        sub_num = str2double(depth_name(6:7));
       
        m=rem(sub_num,2);
        if m==0
                
        count=count+1;     
        ind(j) = sub_num;
        load(strcat(action_dir,depth_name));
        Rimg = depth(:,:,1:end);
      
% %         mx1=255;
% %         mn1=0;
              
        energy = ahdepthProject(Rimg);
        [front] = ahdepthProject3(Rimg,energy);
        x2=front;%front is double
% %         n3name=depth_name(2:3);
% %        
% %              if (exist (n3name,'dir'))
% %           
% %              else
% %                 direction3= n3name;
% %                 mkdir(direction3);
% %              end
% %               m3name=strcat(n3name,'\',depth_name(5:end-4));
% %                  d3=strcat(m3name,'.','jpg');
% %              imwrite(x2,d3);
   %    imshow(x2)
       x=imresize(x2,[228 228]);
        %figure,imshow(x)
% %               blue=x{:,:,1};
% %               green=x{:,:,2};
% %               red=x{:,:,3};
% %                [af, sf] = farras;
% %                 wb = dwt2D(blue,1,af);
% %                 wg = dwt2D(green,1,af);
% %                 wr = dwt2D(red,1,af);
% % 
% %               bb=wb{1,1};
% %               b1=bb{1,1};
% %               b2=bb{1,2};
% %               b3=bb{1,3};
% %         
% %         gg=wg{1,1};
% %         g1=gg{1,1};
% %         g2=gg{1,2};
% %         g3=gg{1,3};
% %         
% %         rr=wr{1,1};
% %         r1=rr{1,1};
% %         r2=rr{1,2};
% %         r3=rr{1,3};
% %         
% %         vb=wb{1,2};
% %         vg=wg{1,2};
% %         vr=wr{1,2};
% %         
% %         v{:,:,1}=vb;
% %         v{:,:,2}=vg;
% %         v{:,:,3}=vr;
% %         
% %         z{:,:,1}=b1;
% %         z{:,:,2}=g1;
% %         z{:,:,3}=r1;
% %         
% %         y{:,:,1}=b2;
% %         y{:,:,2}=g2;
% %         y{:,:,3}=r2;
% %         
% %         u{:,:,1}=b3;
% %         u{:,:,2}=g3;
% %         u{:,:,3}=r3;
% % 
% % 
% % % % % % % % % % % % % % % % % % % % % % wavelet

        [af, sf] = farras;
        w = dwt2D(x,1,af);
        v1=w{1,2};
        jp=find(v1<=0);
        v1(jp)=0;
        nn=max(v1);
       n=max(nn);
      v1=(v1)/n;
       % figure, imshow(v)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         
% wavelet
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
% % %         v= cat (3,v,v,v);
% % %         b = cat(3, b, b, b);
% % %         b1= cat(3, b1, b1, b1);
% % %         b2= cat(3, b2, b2, b2);
% % %         b3= cat(3, b3, b3, b3);
% % %        
% %    
        a=depth_name(2:3);
        a1=a;
        a2=a;
        a3=a;
        
        s=depth_name(6:7);
        s1=depth_name(6:7);
        s2=depth_name(6:7);
        s3=depth_name(6:7);

        %% spmd
         mname=strcat('LowLowside','\',a);
   
         direction= mname;
         if (exist (mname,'dir'))
         else
         % direction= mname;
          mkdir(direction);
         end
         nnname=strcat(mname,'\',s);
         ddd=strcat(nnname,depth_name(10:11));
         % dd=strcat(ddd,'d-45');
         d=strcat(ddd,'.','jpg');
         imwrite( v,d);
         %end
         %spmd
         m1name=strcat('HighLowside','\',a1);
        direction1= m1name;
         if (exist (m1name,'dir'))
          
         else
          direction1= m1name;
          mkdir(direction1);
         end
         n1name=strcat(m1name,'\',s1);
         ddd1=strcat(n1name,depth_name(10:11));
         % dd=strcat(ddd,'d-45');
         d1=strcat(ddd1,'.','jpg');
         imwrite( b1,d1);
         %end
         %spmd
    
         m2name=strcat('LowHighside','\',a2);
         direction2= m2name;
         if (exist (m2name,'dir'))
          
         else
          direction2= m2name;
          mkdir(direction2);
         end
         n2name=strcat(m2name,'\',s2);
         ddd2=strcat(n2name,depth_name(10:11));
         % dd=strcat(ddd,'d-45');
         d2=strcat(ddd2,'.','jpg');
         imwrite( b2,d2);
        % end
        % spmd
        m3name=strcat('HighHighside','\',a3);
        direction3= m3name;
         if (exist (m3name,'dir'))
          
         else
          direction3= m3name;
          mkdir(direction3);
         end
        n3name=strcat(m3name,'\',s3);
        ddd3=strcat(n3name,depth_name(10:11));
        % dd=strcat(ddd,'d-45');
        d3=strcat(ddd3,'.','jpg');
        imwrite(b3,d3);
         end
   
           
        end
         
      end 
    
 



