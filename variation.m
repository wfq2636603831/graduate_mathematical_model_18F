function [newchrom]=variation(chrom,n_gates,pp,Pucks,Gates,n)
dtime=cell(n_gates,1);  %��¼ÿ���ǻ��ڷɻ��뿪��ʱ��
for q=1:1:n_gates
    dtime{q}=[];   %��i��ͣ���ڷɻ��뿪ʱ��
    dtime{q}(1,1)=-45;
end
if(pp>1)
    for i=1:1:pp-1
         %dtime{chrom(i)}(end+1)=Pucks{i,14};
         if(chrom(i)<=n_gates)
             dtime{chrom(i)}=[dtime{chrom(i)};Pucks{i,14}];
         end
    end
    for i=0:1:n-pp
        j=chrom(pp+i);
        if(j<=n_gates)
            if(Pucks{pp+i,5}*Gates{j,4}>=0&&Pucks{pp+i,10}*Gates{j,5}>=0&&...
                    Pucks{pp+i,6}==Gates{j,6}&&Pucks{pp+i,13}-dtime{j}(end)>=45)
                dtime{j}(end+1)=Pucks{pp+i,14};
            else
                
                break;
            end
        end
    end
    ppp=pp+i;
    for i=ppp:1:n
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
end
newchrom=chrom;
end