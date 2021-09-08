%obj(:,1)Ŀ��1  obj(:,2)Ŀ��2  obj(:,3)fitness
%bestchrom ���Ÿ��壬  bestfitness���Ÿ����Ӧ��fitness
function [obj,bestchrom,bestfitness]=cal_fitness(Chromsome,n_pucks,n_gates)
[chromnum,~]=size(Chromsome);
obj=zeros(chromnum,3);  %1Ŀ�꺯��1  2Ŀ�꺯��2  3��Ӧ�Ⱥ���
for i=1:1:chromnum
    chrom=Chromsome(i,:);
    park_out=sum(chrom==70);  %  minͣ������ʱ��ĺ�����  max(303-park_out)
    init=ones(n_gates,1);
    for m=1:1:n_gates
        for j=1:1:n_pucks
            if(chrom(j)==m)
                init(m)=0;  %����
            end
        end
    end
    freegates=sum(init);   % maxû���õ�ͣ������
    obj(i,1)=303-park_out;      % max���ŵ�����ͣ���ڵĺ�����  max(303-park_out)
    obj(i,2)=freegates;         % maxû���õ�ͣ������
end
%obj(:,3)=10*exp((obj(:,1)-min(obj(:,1)))/10+(obj(:,2)-min(obj(:,2)))/2);  %fitness,Խ��Խ��
%obj(:,3)=(obj(:,1)-200)+obj(:,2)*5;
obj(:,3)=obj(:,1)+obj(:,2);
[~,ind]=max(obj(:,3));  %~������Ӧ��ֵ��ind��������
bestfitness=obj(ind,:);  %ÿһ��
bestchrom=Chromsome(ind,:);    %ÿһ��
end