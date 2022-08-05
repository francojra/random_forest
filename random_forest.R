
# Random forest ----------------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 04/08/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://analisemacro.com.br/data-science/dicas-de-rstats/dicas-r-random-forests/ ---------------------------------------------

# Introdução -------------------------------------------------------------------------------------------------------------------------------

### Vamos apresentar métodos de árvore para a classificação e 
### regressão de dados, e mostrar como utilizar random forests 
### no R. Árvores nesse contexto são um conjunto de regras de 
### decisão que se subdividem (como em galhos) para separar o 
### espaço das variáveis regressoras em compartimentos que 
### preveem um valor ou classe (as folhas).

### Uma estratégia inicial pode ser iniciar em sua base (que, 
### na notação utilizada, é o topo), onde temos basicamente a 
### mesma previsão para todas as observações, e procurar qual 
### regra para qualquer regressor leva à árvore que minimiza 
### uma certa métrica, como o EQM. Dado esse passo, temos uma 
### árvore com dois galhos, que divide o espaço em duas 
### regiões. A partir daí, buscamos a próxima regra que 
### minimiza a métrica (que pode gerar uma subdivisão em um 
### dos galhos originais, ou gerar um terceiro galho a partir 
### da base), e seguimos esse processo recursivamente.

### Algumas vezes o problema de overfitting pode ocorrer, e para
### reduzir a elevada elevância, utilizamos o método de bootstrapping.

### Método bootstrapping: para cada subamostra, podemos gerar 
### uma árvore de decisão conforme descrito anteriormente, e 
### então tomar a média das decisões para cada observação como
### decisão final.

### O método mencionado acima também é chamado de bagging e tem um
### problema:  como sempre testa para todas as variáveis a regra de 
### decisão que melhor diminui o erro, se uma variável possuir poder 
### explanatório muito maior do que as outras, as árvores terão sempre 
### galhos iniciais parecidos, logo a estimação é altamente 
### correlacionada, diminuindo o poder do bootstrapping de reduzir a 
### variância. Para resolver isso, introduzimos as random forests: 
### além de tomar uma subamostra das observações originais, ao 
### construir uma árvore de decisão, cada passo da árvore é feito 
### utilizando apenas parte dos regressores como possíveis regra de 
### decisão, escolhida aleatoriamente todas as vezes. Assim, em grande
### parte das árvores geradas, a variável de maior poder explanatório 
### só será introduzida depois da primeira ramificação - em alguns 
### casos, pode nunca aparecer -, fazendo com que as árvores sejam 
### muito mais diversas sobre suas regras de decisão, tornando-as menos 
### correlacionadas.

# Uma aplicação do Random Forest -----------------------------------------------------------------------------------------------------------

### Carregar dados

data(Boston, package = "MASS")
Boston$chas <- as.logical(Boston$chas)

### Carregar pacote do random forest

library(randomForest)

### Análises

set.seed(2017)
forest <- randomForest(medv ~ ., data = Boston, localImp = TRUE)

install.packages("randomForestExplainer")
library(randomForestExplainer)

min_depth_frame <- min_depth_distribution(forest)
plot_min_depth_distribution(min_depth_frame)

importance_frame <- measure_importance(forest)
plot_multi_way_importance(importance_frame, 
                          size_measure = "no_of_nodes")

plot_multi_way_importance(importance_frame, 
                          x_measure = "mse_increase",
                          y_measure = "node_purity_increase",
                          size_measure = "p_value",
                          no_of_labels = 5)

plot_importance_ggpairs(importance_frame)

plot_predict_interaction(forest, Boston, "rm", "lstat")


