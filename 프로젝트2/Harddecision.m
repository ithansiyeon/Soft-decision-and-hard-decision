function y=Harddecision(x,num)

path=0; 

for j=1:num
                             
    distance(1,1)=0;          
    distance(2:8,1)=10000;     
    
    for i=1:1000
      
         % a[000]->a[000]
        a_to_a1=xor(x(j,2*i-1),0); 
        a_to_a2=xor(x(j,2*i),0);     
        a_to_a=a_to_a1+a_to_a2;  
        
        % e[001]->a[000]
        e_to_a1=xor(x(j,2*i-1),1);  
        e_to_a2=xor(x(j,2*i),1);   
        e_to_a=e_to_a1+e_to_a2;    
       
      
        if distance(1,i)+a_to_a<=distance(5,i)+e_to_a, distance(1,i+1)=distance(1,i)+a_to_a; path(1,i+1)=1; end
        if distance(5,i)+e_to_a<distance(1,i)+a_to_a, distance(1,i+1)=distance(5,i)+e_to_a;  path(1,i+1)=9;  end
        
    
        % a[000]->b[100]
        a_to_b1=xor(x(j,2*i-1),1); 
        a_to_b2=xor(x(j,2*i),1);
        a_to_b=a_to_b1+a_to_b2;
        
        % e[001]->b[100]
        e_to_b1=xor(x(j,2*i-1),0); 
        e_to_b2=xor(x(j,2*i),0);
        e_to_b=e_to_b1+e_to_b2;
      
        if distance(1,i)+a_to_b<=distance(5,i)+e_to_b, distance(2,i+1)=distance(1,i)+a_to_b; path(2,i+1)=2; end
        if distance(5,i)+e_to_b<distance(1,i)+a_to_b,distance(2,i+1)=distance(5,i)+e_to_b; path(2,i+1)=10; end
        
        
        % b[100]->c[010]
        b_to_c1=xor(x(j,2*i-1),1); 
        b_to_c2=xor(x(j,2*i),1);
        b_to_c=b_to_c1+b_to_c2;
        
        % f[101]->c[010]
        f_to_c1=xor(x(j,2*i-1),0);
        f_to_c2=xor(x(j,2*i),0);
        f_to_c=f_to_c1+f_to_c2;
        
        if distance(2,i)+b_to_c<=distance(6,i)+f_to_c,distance(3,i+1)=distance(2,i)+b_to_c; path(3,i+1)=3;end
        if distance(6,i)+f_to_c<distance(2,i)+b_to_c, distance(3,i+1)=distance(6,i)+f_to_c; path(3,i+1)=11; end
        
      
        % b[100]->d[110]
        b_to_d1=xor(x(j,2*i-1),0); 
        b_to_d2=xor(x(j,2*i),0);
        b_to_d=b_to_d1+b_to_d2;
        
        % f[101]->d[110]
        f_to_d1=xor(x(j,2*i-1),1); 
        f_to_d2=xor(x(j,2*i),1);
        f_to_d=f_to_d1+f_to_d2;
        
        if distance(2,i)+b_to_d<=distance(6,i)+f_to_d, distance(4,i+1)=distance(2,i)+b_to_d; path(4,i+1)=4; end
        if distance(6,i)+f_to_d<distance(2,i)+b_to_d,distance(4,i+1)=distance(6,i)+f_to_d; path(4,i+1)=12; end
     
        % c[010]->e[001]
        c_to_e1=xor(x(j,2*i-1),0);
        c_to_e2=xor(x(j,2*i),1);
        c_to_e=c_to_e1+c_to_e2;
        
        % g[011]->e[001]
        g_to_e1=xor(x(j,2*i-1),1); 
        g_to_e2=xor(x(j,2*i),0);
        g_to_e=g_to_e1+g_to_e2;
        
        if distance(3,i)+c_to_e<=distance(7,i)+g_to_e, distance(5,i+1)=distance(3,i)+c_to_e; path(5,i+1)=5;end
        if distance(7,i)+g_to_e<distance(3,i)+c_to_e,distance(5,i+1)=distance(7,i)+g_to_e; path(5,i+1)=13;end
        
     
        % c[010]->f[101]
        c_to_f1=xor(x(j,2*i-1),1); 
        c_to_f2=xor(x(j,2*i),0);
        c_to_f=c_to_f1+c_to_f2;
        
        % g[011]->f[101]
        g_to_f1=xor(x(j,2*i-1),0); 
        g_to_f2=xor(x(j,2*i),1);
        g_to_f=g_to_f1+g_to_f2;
        
        if distance(3,i)+c_to_f<=distance(7,i)+g_to_f, distance(6,i+1)=distance(3,i)+c_to_f; path(6,i+1)=6; end
        if distance(7,i)+g_to_f<distance(3,i)+c_to_f,distance(6,i+1)=distance(7,i)+g_to_f; path(6,i+1)=14; end
       
        
        % d[110]->g[011]
        d_to_g1=xor(x(j,2*i-1),1); 
        d_to_g2=xor(x(j,2*i),0);
        d_to_g=d_to_g1+d_to_g2;
        
        % h[111]->g[011]
        h_to_g1=xor(x(j,2*i-1),0); 
        h_to_g2=xor(x(j,2*i),1);
        h_to_g=h_to_g1+h_to_g2;
        
        if distance(4,i)+d_to_g<=distance(8,i)+h_to_g, distance(7,i+1)=distance(4,i)+d_to_g; path(7,i+1)=7; end
        if distance(8,i)+h_to_g<distance(4,i)+d_to_g,distance(7,i+1)=distance(8,i)+h_to_g; path(7,i+1)=15; end
        
        
       
        % d[110]->h[111]
        d_to_h1=xor(x(j,2*i-1),0);
        d_to_h2=xor(x(j,2*i),1);
        d_to_h=d_to_h1+d_to_h2;
        
        % h[111]->h[111]
        h_to_h1=xor(x(j,2*i-1),1); 
        h_to_h2=xor(x(j,2*i),0);
        h_to_h=h_to_h1+h_to_h2;
        
        if distance(4,i)+d_to_h<=distance(8,i)+h_to_h, distance(8,i+1)=distance(4,i)+d_to_h; path(8,i+1)=8; end
        if distance(8,i)+h_to_h<distance(4,i)+d_to_h,distance(8,i+1)=distance(8,i)+h_to_h; path(8,i+1)=16; end
        
    end
    
    % 경로 선택 
    D_free=min(distance(:,1001)); % 마지막 노드 중 Path Metric이 가장 작은 것 선정
    
 
    for w=1:8 
        if distance(w,1001)==D_free  %path metric이 가장 작은 Dfree를 찾고 어느 경로인지 a에 저장
            a=w;
        end
    end
    
   % trace back
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
