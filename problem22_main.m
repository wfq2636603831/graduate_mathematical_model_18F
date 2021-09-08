% ���ɻ�����˳�����ΰ�����ͣ��λ
clc;clear
[~,~,Pucks]=xlsread('./data.xlsx',1);
Pucks(1,:)=[];
[~,~,Gates]=xlsread('./data.xlsx',3);
Gates(1,:)=[];
[~,~,Tickets]=xlsread('./data.xlsx',4);
Tickets(1,:)=[];
n_tickets=length(Tickets);
n_pucks=length(Pucks);
n_gates=length(Gates);
chromnum=50;   %��ȺȾɫ������
N=100;      %��������
Nbestfitness=zeros(N,4);       %��¼ÿһ�������Ӧ��  1Ŀ��1  2Ŀ��2  3Ŀ��3   4fitness
Nbestchrom=zeros(N,n_pucks);   %��¼ûһ�����Ÿ���
%% ������ʼ��Ⱥ
[Chromsome]=initpop(Pucks,Gates,chromnum);
for gen=1:1:N
    %% ������Ӧ�ȣ���¼���Ÿ���
    [obj,bestchrom,bestfitness]=cal_fitness2(Chromsome,Pucks,Tickets,n_pucks,n_gates,n_tickets);
    Nbestfitness(gen,:)=bestfitness;
    Nbestchrom(gen,:)=bestchrom;
    %% ѡ������
    [Chromsome]=selection2(Chromsome,obj,chromnum,n_pucks);
    %% �����������
    [Chromsome]=crossover(Chromsome,Pucks,Gates,n_gates);
end
mostbest=zeros(N,1);
mostbest(1)=Nbestfitness(1,4);
IND=1;
for i=2:1:N
    if(Nbestfitness(i,4)<mostbest(i-1))
        mostbest(i)=mostbest(i-1);
    else
        mostbest(i)=Nbestfitness(i,4);
        IND=i;
    end
end
X=randperm(N);
X=sort(X);
for i=1:1:4
    figure(i);
    plot(X,Nbestfitness(:,i));
end
figure(5);
plot(X,mostbest);
disp(Nbestfitness(IND,:));
disp(Nbestchrom(IND,:));
result=Nbestchrom(IND,:);
cishu=zeros(n_gates,1);  %ÿ���ǻ����õĴ���
for i=1:1:n_gates
    for j=1:1:n_pucks
        if(result(j)==i)
            cishu(i)=cishu(i)+1;
        end
    end
end