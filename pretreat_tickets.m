%%  �ÿ�����Tickets��ȡ
clc;clear;
[~,~,raw_tickets]=xlsread('./InputData.xlsx',2);
title=raw_tickets(1,:);
date11=raw_tickets(2:end,4);
date22=raw_tickets(2:end,6);
ntickets=length(date11);
select=zeros(ntickets,1);
for i=1:1:ntickets
    num1=str2double(date11{i}(end-1:end));
    num2=str2double(date22{i}(end-1:end));
    raw_tickets{i+1,4}=num1;
    raw_tickets{i+1,6}=num2;
    if(num1==20||num2==20)
        select(i)=1;
    end
end
used_tickets=raw_tickets(2:end,:);
for i=0:1:ntickets-1
    if(select(ntickets-i)==0)
        used_tickets(ntickets-i,:)=[];
    end
end
Tickets=used_tickets;
%��ã����õ���20�ŵ�����
used_tickets=[title;used_tickets];   %���������tickets���ݣ���1733��
xlswrite('./data.xlsx',used_tickets,2,'A1');