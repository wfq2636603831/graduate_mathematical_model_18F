%%  �ǻ�������Gates
% title=      1�ǻ��ڣ�    2�ն�����T\S)��     3����          4�������ͣ�D=-1���ڣ�I=1���ʣ�DI=0)
%     5�������ͣ�D=-1���ڣ�I=1���ʣ�DI=0)��    6�������W=1��N=0խ��  7�ǻ�������
clc;clear;
[~,~,raw_gates]=xlsread('./InputData.xlsx',3);
% title=raw_gates(1,:);
title={'1�ǻ���','2�ն�����T\S)','3����','4�������ͣ�D=-1���ڣ�I=1���ʣ�DI=0)','5�������ͣ�D=-1���ڣ�I=1���ʣ�DI=0)',...
 '6�������W=1��N=0խ��','7�ǻ�������'};
used_gates=raw_gates(2:end,:);
clear raw_gates;
Rgates=used_gates(:,4);  %��������
Lgates=used_gates(:,5);  %��������
Typegates=used_gates(:,6);  %��������
n_gates=length(used_gates);
for i=1:1:n_gates
    %���D=-1; I=1; D,I=0
    if(length(Rgates{i})==1)
        if(Rgates{i}=='D')
            Rgates{i}=-1;
            used_gates{i,4}=-1;
        end
        if(Rgates{i}=='I')
            Rgates{i}=1;
            used_gates{i,4}=1;
        end
    elseif(length(Rgates{i})==4)
        Rgates{i}=0;
        used_gates{i,4}=0;
    end
    %������D=-1; I=1; D,I=0
    if(length(Lgates{i})==1)
        if(Lgates{i}=='D')
            Lgates{i}=-1;
            used_gates{i,5}=-1;
        end
        if(Lgates{i}=='I')
            Lgates{i}=1;
            used_gates{i,5}=1;
        end
    elseif(length(Lgates{i})==4)
        Lgates{i}=0;
        used_gates{i,5}=0;
    end
end
 for i=1:1:n_gates  %6�����խ���
    %������𣬿�W=1,խN=0
    if(Typegates{i}=='W')
        Typegates{i}=1;
        used_gates{i,6}=1;
    end
    if(Typegates{i}=='N')
        Typegates{i}=0;
        used_gates{i,6}=0;
    end
 end
 location=cell(n_gates,1);
 for i=1:1:n_gates
     if(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='N')
         location{i}=1;
     elseif(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='C')
         location{i}=2;
     elseif(used_gates{i,2}=='T'&&used_gates{i,3}(1)=='S')
         location{i}=3;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='N')
         location{i}=4;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='C')
         location{i}=5;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='S')
         location{i}=6;
     elseif(used_gates{i,2}=='S'&&used_gates{i,3}(1)=='E')
         location{i}=7;
     end
 end
 Gates=[used_gates,location];
 xlswrite('./data.xlsx',title,3,'A1');
 xlswrite('./data.xlsx',Gates,3,'A2');