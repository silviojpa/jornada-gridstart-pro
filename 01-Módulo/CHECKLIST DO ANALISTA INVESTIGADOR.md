# IDENTIFICAÇÃO DO PROJETO (App_Coversão_Distancia)
## Nome da aplicação ou sistema analisado

## ARMAZENAMENTO
1- Onde a aplicação guarda os arquivos?
* **O Dev disse:** - Aplicação fica hospedada no github 
* **Aplicação é:** - A linguagen utilizada é python e html
* **O que isso revela para o ambiente:** - E uma aplicação de baixa complexibilidade.  
Arquivos em pasta local = cuidado ao escalar servidores.

## DEPENDÊNCIAS EXTERNAS
2- Com o que a aplicação se comunica lá fora?
* **APIs / serviços externos consumidos:** - SErviço consumido é GET com a resposta.
* **Bancos ou sistemas legados acessados:** - DB apanes para armazenamentode metadata de users.  
* **O que isso revela para o ambiente:** - Ficar dentro dos parametros e exigência da norma LGPD.
Cada dependência externa = uma porta que precisa estar configurada.

## RESILIÊNCIA
3- O que acontece se o banco piscar por 5 segundos?
* **Comportamento descrito pelo Dev:** - Fica em fila de query ou lopp de request até a estabilidade da rede.
* **Existe lógica de retry no código?** - Não, precisa da reset no servidor, apenas aguarda normalização da rede.
* **O que isso revela para o ambiente:** - Um APP de com baixa necessidade de 'scaling'.
Sistema trava = risco real de produção. Registre e escale.

## PERFIL DE TRÁFEGO
4- O tráfego é constante ou tem picos?
* **Volume estimado / padrão descrito:** - A logo prazo o de metadatas de user. 
* **Existem datas ou eventos de pico?** - Acesso de pico em maoir escala as 18h durante a senana.
* **O que isso revela para o ambiente:** - Um ambiente escalável horizontalmente case necessário das 17h às 20h
Picos agressivos = ambiente fixo pode não dar conta.
