pacman::p_load(tidyverse,RSelenium,netstat,purrr,wdman,netstat,aws.s3,readxl,httr,writexl,janitor)

setwd("C:/Users/hk")
# ACESSO
Sys.setenv("AWS_ACCESS_KEY_ID" = "###############",
           "AWS_SECRET_ACCESS_KEY" = "##################",
           "AWS_DEFAULT_REGION" ="sa-east-1")



esperar <- \(nome,elemento) {
  nome <- NULL
  while(is.null(nome)){
    nome <- tryCatch({
      elemento
    },
    error = function(e){NULL})
  }
  nome$clickElement()
}

`%!in%` <- Negate(`%in%`) 

rD <- rsDriver(browser=c("chrome"),
               chromever= "114.0.5735.90",
               verbose = T
               )
remDr <- rD$client

# Acessa o site/url
remDr$navigate("https://conectacampinas.exati.com.br/")
Sys.sleep(2)

remDr$maxWindowSize()
# LOGIN ----

# USUARIO
usuario <- remDr$findElement("xpath",
  '//*[@id="userInfo.username"]')
usuario$clickElement()
usuario$sendKeysToElement(list("user"))
usuario$clickElement()

# SENHA
senha <- remDr$findElement("xpath",
   '//*[@id="userInfo.password"]')
senha$clickElement()
senha$sendKeysToElement(list("password"))

# LOGAR
remDr$findElement("xpath",
                  '//span[. = " Acessar "]'                          
)$clickElement()
Sys.sleep(1)
# ----

# AVISO INICIAL
#remDr$findElement("xpath",'//*[@id="app"]/div[3]/div/div/div[3]/button')$clickElement()
Sys.sleep(1)

o <- \() {remDr$findElement("xpath",'//*[@id="app"]/div[3]/div/div/div[3]/button')$clickElement()}
try(o(), silent=TRUE)
Sys.sleep(1)

# ATENDIMENTOS ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {
  # OPEN MENU
  esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
  Sys.sleep(2)
  
  # CLICA GUIA
  esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Atendimentos "]'))
  Sys.sleep(25)
  
  # MENU - TRES PONTOS
  esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div/div[1]/div[5]/div[1]/button'))
  Sys.sleep(4)
  
  # EXPORTAR PARA
  esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
  Sys.sleep(4)
  
  # MENU .XLSX
  esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
  Sys.sleep(4)
  
  # XLSX 
  esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
  Sys.sleep(4)
  
  # DOWNLOAD 
  esperar(download,remDr$findElement("xpath",'//div[. = " Exportação "]/button/span'))
  Sys.sleep(4)
  
  # FECGA GUIA
  esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
  Sys.sleep(2)
  
 remDr$refresh()
  Sys.sleep(3)
}


# RENAME
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/atendimentos.xlsx")
#file.rename(paste0("Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"HD_Externo/Conecta/atendimentos.xlsx")

# ----

# SOLICITACOES ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(3)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Solicitações "]'))
Sys.sleep(6)

# PESQUISA 
esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div[1]/div[4]/div/div/div/div[2]/div/div/button'))
Sys.sleep(12)

# MENU - TRES PONTOS
esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div[1]/div[5]/div[1]/button'))
Sys.sleep(4)

# EXPORTAR PARA
esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
Sys.sleep(4)

# MENU .XLSX
esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
Sys.sleep(3)

# XLSX 
esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
Sys.sleep(3)

# DOWNLOAD 
esperar(download,remDr$findElements("xpath",'//div[. = " Exportação "]/button/span')[[1]])
Sys.sleep(4)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))

remDr$refresh()
Sys.sleep(3)
}

# RENAME 
#file.rename(paste0("Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"HD_Externo/Conecta/solicitacoes.xlsx")
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/solicitacoes.xlsx")

# ----

# PAINEL DE OCORRENCIAS ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(2)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Painel de Ocorrência "]'))
Sys.sleep(4)

# PESQUISA 
esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
Sys.sleep(12)

# MENU - TRES PONTOS
esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div/div[1]/div[4]/div[1]/button'))
Sys.sleep(4)

# EXPORTAR PARA
esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
Sys.sleep(4)

