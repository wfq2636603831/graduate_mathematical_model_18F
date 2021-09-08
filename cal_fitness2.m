%obj(:,1)Ŀ��1  obj(:,2)Ŀ��2  obj(:,3)fitness
%bestchrom ���Ÿ��壬  bestfitness���Ÿ����Ӧ��fitness
function [obj,bestchrom,bestfitness]=cal_fitness2(Chromsome,Pucks,Tickets,n_pucks,n_gates,n_tickets)
[chromnum,~]=size(Chromsome);
obj=zeros(chromnum,4);  %1Ŀ�꺯��1  2Ŀ�꺯��2  3Ŀ��3  4��Ӧ�Ⱥ���
for i=1:1:chromnum
    chrom=Chromsome(i,:);
    park_out=sum(chrom==70);  %  minͣ������ʱ��ĺ�����  max(303-park_out)
    init=ones(n_gates,1);    %û���õĵǻ���
    for m=1:1:n_gates
        for j=1:1:n_pucks
            if(chrom(j)==m)
                init(m)=0;  %����
            end
        end
    end
    freegates=sum(init);     % maxû���õ�ͣ������
    obj(i,1)=303-park_out;      % max���ŵ�����ͣ���ڵĺ�����  max(303-park_out)
    obj(i,2)=freegates;         % maxû���õ�ͣ������
    minprocesstime=0;
    time=0;
    for ii=1:1:n_tickets
        indcome=Tickets{ii,7};
        indgo=Tickets{ii,8};
        people=Tickets{ii,2};
        park1=chrom(indcome);
        park2=chrom(indgo);
        if(park1<=28)
            place1=0;
        else
            place1=1;
        end
        if(park2<=28)
            place2=0;
        else
            place2=1;
        end
        type1=Pucks{indcome,5};
        type2=Pucks{indgo,10};
        if(type1==-1&&type2==-1)
            if(place1+place2~=1)
                time=15;
            else
                time=20;
            end
        end
        if(type1==-1&&type2==1)
            if(place1+place2~=1)
                time=35;
            else
                time=40;
            end
        end
        if(type1==1&&type2==-1)
            if(place1+place2==1)
                time=40;
            elseif(place1+place2==0)
                time=35;
            else
                time=45;
            end
        end
        if(type1==1&&type2==1)
            if(place1+place2~=1)
                time=20;
            else
                time=30;
            end
        end
        time=time*people;
        minprocesstime=minprocesstime+time;  %�������ʱ��
    end
    obj(i,3)=minprocesstime;     %�������ʱ�� ԽСԽ��
end
obj(:,4)=obj(:,1)+obj(:,2)-obj(i,3)/1000;
[~,ind]=max(obj(:,4));  %~������Ӧ��ֵ��ind��������
bestfitness=obj(ind,:);  %ÿһ��
bestchrom=Chromsome(ind,:);    %ÿһ��
end