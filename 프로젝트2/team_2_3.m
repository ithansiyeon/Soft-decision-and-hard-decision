clear all
clc

n=2; k=1;  K=4; 
g1=[1 1 1 1]; % 접속벡터1
g2=[1 1 0 1]; % 접속벡터2
dB=0:1:7;           % dB값
Eb=sqrt(k/n);          % 에너지크기
V=1./(2*10.^(dB/10));    %분산값
data=1000;      %데이터의 갯수


for i=1:length(dB)  
    error=0; % dB마다 error저장
    M=round(rand(data,1000));
    
    for j=1:data  
        SR1=0;  SR2=0; SR3=0;
        
        for l=1:1000 %길이가 1000인 메세지신호를 계산하는 과정
            U1=mod(M(j,l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
            U2=mod(M(j,l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
            U(j,2*l)=U1;
            U(j,2*l-1)=U2; % 메세지신호에 대한 U1,U2를 계산 후 저장하는 과정 
            
            SR3=SR2; 
            SR2=SR1; 
            SR1=M(j,l); % 한칸씩 shift시키는 과정
        end
    end 
    
    % 복호 과정
       Antipodal=sign((U)-0.5)*Eb;            % 2진 반극 데이터 = binary antipodal
    AWGN= sqrt(V(i)) * randn(data,2000) ;  % 가우시안채널구현
    R=sign(AWGN+Antipodal);                % BPSK 복조기 데이터가 채널을 통과후 복조 
    Uh=(R+1)./2;                           % 복조한 R을 binary값 0 1 로 만듬
    Mh=Harddecision(Uh,data);            % harddecision (경판정 함수)
                                         
    for j=1:data
        for l=1:1000
            if M(j,l)~=Mh(j,l),  error=error+1;    % 복호화된 temp와 메세지신호 M과 비교하여 다르면 error를 증가시켜 error수 측정
            end
        end
    end
    
    ber(i) = error/(length(M)*1000); % dB에 따라 에러율 계산 및 저장
    P=qfunc(sqrt(2*10.^(dB/10)));    %비부호화 이론치 BER
end

semilogy(dB,ber,'b*-',dB, P,'red'); xlabel('dB (Eb/N0)'), ylabel('BER');
grid on
legend('coded BPSK BER결과값 (경판정)', 'uncoded BPSK BER 이론값 ');
