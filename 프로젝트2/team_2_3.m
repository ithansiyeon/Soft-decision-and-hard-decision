clear all
clc

n=2; k=1;  K=4; 
g1=[1 1 1 1]; % ���Ӻ���1
g2=[1 1 0 1]; % ���Ӻ���2
dB=0:1:7;           % dB��
Eb=sqrt(k/n);          % ������ũ��
V=1./(2*10.^(dB/10));    %�л갪
data=1000;      %�������� ����


for i=1:length(dB)  
    error=0; % dB���� error����
    M=round(rand(data,1000));
    
    for j=1:data  
        SR1=0;  SR2=0; SR3=0;
        
        for l=1:1000 %���̰� 1000�� �޼�����ȣ�� ����ϴ� ����
            U1=mod(M(j,l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
            U2=mod(M(j,l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
            U(j,2*l)=U1;
            U(j,2*l-1)=U2; % �޼�����ȣ�� ���� U1,U2�� ��� �� �����ϴ� ���� 
            
            SR3=SR2; 
            SR2=SR1; 
            SR1=M(j,l); % ��ĭ�� shift��Ű�� ����
        end
    end 
    
    % ��ȣ ����
       Antipodal=sign((U)-0.5)*Eb;            % 2�� �ݱ� ������ = binary antipodal
    AWGN= sqrt(V(i)) * randn(data,2000) ;  % ����þ�ä�α���
    R=sign(AWGN+Antipodal);                % BPSK ������ �����Ͱ� ä���� ����� ���� 
    Uh=(R+1)./2;                           % ������ R�� binary�� 0 1 �� ����
    Mh=Harddecision(Uh,data);            % harddecision (������ �Լ�)
                                         
    for j=1:data
        for l=1:1000
            if M(j,l)~=Mh(j,l),  error=error+1;    % ��ȣȭ�� temp�� �޼�����ȣ M�� ���Ͽ� �ٸ��� error�� �������� error�� ����
            end
        end
    end
    
    ber(i) = error/(length(M)*1000); % dB�� ���� ������ ��� �� ����
    P=qfunc(sqrt(2*10.^(dB/10)));    %���ȣȭ �̷�ġ BER
end

semilogy(dB,ber,'b*-',dB, P,'red'); xlabel('dB (Eb/N0)'), ylabel('BER');
grid on
legend('coded BPSK BER����� (������)', 'uncoded BPSK BER �̷а� ');
