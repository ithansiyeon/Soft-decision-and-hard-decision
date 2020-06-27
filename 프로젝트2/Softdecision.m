function y=Softdecision(r,num)
path=0; 
for j=1:num
    distance(1,1)=0;         %distance 배열의 (1,1)의 값을 0으로 초기화
    distance(2:8,1)=1000;    %distance 배열의 (2:8,1)의 값을 10000으로 설정하여 선택되지 않도록 방지함 
    
    for i=1:1000
        % a[000]->a[000]
        a_to_a1=r(j,2*i-1)-0; 
        a_to_a2=r(j,2*i)-0;
        a_to_a=(a_to_a1^2 + a_to_a2^2);
        
       % e[001]->a[000]
        e_to_a1=r(j,2*i-1)-7;  
        e_to_a2=r(j,2*i)-7;    
        e_to_a=(e_to_a1^2 + e_to_a2^2);
        
        if distance(1,i)+a_to_a<=distance(5,i)+e_to_a, distance(1,i+1)=distance(1,i)+a_to_a; path(1,i+1)=1;
        end
        if distance(5,i)+e_to_a<distance(1,i)+a_to_a, distance(1,i+1)=distance(5,i)+e_to_a;  path(1,i+1)=9;
        end
        
        % a[000]->b[100]
        a_to_b1=r(j,2*i-1)-7;       
        a_to_b2=r(j,2*i)-7;   
        a_to_b=(a_to_b1^2 + a_to_b2^2);
        
        % e[001]->b[100]
        e_to_b1=r(j,2*i-1)-0;       
        e_to_b2=r(j,2*i)-0;   
        e_to_b=(e_to_b1^2 + e_to_b2^2);
    
        if distance(1,i)+a_to_b<=distance(5,i)+e_to_b, distance(2,i+1)=distance(1,i)+a_to_b; path(2,i+1)=2;end
        if distance(5,i)+e_to_b<distance(1,i)+a_to_b,distance(2,i+1)=distance(5,i)+e_to_b; path(2,i+1)=10;end
        
        % b[100]->c[010]
        b_to_c1=r(j,2*i-1)-7;   
        b_to_c2=r(j,2*i)-7;   
        b_to_c=(b_to_c1^2 + b_to_c2^2);
        
        % f[101]->c[010]
        f_to_c1=r(j,2*i-1)-0;   
        f_to_c2=r(j,2*i)-0;   
        f_to_c=(f_to_c1^2 + f_to_c2^2);
        
        if distance(2,i)+b_to_c<=distance(6,i)+f_to_c,distance(3,i+1)=distance(2,i)+b_to_c; path(3,i+1)=3;end
        if distance(6,i)+f_to_c<distance(2,i)+b_to_c, distance(3,i+1)=distance(6,i)+f_to_c; path(3,i+1)=11; end
        
        % b[100]->d[110]
        b_to_d1=r(j,2*i-1)-0;    
        b_to_d2=r(j,2*i)-0;   
        b_to_d=(b_to_d1^2 + b_to_d2^2);
        
        % f[101]->d[110]
        f_to_d1=r(j,2*i-1)-7;      
        f_to_d2=r(j,2*i)-7;   
        f_to_d=(f_to_d1^2 + f_to_d2^2);
        
        if distance(2,i)+b_to_d<=distance(6,i)+f_to_d, distance(4,i+1)=distance(2,i)+b_to_d; path(4,i+1)=4; end
        if distance(6,i)+f_to_d<distance(2,i)+b_to_d,distance(4,i+1)=distance(6,i)+f_to_d; path(4,i+1)=12; end
        
        % c[010]->e[001]
        c_to_e1=r(j,2*i-1)-7;      
        c_to_e2=r(j,2*i)-0;   
        c_to_e=(c_to_e1^2 + c_to_e2^2);
        
        % g[011]->e[001]
        g_to_e1=r(j,2*i-1)-0;      
        g_to_e2=r(j,2*i)-7;
        g_to_e=(g_to_e1^2 + g_to_e2^2);
        
        if distance(3,i)+c_to_e<=distance(7,i)+g_to_e, distance(5,i+1)=distance(3,i)+c_to_e; path(5,i+1)=5; end
        if distance(7,i)+g_to_e<distance(3,i)+c_to_e,distance(5,i+1)=distance(7,i)+g_to_e; path(5,i+1)=13; end
        
        % c[010]->f[101]
        c_to_f1=r(j,2*i-1)-0;  
        c_to_f2=r(j,2*i)-7;
        c_to_f=(c_to_f1^2 + c_to_f2^2);
        
        % g[011]->f[101]
        g_to_f1=r(j,2*i-1)-7;  
        g_to_f2=r(j,2*i)-0;
        g_to_f=(g_to_f1^2 + g_to_f2^2);
        
        if distance(3,i)+c_to_f<=distance(7,i)+g_to_f, distance(6,i+1)=distance(3,i)+c_to_f; path(6,i+1)=6; end
        if distance(7,i)+g_to_f<distance(3,i)+c_to_f,distance(6,i+1)=distance(7,i)+g_to_f; path(6,i+1)=14; end
        
        % d[110]->g[011]
        d_to_g1=r(j,2*i-1)-0;   
        d_to_g2=r(j,2*i)-7;   
        d_to_g=(d_to_g1^2 + d_to_g2^2);
        
        % h[111]->g[011]
        h_to_g1=r(j,2*i-1)-7;   
        h_to_g2=r(j,2*i)-0;
        h_to_g=(h_to_g1^2 + h_to_g2^2);
        
        if distance(4,i)+d_to_g<=distance(8,i)+h_to_g, distance(7,i+1)=distance(4,i)+d_to_g; path(7,i+1)=7; end
        if distance(8,i)+h_to_g<distance(4,i)+d_to_g,distance(7,i+1)=distance(8,i)+h_to_g; path(7,i+1)=15; end
       
        % d[110]->h[111]
        d_to_h1=r(j,2*i-1)-7;   
        d_to_h2=r(j,2*i)-0;
        d_to_h=(d_to_h1^2 + d_to_h2^2);
        
        % h[111]->h[111]
        h_to_h1=r(j,2*i-1)-0;   
        h_to_h2=r(j,2*i)-7;
        h_to_h=(h_to_h1^2 + h_to_h2^2);
        
        if distance(4,i)+d_to_h<=distance(8,i)+h_to_h, distance(8,i+1)=distance(4,i)+d_to_h; path(8,i+1)=8; end
        if distance(8,i)+h_to_h<distance(4,i)+d_to_h,distance(8,i+1)=distance(8,i)+h_to_h; path(8,i+1)=16; end
    end
    
    Dfree=min(distance(:,1001));
    for w=1:8
        if distance(w,1001)==Dfree
            a=w;
        end
    end
     
    for i=1:1000
        if path(a,1002-i)==1,  m(j,1001-i)=0; a=1;
        elseif path(a,1002-i)==2, m(j,1001-i)=1; a=1;
        elseif path(a,1002-i)==3,m(j,1001-i)=0; a=2;
        elseif path(a,1002-i)==4, m(j,1001-i)=1; a=2;
        elseif path(a,1002-i)==5,  m(j,1001-i)=0; a=3;
        elseif path(a,1002-i)==6,  m(j,1001-i)=1; a=3;
        elseif path(a,1002-i)==7, m(j,1001-i)=0; a=4;
        elseif path(a,1002-i)==8,  m(j,1001-i)=1; a=4;
        elseif path(a,1002-i)==9, m(j,1001-i)=0; a=5;
        elseif path(a,1002-i)==10,m(j,1001-i)=1; a=5;
        elseif path(a,1002-i)==11, m(j,1001-i)=0; a=6;
        elseif path(a,1002-i)==12,  m(j,1001-i)=1; a=6;
        elseif path(a,1002-i)==13,  m(j,1001-i)=0; a=7;
        elseif path(a,1002-i)==14, m(j,1001-i)=1; a=7;
        elseif path(a,1002-i)==15,  m(j,1001-i)=0; a=8;
        elseif path(a,1002-i)==16,  m(j,1001-i)=1; a=8;
        end
    end
    y=m;
end