# MENU .XLSX
esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
Sys.sleep(4)

# XLSX 
esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
Sys.sleep(4)

# DOWNLOAD 
esperar(download,remDr$findElements("xpath",'//div[. = " Exportação "]/button/span')[[2]])
Sys.sleep(4)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
Sys.sleep(2)

remDr$refresh()
Sys.sleep(3)

}

# RENAME 
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/painel_ocorrencias.xlsx")
# ----

# PAINEL DE MONITORAMENTO ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(2)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Painel de monitoramento "]'))
Sys.sleep(2)

# PESQUISA 
esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div[1]/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
Sys.sleep(12)

# MENU - TRES PONTOS
esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div[1]/div/div[1]/div[4]/div[1]/button'))
Sys.sleep(4)

# EXPORTAR PARA
esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
Sys.sleep(4)

# MENU .XLSX
esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
Sys.sleep(4)

# XLSX 
esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
Sys.sleep(4)

# DOWNLOAD 
esperar(download,remDr$findElement("xpath",'//div[. = " Exportação "]/button/span'))
Sys.sleep(4)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
Sys.sleep(2)

remDr$refresh()
Sys.sleep(3)
}

# RENAME 
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/painel_monitoramento.xlsx")
# ----

# MATERIAIS APLICADOS ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(2)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Materiais aplicados "]'))
Sys.sleep(4)

# PESQUISA 
esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div/div[2]/div/div[1]/div/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
Sys.sleep(12)

# MENU - TRES PONTOS
esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div/div[2]/div/div[1]/div/div/div[1]/div[4]/div[1]/button'))
Sys.sleep(4)

# EXPORTAR PARA
esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
Sys.sleep(4)

# MENU .XLSX
esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
Sys.sleep(4)

# XLSX 
esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
Sys.sleep(4)

# DOWNLOAD 
esperar(download,remDr$findElement("xpath",'//div[. = " Exportação "]/button/span'))
Sys.sleep(4)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
Sys.sleep(2)

remDr$refresh()
Sys.sleep(3)
}

# RENAME 
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/materiais_aplicados.xlsx")


# ----

# ORDENS DE SERVICO ----

while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(2)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Ordens de serviço "]'))
Sys.sleep(4)


