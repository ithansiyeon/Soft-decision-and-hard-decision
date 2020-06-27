clear all
clc
n=2; k=1; K=4; 
g1=[1 1 1 1]; % 접속벡터1
g2=[1 1 0 1]; % 접속벡터2
dB=0:7; Eb=sqrt(k/n); V=1./(2*10.^(dB/10)); data=1000; 
%0~7dB씩 for문을 돌리면서 부호어 U1,U2와 메모리 상태를 구함 
for i=1:length(dB)
    error=0; 
    MESSAGE=round(rand(data,1000)); % 메세지 0 or 1 생성 
    for j=1:data
        SR1=0;SR2=0;SR3=0; %메모리 상태 초기화 
        for l=1:1000 
            U1=mod(MESSAGE(j,l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
            % U1을 발생기 벡터와 메시지를 이용하여 만듬
            U2=mod(MESSAGE(j,l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
            % U2를 발생기 벡터와 메시지를 이용하여 만듬
            U(j,2*l-1)=U1;
            % U1을 U의 홀수번째에 넣음
            
            U(j,2*l)=U2; 
            % U2를 U의 짝수번째에 넣음 
            %한칸씩 shift시키는 과정
            
            SR3=SR2; 
            SR2=SR1; 
            SR1=MESSAGE(j,l); 
        end
    end 

    Antipidal=sign((U)-0.5)*sqrt(k/n);   % 2진 반극 데이터  
    AWGN= sqrt(V(i)) * randn(data,2000) ; % Gaussian 채널
    Rec_A=AWGN+Antipidal; % 2진 반극 데이터에 가우시안 잡음을 더함             
  
    % A(i,j)를 과제에 주어진 표대로 State를 정의함 
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
                State(j,l)=7;   %0~7 즉, 8가지의 상태를 구분한다.
            end
        end
    end   
Mh=Softdecision(State,data); 
 

for j=1:data
     for l=1:1000
        if MESSAGE(j,l)~=Mh(j,l),  error=error+1; % 복호화된 temp와 메세지신호 M과 비교하여 다르면 error를 증가시켜 error수 측정
            end
        end
end
 
    ber(i)= error/(length(MESSAGE)*1000); 
    % ber을 error를 count한 개수 합에 전체 메시지 개수를 나눠서 구함 
    P=qfunc(sqrt(2*10.^(dB/10)));   
    % qfunc 이론적인 BER를 구함 
end

semilogy(dB,ber,'b*-',dB, P,'red'); xlabel('dB (Eb/N0)'), ylabel('BER');
grid on
legend('coded BPSK BER결과값 (연판정)', '비부호화 BER 이론값 ');