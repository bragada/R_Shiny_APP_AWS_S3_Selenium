# Web App - R Shiny + AWS S3 + Web Scrapping

O fluxo desse projeto se resume nos seguintes tópicos:

 * Criação de um script em R que executa Web Scrapping de dados de um site, usando RSelenium
 * Manipulação das diversas bases de dados baixadas
 * Upload das bases em um S3 bucket AWS
 * Automação das 3 etapas anteriores usando taskscheduleR, que roda os scripts a cada 30 minutos
 * Criação de um Shiny APP e deploy no shinyio

link App: https://hkbragada.shinyapps.io/conecta_teste/