# FILTRO 
esperar(clica_filtro,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[2]/div/div/div[1]/div[3]/div/div/div/div[1]/div/span/div/button'))
Sys.sleep(4)

esperar(clica_filtro_ops,remDr$findElement("xpath",'//div[. ="Todos ativos"]'))
Sys.sleep(4)

esperar(clica_filtro_todos,remDr$findElement("xpath",'//div[. ="Todos"]'))
Sys.sleep(4)

esperar(clica_filtrar,remDr$findElement("xpath",'//span[. =" Aplicar "]'))
Sys.sleep(4)

esperar(clica_fechar,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[2]/div/div/div[1]/div[3]/div/aside/div[1]/header/div/div[2]/button'))
Sys.sleep(4)


## PESQUISA 
#esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[2]/div/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
#Sys.sleep(4)

# MENU - TRES PONTOS
esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[2]/div/div/div[1]/div[4]/div[1]/button'))
Sys.sleep(2)

# EXPORTAR PARA
esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
Sys.sleep(2)

# MENU .XLSX
esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
Sys.sleep(2)

# XLSX 
esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
Sys.sleep(2)

# DOWNLOAD 
esperar(download,remDr$findElement("xpath",'//div[. = " Exportação "]/button/span'))
Sys.sleep(4)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
Sys.sleep(2)
}

remDr$refresh()
Sys.sleep(3)

# RENAME
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/ordens_servico.xlsx")

# ----

# OCORRENCIAS PRA AUTORIZAR ----
while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {
  
  # OPEN MENU
  esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
  Sys.sleep(2)
  
  # CLICA GUIA
  esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Ocorrências para autorizar "]'))
  Sys.sleep(4)
  
  # PESQUISA 
  esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
  Sys.sleep(22)
  
  # MENU - TRES PONTOS
  esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div/div[1]/div[4]/div[1]/button'))
  Sys.sleep(2)
  
  # EXPORTAR PARA
  esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
  Sys.sleep(2)
  
  # MENU .XLSX
  esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
  Sys.sleep(2)
  
  # XLSX 
  esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
  Sys.sleep(2)
  
  # DOWNLOAD 
  esperar(download,remDr$findElements("xpath",'//div[. = " Exportação "]/button/span')[[2]])
  Sys.sleep(4)
  
  # FECGA GUIA
  esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
  Sys.sleep(2)
  
  remDr$refresh()
  Sys.sleep(3)
}


# RENAME
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/ocorrencias_autorizar.xlsx")

# ----

# ATENDIMENTOS/PRAZO ----
#arq_prazo <- FALSE

while (is_empty(list.files("C:/Users/hk/Downloads/")[str_detect( list.files("C:/Users/hk/Downloads/"),pattern = "Consultar")])) {

# OPEN MENU
esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
Sys.sleep(2)

# CLICA GUIA
esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Atendimentos quanto ao prazo "]'))
Sys.sleep(2)


# teste


# teste


# PESQUISA 
#esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div/div/div/div/div/div[2]/div/div/button'))
#Sys.sleep(7)

# DOWNLOAD RELATORIO
esperar(download_rel,remDr$findElement("xpath",'//div[. = " Relatórios "]/button/span'))
Sys.sleep(3)

# DOWNLOAD RELATORIO 2
esperar(download_excel,remDr$findElement("xpath",'//div[. = "Excel"]/span'))
Sys.sleep(5)

# ACESSA RELATORIO
esperar(acessa_menu_rel,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[4]/span/span/i'))
Sys.sleep(5)

# ACESSA RELATORIO 2
esperar(download,remDr$findElements("xpath",'//*[@class = "v-btn v-btn--depressed v-btn--flat v-btn--icon v-btn--round theme--light v-size--default primary--text"]')[[1]])
Sys.sleep(6)

# FECGA GUIA
esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
Sys.sleep(2)

remDr$refresh()
Sys.sleep(3)

}
Sys.sleep(10)

# RENAME
if (!is_empty(list.files("C:/Users/hk/Downloads/")[str_detect( list.files("C:/Users/hk/Downloads/"),pattern = "Consultar")]) == TRUE) {
  file.rename(paste0("C:/Users/hk/Downloads/", list.files("C:/Users/hk/Downloads/")[str_detect(string = list.files("C:/Users/hk/Downloads/"),pattern = "Consultar")]),
              "C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.xlsx")  
} 
Sys.sleep(15)


formata_sgi =  readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.xlsx",skip = 2) %>% 
  slice(-1) %>% xlsx::write.xlsx("C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.xlsx")

Sys.sleep(10)
#----

# RELATORIO COMPLETO DE PONTOS MODERNIZADOS ----
while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {
  
  # OPEN MENU
  esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
  Sys.sleep(2)
  
  # CLICA GUIA
  esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Relatório completo de pontos modernizados "]'))
  Sys.sleep(4)
  
  # PESQUISA 
  esperar(pesquisa,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div/div[1]/div[3]/div/div/div/div[2]/div/div/button'))
  Sys.sleep(12)
  
  # MENU - TRES PONTOS
  esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div/div[1]/div[4]/div[1]/button'))
  Sys.sleep(2)
  
  # EXPORTAR PARA
  esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
  Sys.sleep(2)
  
  # MENU .XLSX
  esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
  Sys.sleep(2)
  
  # XLSX 
  esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
  Sys.sleep(2)
  
  # DOWNLOAD 
  esperar(download,remDr$findElements("xpath",'//div[. = " Exportação "]/button/span')[[1]])
  Sys.sleep(4)
  
  # FECGA GUIA
  esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
  Sys.sleep(2)
  
  remDr$refresh()
  Sys.sleep(3)
}


# RENAME
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/mod_materiais.xlsx")


#
#
#
# ----

# OBRAS ----
while (!file.exists(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"))) {
  # OPEN MENU
  esperar(open_menu,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/button[1]'))
  Sys.sleep(2)
  
  # CLICA GUIA
  esperar(clica_guia,remDr$findElement("xpath",'//h4[. =" Obras "]'))
  Sys.sleep(10)
  
  # MENU - TRES PONTOS
  esperar(menu_tres_pontos,remDr$findElement("xpath",'//*[@id="page-wrapper"]/div/div/div[1]/div[1]/div[4]/div[1]/button'))
  Sys.sleep(4)
  
  # EXPORTAR PARA
  esperar(exportar_para,remDr$findElement("xpath",'//div[. = " Exportar para "]'))
  Sys.sleep(4)
  
  # MENU .XLSX
  esperar(menu_xlsx,remDr$findElement("xpath",'//div[. = "Exportar para"]'))
  Sys.sleep(4)
  
  # XLSX 
  esperar(xlsx,remDr$findElement("xpath",'//div[. = "XLSX"]'))
  Sys.sleep(4)
  
  # DOWNLOAD 
  esperar(download,remDr$findElement("xpath",'//div[. = " Exportação "]/button/span'))
  Sys.sleep(4)
  
  # FECGA GUIA
  esperar(fecha_guia,remDr$findElement("xpath",'//*[@id="app"]/div[1]/div[2]/header/div/div[1]/div/div[2]/div/div[2]/button'))
  Sys.sleep(2)
  
  remDr$refresh()
  Sys.sleep(3)
}


# RENAME
file.rename(paste0("C:/Users/hk/Downloads/",format(Sys.Date(),"%d-%m-%Y"),".xlsx"),"C:/Users/hk/HD_Externo/Conecta/obras.xlsx")
# ----


###### MANIPULAÇÕES ########

# ATENDIMENTOS ----
funcao_cor_ <- \(){
  c(
    "brown","cadetblue","cyan", "bisque","blue","green", "red","black", "aquamarine","coral","aliceblue","blueviolet", "chocolate", "beige","darkgreen","darkolivegreen","darksalmon","darkorange","darkseagreen","darkslategray","deeppink","deepskyblue", "darkred","darkgrey","antiquewhite","darkorchid", "darkmagenta","tan","olivedrab","darkkhaki","cornflowerblue","darkslateblue","white" ,"blanchedalmond","darkcyan","plum","indianred","sandybrown","burlywood","chartreuse","darkgoldenrod"
  )
  #viridisLite::viridis(30)
  #paste0("#", paste0(sample(c(0:9, letters[1:6]), 6, replace = TRUE), collapse = ""))
}



readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/atendimentos.xlsx") %>% 
  clean_names() %>% 
  mutate(data_atendimento = as.Date(data_atendimento,"%d/%m/%Y"))%>% 
  rename(lat=latitude_total_ponto,lon=longitude_total_ponto,equipe = desc_equipe)  %>% 
  mutate(semana_marco = week(data_atendimento)-week(as.Date("2023-02-25")),
         mes = month(data_atendimento),
         mes = case_when(
           mes == 1 ~ "Janeiro",
           mes == 2 ~ "Fevereiro",
           mes == 3 ~ "Março",
           mes == 4 ~ "Abril",
           mes == 5 ~ "Maio",
           mes == 6 ~ "Junho",
           mes == 7 ~ "Julho",
           mes == 8 ~ "Agosto",
           mes == 9 ~ "Setembro",
           mes == 10 ~ "Outubro",
           mes == 11 ~ "Novembro",
           mes == 12 ~ "Dezembro"
         ),
         mes = factor(mes,levels = c("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")),
         lat = as.numeric(str_replace(lat,",",".")),
         lon = as.numeric(str_replace(lon,",","."))) %>% 
  filter(atendimento %!in% c("MOD: RETRABALHO","MOD: Atendido")) %>% 
  replace_na(list(motivo = "Encontrado normal",tipo_de_ocorrencia = "Não informado")) %>% 
  mutate(hora = hms(hora_inicio)) %>%
  mutate(data_hora = case_when(
    hora <= hms("06:00:00") ~ data_atendimento-1,
    TRUE ~ data_atendimento
  ),
  dia_semana = wday(data_hora,label = T),
  dia_semana = case_when(
    dia_semana %in% c("dom","Sun") ~ "Dom",
    dia_semana %in% c("seg","Mon") ~ "Seg",
    dia_semana %in% c("ter","Tue") ~ "Ter",
    dia_semana %in% c("qua","Wed") ~ "Qua",
    dia_semana %in% c("qui","Thu") ~ "Qui",
    dia_semana %in% c("sex","Fri") ~ "Sex",
    dia_semana %in% c("sab","Sat") ~ "Sab"
    
  ),
  semana = week(data_hora) - week(floor_date(data_hora,"month")) +1) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/atendimentos.fst")%>% suppressWarnings()



# ----

# SOLICITACOES ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/solicitacoes.xlsx") %>% 
    clean_names() %>% 
  mutate(data_reclamacao = as.Date(data_reclamacao,"%d/%m/%Y"),
         semana_marco = week(data_reclamacao)-week(as.Date("2023-02-25")),
         mes = month(data_reclamacao),
         mes = case_when(
           mes == 1 ~ "Janeiro",
           mes == 2 ~ "Fevereiro",
           mes == 3 ~ "Março",
           mes == 4 ~ "Abril",
           mes == 5 ~ "Maio",
           mes == 6 ~ "Junho",
           mes == 7 ~ "Julho",
           mes == 8 ~ "Agosto",
           mes == 9 ~ "Setembro",
           mes == 10 ~ "Outubro",
           mes == 11 ~ "Novembro",
           mes == 12 ~ "Dezembro",
         ),
         mes = factor(mes,levels = c("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")),
         dia_semana = wday(data_reclamacao,label = T),
         dia_semana = case_when(
           dia_semana %in% c("dom","Sun") ~ "Dom",
           dia_semana %in% c("seg","Mon") ~ "Seg",
           dia_semana %in% c("ter","Tue") ~ "Ter",
           dia_semana %in% c("qua","Wed") ~ "Qua",
           dia_semana %in% c("qui","Thu") ~ "Qui",
           dia_semana %in% c("sex","Fri") ~ "Sex",
           dia_semana %in% c("sab","Sat") ~ "Sab"
           
         ),
         semana = week(data_reclamacao) - week(floor_date(data_reclamacao,"month")) +1) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/solicitacoes.fst")%>% suppressWarnings()
# ----

# PAINEL DE OCORRENCIAS ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/painel_ocorrencias.xlsx") %>% 
clean_names() %>% 
  mutate(
    data_limite_para_atendimento = limite_atendimento,
    #recebida =  as.POSIXct(strptime(recebida,"%d/%m/%Y %H:%M")),
    data_limite =as.POSIXct(strptime(limite_atendimento,"%d/%m/%Y %H:%M")),
    dif = as.numeric(round(difftime(data_limite, as.POSIXct(Sys.time(),"GMT"),units = "hours"),0)),
    data_reclamacao = as.Date(data_reclamacao,"%d/%m/%Y"),
    data_limite_atendimento = as.Date(data_limite_atendimento,"%d/%m/%Y"),
    dias_prazo = as.numeric(data_limite_atendimento - Sys.Date()),
    atrasado = ifelse(dias_prazo < 0, "Atrasada","No Prazo"),
    lat=as.numeric(str_replace(latitude_total,",",".")),
    lon=as.numeric(str_replace(longitude_total,",","."))) %>% 
  #rename(lat=latitude_total,lon=longitude_total)  %>% 
  mutate(
    cor_atraso = case_when(
      dias_prazo >= 0 ~ "darkgreen",
      TRUE ~ "red"
    )) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/painel_ocorrencias.fst")

# ----

# PAINEL DE MONITORAMENTO ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/painel_monitoramento.xlsx") %>% 
clean_names() %>% 
  mutate(
    #recebida =  as.POSIXct(strptime(recebida,"%d/%m/%Y %H:%M")),
    data_limite =as.POSIXct(strptime(data_limite_para_atendimento,"%d/%m/%Y %H:%M")),
    dif = as.numeric(round(difftime(data_limite, as.POSIXct(Sys.time(),"GMT"),units = "hours"),0)),
    data_reclamacao = as.Date(data_reclamacao,"%d/%m/%Y"),
    data_limite_atendimento = as.Date(data_limite_atendimento,"%d/%m/%Y"),
    dias_prazo = as.numeric(data_limite_atendimento - Sys.Date()),
    atrasado = ifelse(dias_prazo < 0, "Atrasada","No Prazo"),
    lat=as.numeric(str_replace(latitude_total,",",".")),
    lon=as.numeric(str_replace(longitude_total,",","."))
  ) %>% 
  rename(protocolo=numero_protocolo) %>% 
  mutate(
    cor_atraso = case_when(
      dias_prazo >= 0 ~ "darkgreen",
      TRUE ~ "red"
    )) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/painel_monitoramento.fst")%>% suppressWarnings()

# ----

# MATERIAIS APLICADOS ----
relacoes =  readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/Relação_precos_materiais.xlsx") %>%
  clean_names() 


readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/materiais_aplicados.xlsx") %>% 
  clean_names() %>% 
  filter(codigo %in% unique(relacoes$codigo)) %>% 
  mutate(data = as.Date(data,"%d/%m/%Y"),
         hora = hms(hora_inicial),
         data_hora = case_when(
           hora <= hms("06:00:00") ~ data-1,
           TRUE ~ data
         ),
         quantidade = str_replace(quantidade,",","."))  %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/materiais_aplicados.fst")%>% suppressWarnings()

# ----

# ORDENS DE SERVICO ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/ordens_servico.xlsx") %>% 
  clean_names() %>% 
  mutate(data= as.POSIXct(strptime(data,"%d/%m/%Y %H:%M")),
         prazo = as.numeric(str_replace(prazo,",","."))) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/ordens_servico.fst")

# ----

# OCORRENCIAS PRA AUTORIZAR (TEM QUE VER NA EXATI PARA INCLUIR LAT E LON)---- 
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/ocorrencias_autorizar.xlsx") %>% 
  clean_names() %>% 
  mutate(data_limite_de_atendimento_original = as.Date(data_limite_de_atendimento_original,"%d/%m/%Y"),
         data_reclamacao = as.Date(data_reclamacao,"%d/%m/%Y")) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/ocorrencias_autorizar.fst")%>% suppressWarnings()

# ----

# ATENDIMENTOS/PRAZO ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.xlsx") %>% 
  clean_names() %>% 
  select(-x1) %>% 
  #slice(-1) %>% 
  rename(prazo_hora = x4,atendimento_hora = x6) %>% 
  mutate(prazo = as.Date(prazo,"%d/%m/%Y"),
         data_atendimento = as.Date(data_atendimento,"%d/%m/%Y"),
         mes = month(data_atendimento),
         mes = case_when(
           mes == 1 ~ "Janeiro",
           mes == 2 ~ "Fevereiro",
           mes == 3 ~ "Março",
           mes == 4 ~ "Abril",
           mes == 5 ~ "Maio",
           mes == 6 ~ "Junho",
           mes == 7 ~ "Julho",
           mes == 8 ~ "Agosto",
           mes == 9 ~ "Setembro",
           mes == 10 ~ "Outubro",
           mes == 11 ~ "Novembro",
           mes == 12 ~ "Dezembro"
         ),
         mes = factor(mes,levels = c("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")),
         hora = hms(atendimento_hora),
         data_hora = case_when(
           hora <= hms("06:00:00") ~ data_atendimento-1,
           TRUE ~ data_atendimento
         ),
         dia_semana = wday(data_hora,label = T),
         dia_semana = case_when(
           dia_semana %in% c("dom","Sun") ~ "Dom",
           dia_semana %in% c("seg","Mon") ~ "Seg",
           dia_semana %in% c("ter","Tue") ~ "Ter",
           dia_semana %in% c("qua","Wed") ~ "Qua",
           dia_semana %in% c("qui","Thu") ~ "Qui",
           dia_semana %in% c("sex","Fri") ~ "Sex",
           dia_semana %in% c("sab","Sat") ~ "Sab"
           
         ),
         atendimento = as.character(atendimento)
  )  %>%
    filter(!is.na(data_hora)) %>% 
  mutate(atendimento = as.character(atendimento)) %>% 
  left_join(
    fst::read_fst("C:/Users/hk/HD_Externo/Conecta/atendimentos.fst") %>% 
      select(no_atendimento,equipe), by = c("atendimento" = "no_atendimento")) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.fst")%>% suppressWarnings()


  
# ----

# RELATORIO COMPLETO DE PONTOS MODERNIZADOS ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/mod_materiais.xlsx") %>% 
  clean_names() %>% 
  rename(data_mod = data_ultima_modernizacao,hora = hora_ultima_modernizacao,lat=latitude,lon =longitude,equipe = equipe_ultima_modernizacao) %>% 
  mutate(
    data_mod = as.Date(data_mod,"%d/%m/%Y"),
    #hora = as.character(lubridate::hms(hora)),
    data_hora = case_when(
      hora <= "06:00:00" ~ data_mod-1,
      TRUE ~ data_mod
    ),
    mes = month(data_hora),
    mes = case_when(
      mes == 1 ~ "Janeiro",
      mes == 2 ~ "Fevereiro",
      mes == 3 ~ "Março",
      mes == 4 ~ "Abril",
      mes == 5 ~ "Maio",
      mes == 6 ~ "Junho",
      mes == 7 ~ "Julho",
      mes == 8 ~ "Agosto",
      mes == 9 ~ "Setembro",
      mes == 10 ~ "Outubro",
      mes == 11 ~ "Novembro",
      mes == 12 ~ "Dezembro"
    ), 
    mes = factor(mes,levels = c("Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro")),
    lat = as.numeric(str_replace(lat,",",".")),
    lon = as.numeric(str_replace(lon,",",".")),
    n_old = as.numeric(quantidade_anterior),
    n_new = as.numeric(quantidade_ultima_modernizacao),
    pot_old = sapply(str_split(potencia_da_lampada_anterior,";"), function(x) sum(as.numeric(x),na.rm=T)),
    pot_new =sapply(str_split(potencia_da_lampada_ultima_modernizacao,";"), function(x) sum(as.numeric(x),na.rm=T)),
    eficient = round(1-(pot_new/pot_old),1)
    
  ) %>% 
  #writexl::write_xlsx("C:/Users/hk/HD_Externo/Conecta/mod_materiais.xlsx")
 fst::write_fst("C:/Users/hk/HD_Externo/Conecta/mod_materiais.fst")%>% suppressWarnings()


# ----

# OBRAS ----
readxl::read_xlsx("C:/Users/hk/HD_Externo/Conecta/obras.xlsx") %>% 
  clean_names() %>% 
  mutate(rua  = str_trim(str_replace(descricao, "(?i)modernização", ""))) %>% 
  select(id_projeto = num_gco,rua,bairro,status,id_obra) %>% 
  fst::write_fst("C:/Users/hk/HD_Externo/Conecta/obras.fst")

#----


# UPLOPAD ----

#  ATENDIMENTOS 
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/atendimentos.fst", 
  object = "atendimentos.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)
# SOLICITACOES 
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/solicitacoes.fst", 
  object = "solicitacoes.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)

# PAINEL OCORRENCIAS
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/painel_ocorrencias.fst", 
  object = "painel_ocorrencias.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)

# PAINEL MONITORAMENTO
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/painel_monitoramento.fst", 
  object = "painel_monitoramento.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)


# PRAZO
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/sgi_atendimento_atendimentos_prazo.fst", 
  object = "sgi_atendimento_atendimentos_prazo.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)

# MATERIAIS APLICADOS
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/materiais_aplicados.fst", 
  object = "materiais_aplicados.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)


# ORDENS DE SERVIÇO
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/ordens_servico.fst", 
  object = "ordens_servico.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)

# OCORRENCIAS PARA AUTORIZAR
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/ocorrencias_autorizar.fst", 
  object = "ocorrencias_autorizar.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
  
)

# RELATORIO COMPLETO DE PONTOS MODERNIZADOS
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/mod_materiais.fst", 
  object = "mod_materiais.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
)

# OBRAS
put_object(
  file = "C:/Users/hk/HD_Externo/Conecta/obras.fst", 
  object = "obras.fst", 
  bucket = "automacao-conecta",
  # TEM QUE POR A REGIÃO  
  region = 'sa-east-1'
)

Sys.sleep(3)

# ----


remDr$close()
rm(rD)
gc()





