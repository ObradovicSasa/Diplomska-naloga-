function Y=fnLeakyIntegrator(X,alfa)
%% funkcija filtrira vhodne vrstice matrike X 
%% vsaka vrstica je neodvisen signal (v enem trenutku je meritev posamezen stolpec matrike X) 

% Y(:,1)=(1-alfa)*X(:,1);
Y(:,1)=X(:,1);
for i=2:length(X)
    Y(:,i)=alfa*Y(:,i-1)+(1-alfa)*X(:,i);
end

