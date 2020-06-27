clear all
clc

g1=[ 1 1 1 1 ]; %접속 벡터 g1
g2=[ 1 1 0 1 ]; %접속 벡터 g2

SR1=0; SR2=0; SR3=0; % 메모리 초기화 
MESSAGE=[1 1 0 0 1 0 0 1 0 1 0 0]; % 입력 sequnce

%  부호어 U1,U2 발생 과정
for l=1:length(MESSAGE) %메시지 길이 만큼 for문을 돌림 
    U1=mod(MESSAGE(l)*g1(1) + SR1*g1(2) + SR2*g1(3) + SR3*g1(4), 2);
    % M(i)을 발생기 행렬 g1과 곱해서 U1을 구함  
    
    U2=mod(MESSAGE(l)*g2(1) + SR1*g2(2) + SR3*g2(4), 2);
    % M(i)을 발생기 행렬 g2과 곱해서 U2을 구함 
    
    U(2*l-1)=U1;
    U(2*l)=U2; 
    
    SR3=SR2; SR1=MESSAGE(l); SR2=SR1; % shift 과정
end

MESSAGE
U

