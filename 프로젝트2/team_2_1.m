clear all
clc

g1=[ 1 1 1 1 ]; %���� ���� g1
g2=[ 1 1 0 1 ]; %���� ���� g2

SR1=0; SR2=0; SR3=0; % �޸� �ʱ�ȭ 
MESSAGE=[1 1 0 0 1 0 0 1 0 1 0 0]; % �Է� sequnce

%  ��ȣ�� U1,U2 �߻� ����
for l=1:length(MESSAGE) %�޽��� ���� ��ŭ for���� ���� 
    U1=mod(MESSAGE(l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
    % M(i)�� �߻��� ��� g1�� ���ؼ� U1�� ����  
    
    U2=mod(MESSAGE(l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
    % M(i)�� �߻��� ��� g2�� ���ؼ� U2�� ���� 
    
    U(2*l-1)=U1;
    U(2*l)=U2; 
    
    SR3=SR2; SR1=MESSAGE(l); SR2=SR1; % shift ����
end

MESSAGE
U

