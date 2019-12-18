tc=[1 2;1 3;1 4;1 5;1 6;1 7;7 8;6 9;9 10;9 11;9 12;2 4;4 5;5 7;5 6];
sh=ObjectCreateGraph(tc);%15 edges
sh=GraphMakeUndirected(sh);%30 edges
shm=full(getadjacency(sh.Data));%����ͼ���ڽӾ���
%���ھӹ�ϵͶ��ľ���p_ij
for i=1:length(shm)
    p_ij(i,:)=shm(i,:)/(sum(shm(i,:)));
end
%GraphNodeFirstNeighbours(sh,1)
%�ṹ��
ppp=zeros(length(shm));
for i=1:length(shm) 
    n1=GraphNodeFirstNeighbours(sh,i);%i���ھ�
    lenneig=length(n1);%�ھӳ���
    for j=1:lenneig
        ne1=n1(j);
        n2=GraphNodeFirstNeighbours(sh,ne1);%n1(j)(�ǽڵ�)���ھ�
        com=intersect(n1,n2);%i��n1(j)�Ĺ�ͬ�ھ�
        for k=1:length(com)
            ppp(i,ne1)=ppp(i,ne1)+p_ij(i,com(k))*p_ij(com(k),ne1);
        end
    end
end
cc2=ppp+p_ij;
cc2=cc2.*cc2;
cc22=sum(cc2,2);%constraint coefficient

%adaptive constraint coefficient
%�Ľ�������ṹ��
%ap_ij����
nod=GraphCountNodesDegree(sh);
nod=nod(:,3);
for i=1:length(shm)
    q(i)=0;
    n1=GraphNodeFirstNeighbours(sh,i);
    for j=1:length(n1)
        te=n1(j);
        q(i)=q(i)+nod(te);%�ڽӶ�
    end
end
%�����ĸ
for i=1:length(shm)
    qq(i)=0;
    n1=GraphNodeFirstNeighbours(sh,i);
    for j=1:length(n1)
        te=n1(j);
        qq(i)=qq(i)+q(te);
    end
end

[ro,co]=find(shm);
for i=1:length(ro)
     ap_ij(ro(i),co(i))=q(co(i))/qq(ro(i));
end

app=zeros(length(shm));
for i=1:length(shm) 
    n1=GraphNodeFirstNeighbours(sh,i);%i���ھ�
    lenneig=length(n1);%�ھӳ���
    for j=1:lenneig
        ne1=n1(j);
        n2=GraphNodeFirstNeighbours(sh,ne1);%n1(j)(�ǽڵ�)���ھ�
        com=intersect(n1,n2);%i��n1(j)�Ĺ�ͬ�ھ�
        for k=1:length(com)
            app(i,ne1)=app(i,ne1)+ap_ij(i,com(k))*ap_ij(com(k),ne1);
        end
    end
end
ac2=app+ap_ij;
ac2=ac2.*ac2;
ac22=sum(ac2,2);%�Ľ��Ľṹ��ϵ��   adaptive constraint coefficient 
     
    

    
    
    


        
        
        
        


            
            
