%% ������ʼ��Ⱥ
function [Chromsome]=initpop(Pucks,Gates,chromnum)
n_pucks=length(Pucks);
n_gates=length(Gates);
Chromsome=zeros(chromnum,n_pucks); 
for m=1:1:chromnum
% ����һ��Ⱦɫ��
    chrom=zeros(1,n_pucks);
    dtime=cell(n_gates,1);  %��¼ÿ���ǻ��ڷɻ��뿪��ʱ��
    for i=1:1:n_gates
        dtime{i}=[];   %��i��ͣ���ڷɻ��뿪ʱ��
        dtime{i}(1,1)=-45;
    end
    for i=1:1:n_pucks
        ind=randperm(n_gates);
        for j=1:1:n_gates+1
            if(j<=n_gates)
                if(Pucks{i,5}*Gates{ind(j),4}>=0&&Pucks{i,10}*Gates{ind(j),5}>=0&&...
                        Pucks{i,6}==Gates{ind(j),6}&&Pucks{i,13}-dtime{ind(j)}(end)>=45)
                    dtime{ind(j)}(end+1)=Pucks{i,14};
                    chrom(i)=ind(j);
                    break;
                end
            else
                chrom(i)=70;  %��ʱͣ��λ
            end
        end
    end
    Chromsome(m,:)=chrom;
end
end