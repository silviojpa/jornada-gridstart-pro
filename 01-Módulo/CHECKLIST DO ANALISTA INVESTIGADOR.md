# IDENTIFICAÇÃO DO PROJETO ()
## Nome da aplicação ou sistema analisado

## ARMAZENAMENTO
1- Onde a aplicação guarda os arquivos?
- O Dev disse:
- Aplicação é:
- O que isso revela para o ambiente:
Arquivos em pasta local = cuidado ao escalar servidores.

## DEPENDÊNCIAS EXTERNAS
2- Com o que a aplicação se comunica lá fora?
- APIs / serviços externos consumidos:
- Bancos ou sistemas legados acessados:
- O que isso revela para o ambiente:
Cada dependência externa = uma porta que precisa estar configurada.

## RESILIÊNCIA
3- O que acontece se o banco piscar por 5 segundos?
- Comportamento descrito pelo Dev:
- Existe lógica de retry no código?
- O que isso revela para o ambiente:
Sistema trava = risco real de produção. Registre e escale.

## PERFIL DE TRÁFEGO
4- O tráfego é constante ou tem picos?
- Volume estimado / padrão descrito:
- Existem datas ou eventos de pico?
- O que isso revela para o ambiente:
Picos agressivos = ambiente fixo pode não dar conta.
