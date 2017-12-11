%% CVX implementation of the optimal portfolio problem with maximum expected returns that dominates a benchmark portfolio in second order%%
%% Returns obtained from the paper %%
%% DENTCHEVA and RUSZCZYNSKI, Optimization with Stochastic Dominance Constraints | SIAM Journal on Optimization | Vol. 14, No. 2 |pp 548-566 2003

load returns.mat
prob = 1/size(returns,1); % Equally likely scenarios

for j = 1:22
   y(j) = (1/size(returns,2))*sum(returns(j,:));
end

for k = 1:22
      v(k) = mean(max((y(k)*ones(size(returns,1),1)-y'),0));
end

cvx_begin
variables x(8) S(22,22) 

objective = 0;
for k = 1:22
    objective  =objective+ prob*sum(x.*returns(k,:)');  
end
maximize (objective)

subject to
for i = 1:22
for k = 1:22    
   sum(returns(k,:)'.*x)+ S(i,k)>=y(i);   
end
end
sum(x) == 1;
 x>=0;
for i = 1:22
    prob*sum(S(i,:))<= v(i);
end
S>=0;
cvx_end

disp(x) % Optimal portfolio that dominates the benchmark in second order
