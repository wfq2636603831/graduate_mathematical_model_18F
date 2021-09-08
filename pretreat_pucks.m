clc;clear;close all
%% �ɻ�ת���ƻ�Pucks��������
[~,~,raw_pucks]=xlsread('./InputData.xlsx',1);
title=raw_pucks(1,:);
title=[title,'����ʱ��','����ʱ��','ͣ��ʱ��'];
date1=raw_pucks(2:end,2);
date2=raw_pucks(2:end,7);
n_puck=length(date1);
select=zeros(n_puck,1);
for i=1:1:n_puck   %ȡ����Ϊ20�ŵ�����
    num1=str2double(date1{i}(end-1:end));
    num2=str2double(date2{i}(end-1:end));
    if(num1==20||num2==20)
        select(i)=1;
    end
end
used_pucks=raw_pucks(2:end,:);
clear num1 num2 %raw_pucks;
for i=0:1:n_puck-1   %ɾ������20�ŵ�����
    if(select(n_puck-i)==0)
        used_pucks(n_puck-i,:)=[];
    end
end
clear n_puck;
n_pucks=length(used_pucks);
for i=1:1:n_pucks  %ֻҪ���ڵĺ���λ������Ҫ�ֻ꣬Ҫ�գ���ת���ɸ�����
    used_pucks{i,2}=used_pucks{i,2}(end-1:end);
    used_pucks{i,7}=used_pucks{i,7}(end-1:end);
    used_pucks{i,2}=str2double(used_pucks{i,2});
    used_pucks{i,7}=str2double(used_pucks{i,7});
end
for i=1:1:n_pucks   %����ͳ����ĺ��࣬���ں����Ϊ-1�����ʺ����Ϊ1
    if(used_pucks{i,5}=='D')
        used_pucks{i,5}=-1;
    elseif(used_pucks{i,5}=='I')
        used_pucks{i,5}=1;
    end
    if(used_pucks{i,10}=='D')
        used_pucks{i,10}=-1;
    elseif(used_pucks{i,10}=='I')
        used_pucks{i,10}=1;
    end
end
for i=1:1:n_pucks   %���Ϳ��Ϊ1������խ��Ϊ0
    if(isnumeric(used_pucks{i,6}))
        if((used_pucks{i,6}==332)||used_pucks{i,6}==333||used_pucks{i,6}==773)  %�����
            used_pucks{i,6}=1;
        elseif(used_pucks{i,6}==319||used_pucks{i,6}==320||used_pucks{i,6}==321||used_pucks{i,6}==323||...
                used_pucks{i,6}==325||used_pucks{i,6}==738)  %խ����
            used_pucks{i,6}=0;
        end
    else
        if(strcmp(used_pucks{i,6},'33E')||strcmp(used_pucks{i,6},'33H')||strcmp(used_pucks{i,6},'33L'))  %�����
            used_pucks{i,6}=1;
        elseif(strcmp(used_pucks{i,6},'73A')||strcmp(used_pucks{i,6},'73E')||strcmp(used_pucks{i,6},'73H')||strcmp(used_pucks{i,6},'73L'))  %խ����
            used_pucks{i,6}=0;
        end
    end
end
for i=1:1:n_pucks   %ʱ��ת����ÿ��ĵڶ��ٷ���
    if(isnumeric(used_pucks{i,3}))
        used_pucks{i,3}=used_pucks{i,3}*24*60;
    else
        used_pucks{i,3}=str2double(used_pucks{i,3}(1:2))*60+str2double(used_pucks{i,3}(4:end));
    end
    if(isnumeric(used_pucks{i,8}))
        used_pucks{i,8}=used_pucks{i,8}*24*60;
    else
        used_pucks{i,8}=str2double(used_pucks{i,8}(1:2))*60+str2double(used_pucks{i,8}(4:end));
    end
end
%used_pucks=[title;used_pucks];  %���������pucks���ݣ���303��
 %% ��ÿ������puck��ͣ��ʱ��ͼ
 time=cell(n_pucks,3);
 for i=1:1:n_pucks
     time{i,1}=(used_pucks{i,2}-19)*24*60+used_pucks{i,3}-300;  %5:00
     time{i,2}=(used_pucks{i,7}-19)*24*60+used_pucks{i,8}-300;
     time{i,3}=time{i,2}-time{i,1};
 end
 temp=[used_pucks,time];
 Pucks=cell(size(temp));
 [~,ind]=sort(cell2mat(time(:,1)));  %Pucks ������ʱ��˳�����кõ�303����Ч����
 for i=1:1:n_pucks                   %Pucks(:,13)����ʱ�䣬�����19 5:00
     Pucks(i,:)=temp(ind(i),:);      %Pucks��:,14)�뿪ʱ�䣬�����19 5:00
 end                                 %Puck(:,15)ͣ��ʱ��
 figure;   %������ͼ
 for i=1:1:n_pucks
            plot([Pucks{i,13},Pucks{i,14}],[i,i],'linewidth',1.5);
            hold on;
 end
 axis([0 (max(cell2mat(Pucks(:,14)))+1) 0 n_pucks+1]);
 xlswrite('./data.xlsx',title,1,'A1');
 xlswrite('./data.xlsx',Pucks,1,'A2');
 %%
 