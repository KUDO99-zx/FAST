function [ output ] = nConti( A,n )
%NCONTI �˴���ʾ�йش˺�����ժҪ
% �ж�A���Ƿ�������n��ѭ��������1,A�ǳ���Ϊ16��������
m = find(A==0);
if length(m)==0
    output = true;
else
    if m(1) > n
        output = true;
    else
        A = [0,A(m(1)+1:end),A(1:m(1))];
        output = max(diff(find(~A)))-1>=n;
        % output = max(diff(find(~A)))-1;
    end
end
end

