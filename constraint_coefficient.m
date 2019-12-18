tc=[1 2;1 3;1 4;1 5;1 6;1 7;7 8;6 9;9 10;9 11;9 12;2 4;4 5;5 7;5 6];
sh=ObjectCreateGraph(tc);%15 edges
sh=GraphMakeUndirected(sh);%30 edges
shm=full(getadjacency(sh.Data));%无向图的邻接矩阵
%算邻居关系投入的精力p_ij
for i=1:length(shm)
    p_ij(i,:)=shm(i,:)/(sum(shm(i,:)));
end
%GraphNodeFirstNeighbours(sh,1)
%结构洞
ppp=zeros(length(shm));
for i=1:length(shm) 
    n1=GraphNodeFirstNeighbours(sh,i);%i的邻居
    lenneig=length(n1);%邻居长度
    for j=1:lenneig
        ne1=n1(j);
        n2=GraphNodeFirstNeighbours(sh,ne1);%n1(j)(是节点)的邻居
        com=intersect(n1,n2);%i和n1(j)的共同邻居
        for k=1:length(com)
            ppp(i,ne1)=ppp(i,ne1)+p_ij(i,com(k))*p_ij(com(k),ne1);
        end
    end
end
cc2=ppp+p_ij;
cc2=cc2.*cc2;
cc22=sum(cc2,2);%constraint coefficient

%adaptive constraint coefficient
%改进的邻域结构洞
%ap_ij分子
nod=GraphCountNodesDegree(sh);
nod=nod(:,3);
for i=1:length(shm)
    q(i)=0;
    n1=GraphNodeFirstNeighbours(sh,i);
    for j=1:length(n1)
        te=n1(j);
        q(i)=q(i)+nod(te);%邻接度
    end
end
%计算分母
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
    n1=GraphNodeFirstNeighbours(sh,i);%i的邻居
    lenneig=length(n1);%邻居长度
    for j=1:lenneig
        ne1=n1(j);
        n2=GraphNodeFirstNeighbours(sh,ne1);%n1(j)(是节点)的邻居
        com=intersect(n1,n2);%i和n1(j)的共同邻居
        for k=1:length(com)
            app(i,ne1)=app(i,ne1)+ap_ij(i,com(k))*ap_ij(com(k),ne1);
        end
    end
end
ac2=app+ap_ij;
ac2=ac2.*ac2;
ac22=sum(ac2,2);%改进的结构洞系数   adaptive constraint coefficient 
     
    

    
    
    


        
        
        
        


            
            
