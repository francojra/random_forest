
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

### Método bootstrapping: para cada subamostra, podemos gerar 
### uma árvore de decisão conforme descrito anteriormente, e 
### então tomar a média das decisões para cada observação como
### decisão final.

###