clear all
clc
n=2; k=1; K=4; 
g1=[1 1 1 1]; % ���Ӻ���1
g2=[1 1 0 1]; % ���Ӻ���2
dB=0:7; Eb=sqrt(k/n); V=1./(2*10.^(dB/10)); data=1000; 
%0~7dB�� for���� �����鼭 ��ȣ�� U1,U2�� �޸� ���¸� ���� 
for i=1:length(dB)
    error=0; 
    MESSAGE=round(rand(data,1000)); % �޼��� 0 or 1 ���� 
    for j=1:data
        SR1=0;SR2=0;SR3=0; %�޸� ���� �ʱ�ȭ 
        for l=1:1000 
            U1=mod(MESSAGE(j,l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
            % U1�� �߻��� ���Ϳ� �޽����� �̿��Ͽ� ����
            U2=mod(MESSAGE(j,l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
            % U2�� �߻��� ���Ϳ� �޽����� �̿��Ͽ� ����
            U(j,2*l-1)=U1;
            % U1�� U�� Ȧ����°�� ����
            
            U(j,2*l)=U2; 
            % U2�� U�� ¦����°�� ���� 
            %��ĭ�� shift��Ű�� ����
            
            SR3=SR2; 
            SR2=SR1; 
            SR1=MESSAGE(j,l); 
        end
    end 

    Antipidal=sign((U)-0.5)*sqrt(k/n);   % 2�� �ݱ� ������  
    AWGN= sqrt(V(i)) * randn(data,2000) ; % Gaussian ä��
    Rec_A=AWGN+Antipidal; % 2�� �ݱ� �����Ϳ� ����þ� ������ ����             
  
    % A(i,j)�� ������ �־��� ǥ��� State�� ������ 
    for j=1:data   
        for l=1:2000
                if Rec_A(j,l)<-0.75, 
                    State(j,l)=0;
                elseif Rec_A(j,l)>=-0.75 && Rec_A(j,l)<-0.5,
                     State(j,l)=1;
                elseif Rec_A(j,l)>=-0.5 && Rec_A(j,l)<-0.25,
                    State(j,l)=2;
                elseif Rec_A(j,l)>=-0.25 && Rec_A(j,l)<0,
                State(j,l)=3;
                elseif Rec_A(j,l)>=0 && Rec_A(j,l)<0.25,
                State(j,l)=4;
                elseif Rec_A(j,l)>=0.25 && Rec_A(j,l)<0.5,
                State(j,l)=5;
                elseif Rec_A(j,l)>=0.5 && Rec_A(j,l)<0.75,
                State(j,l)=6;
                elseif Rec_A(j,l)>=0.75,
                State(j,l)=7;   %0~7 ��, 8������ ���¸� �����Ѵ�.
            end
        end
    end   
Mh=Softdecision(State,data); 
 

for j=1:data
     for l=1:1000
        if MESSAGE(j,l)~=Mh(j,l),  error=error+1; % ��ȣȭ�� temp�� �޼�����ȣ M�� ���Ͽ� �ٸ��� error�� �������� error�� ����
            end
        end
end
 
    ber(i)= error/(length(MESSAGE)*1000); 
    % ber�� error�� count�� ���� �տ� ��ü �޽��� ������ ������ ���� 
    P=qfunc(sqrt(2*10.^(dB/10)));   
    % qfunc �̷����� BER�� ���� 
end

semilogy(dB,ber,'b*-',dB, P,'red'); xlabel('dB (Eb/N0)'), ylabel('BER');
grid on
legend('coded BPSK BER����� (������)', '���ȣȭ BER �̷а� ');