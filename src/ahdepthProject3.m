function  [front ] = ahdepthProject3(X,me,mx1,mn1)

[rows,cols,D] = size(X);
fix_size_front = [227;227];
rf=fix_size_front(1);
cf=fix_size_front(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=3;

q=0;
mu=zeros(227,227);
mu1=zeros(227,227);
%for l=1:a
    w=(0.5)^(a-1);
    step=0.5*w;
    z=0;
    X2D = reshape(X, rows*cols,D);
    max_depth = round(max(X2D(:)));
   
    while (z*step+w<=1)
       
        n=z*step;
       v=z*step+w;
       j = find( min(abs(me-n ))==abs(me-n));
 
       p = find( min(abs(me-v))==abs(me-v));
       F = zeros(rows, cols);
      
       S = zeros(rows, max_depth);
       T = zeros(max_depth, cols);
       for k =j:p
           
           
           frnt = X(:,:,k);
           %figure,imshow(frnt)
           side = zeros(rows, max_depth);
           top = zeros(max_depth, cols);
           if k > 1
              F = F + abs(frnt - front_pre);
              S = S + abs(side - side_pre);
              T = T + abs(top - top_pre);
              %statre1
              % F = (1-0.495)*F + 0.495*abs(frnt - front_pre);
              %S = (1-0.495)*S +0.495*abs(side - side_pre);
              %T = (1-0.495)*T + 0.495*abs(top - top_pre);
           end
         
          for i = 1:rows
             for j = 1:cols
               if frnt(i,j) ~= 0
                  side(i,frnt(i,j)) = j;% side view projection (y-z projection)
                  top(frnt(i,j),j)  = i;
                  %figure,imshow(side)% top view projection  (x-z projection)
 
                  %figure,imshow(top)% top view projection  (x-z projection)
                end
             end
          end
           front_pre = frnt; 
           side_pre = side; 
           top_pre = top; 
  
      end
       z=z+1;
       q=q+1;
% %        fr=bounding_box(F);
% %         jpp=find(fr<=0);
% %         fr(jpp)=0;
% %         m1=abs(fr);
% %        m1=normalize(fr);
% %         nn=max(m1);
% %         n=max(nn);
% %         m1=(m1)/n;
% % %         
             tp=bounding_box(S);
             cp = find( sum(tp,1)==0);
             tp(:,cp)=[];
%              m1=tp;
             jpp=find(tp<=0);
             tp(jpp)=0;
             tp=abs(tp);
             m1=tp;
             m1=normalize(tp);
             nn=max(m1);
             n=max(nn);
             m1=(m1)/n;
      
% %         tp=bounding_box(T);
% %         cp = find( sum(tp,1)==0);
% %         tp(:,cp)=[];
% %         jpp=find(tp<=0);
% %         tp(jpp)=0;
% %         tp=abs(tp);
% %         m1=tp;
% % %        m1=normalize(tp);
% %        nn=max(m1);
% %       n=max(nn);
% %       m1=(m1)/n;
    
   %  norm_data = (m1 - min(min(m1))) / ( max(max(m1)) - min(min(m1))) ;
    %  figure,imshow(norm_data);
      
      Dif1=imresize(m1,[rf,cf]);
      mu1=(0.9)*Dif1+mu1;

    
      
    end
   
    
 
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   front=mu1;
 
     



   
       
    
     
