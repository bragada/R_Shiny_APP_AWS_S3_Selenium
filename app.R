pacman::p_load(profvis,colourpicker,crosstalk,plotly,aws.s3,readxl,leaflet.extras,reactable,reactablefmtr,shinyjs,leaflegend,leaflet,googleway,tippy,shinyWidgets,htmltools,janitor,fresh,tidyverse,shiny,DT,shinythemes,bslib,waiter,stringr,paletteer,waiter,highcharter,readr,bs4Dash,shinydashboard,shinydashboardPlus,reshape2)

`%!in%` <- Negate(`%in%`) 

 
# ordens de Serviçoo com filtro de ativos sC#o os despachos do momento

# ACESSO
Sys.setenv("AWS_ACCESS_KEY_ID" = "################",
             "AWS_SECRET_ACCESS_KEY" = "#######################",
           "AWS_DEFAULT_REGION" ="sa-east-1",
           TZ="America/Sao_Paulo")


#Sys.setlocale(category = "LC_TIME", locale = "pt_BR")


relacoes =  readxl::read_xlsx("Relação_precos_materiais.xlsx") %>%
  clean_names() 

csvDownloadButton <- function(id, filename = "data.csv", label = "Download em CSV") {
  tags$button(
    tagList(icon("download"), label),
    onclick = sprintf("Reactable.downloadDataCSV('%s', '%s')", id, filename)
  )
}

info <- \(texto){
  tags$small(
    tags$i(
      class = "fa fa-info-circle fa-lg",
      title = texto,
      `data-toggle` = "tooltip",
      style = "color: rgba(255, 255, 255, 0.75);"
    ),
    class = "pull-right"
  )
}



ui <- bs4DashPage(
  
  # HEADER ----
  header = bs4DashNavbar(
    
    title = dashboardBrand(title = "", opacity = 1,color = "primary",
                           href = "https://conectacampinas.net/",
                           image = "https://conectacampinas.net/wp-content/uploads/2023/03/logo-conecta-campinas2.svg"
    ),
    lefttUi = tags$li(class = "navbar-collapse collapse dropdown",
                      tags$ul(class = "nav navbar-nav sidebar-menu",
                              bs4SidebarMenuItem(paste0("Diário de Operação"),
                                                 tabName="pag1"),
                              
                              style="font-size: 1em;"
                      )
    ),
    sidebarIcon = tags$ul(class = "navbar-nav",style="width: 0px;font-size:0px;")
  ),
  # ----
  # SIDEBAR ----
  sidebar = bs4DashSidebar(disable = T
  ),
  # ----
  body = bs4DashBody(shinyjs::useShinyjs(),
                     
                     
                     # CONFIGS ----
                
                     useWaiter(), 
                     waiterShowOnLoad(html =spin_6(),color = "rgba(13,32,43,0.87)"),
                     waiterOnBusy(html = spin_6(),color = "rgba(13,32,43,0.87)"),
                     #useHostess(),
            
                     use_theme(create_theme(
                       bs4dash_color(
                       red = "#8f2121",
                       blue = "#578b53"
                     ),
                     bs4dash_vars(
                       "card-title-font-size"= "1.2rem",
                       "progress-bar-border-radius"="2px",
                       "body-bg"="rgba(2,58,79,0.71)"
                     ))),
                     # CONFIGS ----
                     
                     
                     tabItems(
                       tabItem(tabName = "pag1",

                               fluidRow(
                                 # CSS ----
                                 tags$style(HTML("
                              
             
                                      .navbar {
                                display: none;
                                }
                                                 
                            .awesome-marker i {
                                color: #000;
                            }
                                                 
                          .info.legend.leaflet-control i {
                               float: left;
                                    }
                                                 
                            .leaflet-top {z-index:999!important;}  
                          
                                .content-wrapper>.content {
                                  padding: 0px !important;
                                }
  
                              #daterange-label {
                                color: white;
                                }
                                                 
                                 body {
                                 text-align: center
                                 }             
                                                 
                              .tab-content {
                                  background: #235776;
                                  background-image: linear-gradient(to top,#cccbcf26,#000000);
                              }
                                                 
                                                 
                              .rt-expander:after   {
                                  border-top: 7px solid #fff;
                              }                 
                                                   
                              .form-control {
                                  text-align: center;
                              }
                                
                              .card-primary:not(.card-outline)>.card-header{
                                  background-image:linear-gradient(to left,#000000ab,rgb(13 110 147 / 71%));
                              }
                                
                              .bg-primary {
                                  background-image: linear-gradient(to right,#030f02,#307aa5);
                              }
                                
                             #c_solic .bg-gradient-primary {
                                  background: linear-gradient(rgba(115, 116, 4, 0.76), #000000) repeat-x !important
                             }
                            #c_vistoria .bg-gradient-primary {
                                  background: linear-gradient(#983737, #000000) repeat-x !important;
                            }
                            #c_tab .bg-gradient-primary {
                                  background: linear-gradient(#983737, #1c0303) repeat-x !important;
                            }
                             #c_historico .bg-gradient-primary {
                                  background: linear-gradient(rgb(110 3 3 / 65%), #000000) repeat-x !important
                             }
                                   #c_modernizacao .bg-gradient-primary {
                                  background: linear-gradient(#006a51, #1c0303) repeat-x !important;
                             }
                             #c_autorizar .bg-gradient-primary {
                                  background: linear-gradient(rgb(110 3 3 / 65%), #000000) repeat-x !important
                            }
                            #c_oc_tipo .bg-gradient-primary {
                                  background: linear-gradient(rgb(110 3 3 / 65%), #000000) repeat-x !important
                            }
                            #c_oc_og .bg-gradient-primary {
                                  background: linear-gradient(rgb(110 3 3 / 65%), #000000) repeat-x !important
                            }
                            #c_gasto .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                            }
                            #c_prefeitura .bg-gradient-primary {
                                  background: linear-gradient(#983737, #000000) repeat-x !important;
                              }
                             
                             .card-body {
                                background-image: linear-gradient(to bottom,#cccbcf26,#b9c7cf);
                             }
                            
                               #at_so_hist .card-body {
                                    background: linear-gradient(#3f92a8c4, #000000) repeat-x !important;
                             }
                            
                             #c_at_imp .bg-gradient-primary {
                                  background: linear-gradient(#983737, #000000) repeat-x !important;
                              }
                             #c_at .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                             }
                       
                          #c_at_equipe_acum .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                          }
                            #c_at_equipe .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                            }
                            
                            #c_hist_os_equipe .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                            }
                                       #status_os_hist .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                            }
                           #at_so_hist .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                            }
                            
                           #c_avulso_equipe .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                           }
                               #c_bairros .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                               }
                                #c_canais_sol .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                                }
                                   #c_mod_equipe .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                             }
                              #c_at_valor .bg-gradient-primary {
                                  background: linear-gradient(rgb(18 54 76), #000000) repeat-x !important 
                             }
                             #c_graf .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                             }
                             #c_at_t .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                             }
                             #c_total_equipes .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_equipe .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                           #c_at_equipe_acum .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                           #c_avulso_equipe .small-box p{
                                 margin-bottom: 0.5rem;
                           }
                             
                             #c_bairros .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_valor .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_t .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_solic .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                              #c_vistoria .small-box p{
                                 margin-bottom: 0.5rem;
                              }
                              #c_tab .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_prefeitura .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_prazo .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_fprazo .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_at_avulso .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                             #c_graf .small-box p{
                                 margin-bottom: 0.5rem;
                             }
                              
                              
                            #c_at_avulso .bg-gradient-primary {
                                  background: linear-gradient(#bf7b01, #000000) repeat-x !important;
                            }
                            #c_at_prazo .bg-gradient-primary {
                                  background: linear-gradient(#1d77ab, #000000) repeat-x !important;
                              }
                             
                            #c_at_fprazo .bg-gradient-primary {
                                  background: linear-gradient(#983737, #000000) repeat-x !important;
                            }
                            #c_at_fprazo .bg-gradient-primary {
                                  background: linear-gradient(#983737, #000000) repeat-x !important;
                            }
                            #c_oc_atrasadas .bg-gradient-primary {
                                  background: linear-gradient(rgb(110 3 3 / 65%), #000000) repeat-x !important
                            }
                            #c_total_equipes .bg-gradient-primary {
                                  background: linear-gradient(rgba(18, 77, 45, 0.76), #000000) repeat-x !important
                            }
                             
                          .brand-link {
                              display: block;
                              font-size: 1.25rem;
                              line-height: 1.5;
                              padding: 0.8125rem 3.5rem;
                              transition: width .3s ease-in-out;
                              white-space: nowrap;
                          }
                          .img-circle {
                              border-radius: 0%;
                          }
                          .elevation-3 {
                            box-shadow: 0 0px 0px rgb(0 0 0 / 19%), 0 0px 0px rgb(0 0 0 / 23%) !important;
                          }
                          .dropdown-item.active, .dropdown-item:active {
                          background-color: #dee2e6;
                          }
                          .btn-default {
                            background-image: linear-gradient(to bottom,#2e892fab,rgb(12 68 89));
                               border-color: #000000;
                               color: #fff;}
                          .btn:not(:disabled):not(.disabled):active, .btn:not(:disabled):not(.disabled).active {
                          background-color: #000000;
                          }
                          .bootstrap-select .dropdown-menu li.active small {
                          color: #000!important;
                          }
                          .text-muted {
                          color: #000 !important;
                          }
                          
                          .highcharts-data-table table {
                            font-family: Verdana, sans-serif;
                            border-collapse: collapse;
                            border: 1px solid #ebebeb;
                            margin: 10px auto;
                            text-align: center;
                            width: 100%;
                            max-width: 500px;
                          }
                          
                          .highcharts-data-table caption {
                            padding: 1em 0;
                            font-size: .2em;
                            color: #555;
                          }
                          
                          .highcharts-data-table th {
                            font-weight: 600;
                            padding: 0.5em;
                          }
                          
                          .highcharts-data-table td,
                          .highcharts-data-table th,
                          .highcharts-data-table caption {
                            padding: 0.5em;
                          }
                          
                          .highcharts-data-table thead tr,
                          .highcharts-data-table tr:nth-child(even) {
                            background: #f8f8f8;
                          }
                          
                          .highcharts-data-table tr:hover {
                            background: #f1f7ff;
                          }
                          "
                                 )),
                                 # CSS ----
                                
                          # BODY ----
                          column(width = 12, align = 'left',
                                 tags$img(
                                   src = "logo-conecta-campinas2.svg",
                                           width = "200px")
                                 ),
                          column(width = 12,align = 'right',
                                 actionButton(inputId='ab1',
                                              label="App Modernização", 
                                              icon = icon("th"), 
                                              onclick ="location.href='https://hkbragada.shinyapps.io/modernizacao_conecta';")
                          
                                 ),
                          column(width = 12,  align="center",
                                 
                                 dateInput(inputId = "filtro",
                                           label = h6(HTML("<i class='glyphicon glyphicon-calendar'></i>  Selecione uma Data para gerar o RDO"),style= 'color: white;'),
                                           min = "2023-03-01",
                                           max = Sys.Date(),
                                           language = "pt-BR",
                                           value = Sys.Date(),
                                           format = "dd/mm/yyyy"
                                           
                                 ),
                                 tags$hr()
                          ),
                          
                          column(width = 9,
                                 
                                 fluidRow(
                                   bs4ValueBoxOutput(outputId = "c_total_equipes",width =2),
                                   column(3,
                                          bs4ValueBoxOutput(outputId = "c_at_valor",width = 12),
                                          bs4ValueBoxOutput(outputId = "c_solic",width = 12)
                                          
                                   ),
                                   bs4ValueBoxOutput(outputId = "c_at",width = 7),

                                 
                                   column(12,
                                          bs4Card(id = "at_so2",width = 12,elevation = 4,maximizable = T,status = "primary",
                                                  title = "Despachos a Serem Realizados, Atendimentos Realizados e Ocorrências Pendentes",
                                                  solidHeader = T,collapsed = F,headerBorder = F,
                                                  radioGroupButtons(
                                                    inputId = "c_view",
                                                    label = "", 
                                                    choices = c("Atendimentos Pendentes",
                                                                "Rondas Pendentes",
                                                                "Atendimentos Realizados",
                                                                "Ocorrências Pendentes"),
                                                    justified = T,
                                                    selected = "Atendimentos Pendentes",
                                                    width = "100%",
                                                    checkIcon = list(yes = icon("ok",lib = "glyphicon"))
                                                  ),
                                                  uiOutput("p_map_tab")
                                          )
                                          
                                   ),
                                   column(12,
                                          bs4Card(id = "at_so",width = 12,elevation = 4,maximizable = T,status = "primary",
                                                  title = paste("Status dos Despachos","(", format(Sys.time(), "%Y-%m-%d %X"),")"),
                                                  solidHeader = T,collapsed = F,headerBorder = F,
                                                  #csvDownloadButton("status_os", filename = "status_os.csv"),
                                                  uiOutput("status_os")
                                          )
                                          
                                   ),
                                   column(width = 6,bs4ValueBoxOutput(outputId = "status_os_hist",width = 12)),
                                   column(width = 6,align = "center",
                                                 dateRangeInput(inputId = 'daterange',
                                                                label = 'Selecione o Período',
                                                                start = Sys.Date()-1,
                                                                end = Sys.Date(),
                                                                min = Sys.Date()-30,
                                                                max = Sys.Date(),
                                                                language = "pt-BR",
                                                                separator = " até "
                                                 ),
                                                 uiOutput("c_hist_os_equipe",width =12)
                                          ),
                                   bs4ValueBoxOutput(outputId = "c_at_equipe",width = 6),
                                   bs4ValueBoxOutput(outputId = "c_avulso_equipe",width = 6),
                                   bs4ValueBoxOutput(outputId = "c_bairros",width = 6)
                                   
                                   )
                                 ),
                                   column(3,
                                          bs4ValueBoxOutput(outputId = "c_oc_atrasadas",width =12),
                                          bs4ValueBoxOutput("c_historico",width =12),
                                          bs4ValueBoxOutput("c_autorizar",width =12),
                                          bs4ValueBoxOutput("c_oc_og",width =12),
                                          bs4ValueBoxOutput("c_oc_tipo",width =12)
                                          #bs4ValueBoxOutput("c_modernizacao",width =12)
                                          
                                          
                                   )
                                   

                          # ----
                               ))
                     )
  ),
  
  footer =  dashboardFooter()
)




server <- function(input, output, session) {
  #waiter_hide()
  
    
    #shinyjs::runjs("document.body.style.zoom = '70%';")

  
  # ACESSO ----
  Sys.setenv("AWS_ACCESS_KEY_ID" = "#######################",
             "AWS_SECRET_ACCESS_KEY" = "####################",
             "AWS_DEFAULT_REGION" ="sa-east-1",
             TZ="America/Sao_Paulo")
  shinyjs::runjs(
    "function reload_page() {
  window.location.reload();
  setTimeout(reload_page, 3000000);
 }
 setTimeout(reload_page, 3000000);
 ")
  # -----
  
  # CARDS
  hc_theme_sparkline_vb <- function(...) {
    
    theme <- list(
      chart = list(
        backgroundColor = NULL,
        margins = c(0, 0, 0, 0),
        spacingTop = 0,
        spacingRight = 0,
        spacingBottom = 0,
        spacingLeft = 0,
        plotBorderWidth = 0,
        borderWidth = 0,
        style = list(overflow = "visible")
      ),
      xAxis = list(
        visible = FALSE, 
        endOnTick = FALSE, 
        startOnTick = FALSE
      ),
      yAxis = list(
        visible = FALSE,
        endOnTick = FALSE, 
        startOnTick = FALSE
        
      ),
      tooltip = list(
        botderWidth = 0,
        useHTML  =TRUE,
        table=T,
        #backgroundColor = "#ffffff",
        headerFormat = "<b>{point.key}</b><br>" ,
        pointFormat = '<b>Total </b>: <b> {point.y} ({point.p}%)</b></td>',
        style = list(textOutline = "0px white",
                     fontSize = "15px",
                     fontWeight= 'bold')
      ),
      plotOptions = list(
        series = list(
          marker = list(enabled = FALSE),
          lineWidth = 2,
          shadow = FALSE,
          fillOpacity = 0.25,
          color = "#ffffff",
          fillColor = list(
            linearGradient = list(x1 = 0, y1 = 1, x2 = 0, y2 = 0),
            stops = list(
              list(0.00, "#FFFFFF00"),
              list(0.50, "#FFFFFF7F"),
              list(1.00, "#FFFFFFFF")
            )
          )
        )
      ),
      credits = list(
        enabled = FALSE,
        text = ""
      )
    )
    
    theme <- structure(theme, class = "hc_theme")
    
    if (length(list(...)) > 0) {
      theme <- hc_theme_merge(
        theme,
        hc_theme(...)
      )
    }
    
    theme
  }  
 

  # DADOS ----
  atendimentos <- reactive({
    s3read_using(
      FUN = fst::read_fst,
      object = "atendimentos.fst",
      bucket = "automacao-conecta"
    )
    
  })
  solicitacoes <- reactive({
    s3read_using(
      FUN = fst::read_fst,
      object = "solicitacoes.fst",
      bucket = "automacao-conecta"
    ) 
  })
  p_moni <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "painel_monitoramento.fst",
                 bucket = "automacao-conecta"
    ) 
  })
  p_oc <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "painel_ocorrencias.fst",
                 bucket = "automacao-conecta"
    )
  })
  prazo <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "sgi_atendimento_atendimentos_prazo.fst",
                 bucket = "automacao-conecta"
    ) 
  })
  materiais_aplicados <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "materiais_aplicados.fst",
                 bucket = "automacao-conecta"
    ) 
  }) 
  dados_materias <- reactive({
    
    materiais_aplicados() %>% 
      left_join(relacoes %>% select(-descricao),by = c("codigo")) %>% 
      mutate(quantidade = as.numeric(quantidade),
             gasto_total = abs(quantidade*valor_unitario)) %>% 
      rename("n_atendimento"="atendimento")
  })
  ocorrencias_atrasadas <- reactive({
    
    p_moni() %>% 
      filter(atrasado == "Atrasada") %>% 
      select(protocolo,data_reclamacao,data_limite_atendimento,dias_prazo,atrasado,tipo_de_ocorrencia,bairro,lat,lon,endereco) %>% 
      rbind(
        p_oc() %>% 
          filter(atrasado == "Atrasada") %>% 
          select(protocolo,data_reclamacao,data_limite_atendimento,dias_prazo,atrasado,tipo_de_ocorrencia,bairro,lat,lon,endereco) 
      )  
  }) 
  atendimentos_avulsos <- reactive({
    
    prazo() %>% 
      filter(data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() },
             status == "Avulso") %>%
      select(no_atendimento = atendimento) %>% 
      left_join(atendimentos() %>% 
                  filter(data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }) %>% 
                  select(no_atendimento,equipe,lat,lon,nome_bairro,endereco),
                by = c("no_atendimento")) %>% 
      select("Nº: Atendimento" = no_atendimento,"Equipe" = equipe,lat,lon,"Bairro" = nome_bairro, "Endereço" = endereco) 
    
  }) 
  at_fora_escopo <- reactive({
    
    p_oc() %>%
      mutate( data_limite_para_atendimento = limite_atendimento,
              #recebida =  as.POSIXct(strptime(recebida,"%d/%m/%Y %H:%M")),
              data_limite =as.POSIXct(strptime(limite_atendimento,"%d/%m/%Y %H:%M")),
              dif = as.numeric(round(difftime(data_limite, as.POSIXct(Sys.time(),"GMT"),units = "hours"),0))) %>% 
      filter(tipo_de_ocorrencia %in%  c("Troca de PotC*ncia",
                                        "Necessário Poda de Árvore",
                                        "Instalar braço/luminária"
      )) %>% 
      select(Protocolo = protocolo,
             "Tipo de Ocorrência"=tipo_de_ocorrencia,
             Atrasado = atrasado,Prazo = dias_prazo,
             "Data da Reclamação" = data_reclamacao,
             "Data Limite" =data_limite_atendimento,
             "Endereço" = endereco,
             dif,data_limite) %>% 
      rbind(
        p_moni() %>% 
          mutate( data_limite =as.POSIXct(strptime(data_limite_para_atendimento,"%d/%m/%Y %H:%M")),
                  dif = as.numeric(round(difftime(data_limite, as.POSIXct(Sys.time(),"GMT"),units = "hours"),0))) %>% 
          filter(tipo_de_ocorrencia %in%  c("Troca de PotC*ncia",
                                            "Necessário Poda de Árvore",
                                            "Instalar braço/luminária")) %>% 
          select(Protocolo = protocolo,
                 "Tipo de Ocorrência"=tipo_de_ocorrencia,
                 Atrasado = atrasado,
                 Prazo = dias_prazo,
                 "Data da Reclamação" = data_reclamacao,
                 "Data Limite" =data_limite_atendimento,
                 "Endereço" = endereco,
                 dif,data_limite))
  }) 
  os <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "ordens_servico.fst",
                 bucket = "automacao-conecta"
    ) 
  })
  ocorrencias_aturorizar <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "ocorrencias_autorizar.fst",
                 bucket = "automacao-conecta"
    ) 
  })
  
  mod_materiais <- reactive({
    s3read_using(FUN = fst::read_fst,
                 object = "mod_materiais.fst",
                 bucket = "automacao-conecta"
    ) 
  })
  #----    
  
  # CARDS ----
  
  # EQUIPES
  output$c_total_equipes <- renderbs4ValueBox({
    
    bs4ValueBox(color = "primary",
                value = tags$p(style = "font-size: 35px;font-weight: lighter;text-align: center;",
                               "Equipes",HTML("<br>"),
                              # os() %>% 
                              #   filter(data >= paste0(Sys.Date()," 06:00:00")) %>% distinct(equipe) %>% nrow()),
                               atendimentos() %>%
                                 filter(
                                   atendimento != "MOD - Modernizado",
                                   data_hora == if(input$filtro == Sys.Date()){
                                     if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                                   } else {
                                     input$filtro
                                   }
                                   #data_hora ==if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){print(Sys.Date()-1)} else{print(Sys.Date())}
                                 ) %>%
                                 select(equipe) %>% 
                                 distinct() %>% 
                                 nrow()),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                    tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;",
                          info(texto = paste("Total de Equipes em campo em",input$filtro)),
                          pickerInput(inputId = "equip",
                                      label = "Lista das Equipes",
                                      choices =   atendimentos() %>%
                                        filter(
                                          atendimento != "MOD - Modernizado",
                                          data_hora == if(input$filtro == Sys.Date()){
                                            if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                                          } else {
                                            input$filtro
                                          }
                                          #data_hora ==if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){print(Sys.Date()-1)} else{print(Sys.Date())}
                                        ) %>%
                                        select(equipe) %>% 
                                        distinct() ,
                                      multiple = T,
                                      selected =  atendimentos() %>%
                                        filter(
                                          atendimento != "MOD - Modernizado",
                                          data_hora == if(input$filtro == Sys.Date()){
                                            if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                                          } else {
                                            input$filtro
                                          }
                                          #data_hora ==if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){print(Sys.Date()-1)} else{print(Sys.Date())}
                                        ) %>%
                                        select(equipe) %>% 
                                        distinct() %>% 
                                         pull(equipe),
                                      options = list(`actions-box` = T,
                                                     `selected-text-format`= "count",
                                                     `count-selected-text` = "{0}/{1} Equipes"
                                                     ),
                                      width = "100%"
                                        )
                           
                           )
                ,icon = icon('users',lib = "font-awesome")
    )
    
  })
  
  # ATENDIMENTOS 
  at_dia = reactive({
    atendimentos() %>%
      filter(
             #equipe %in% input$equip,
        atendimento != "MOD - Modernizado",
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
             #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
             ) %>% 
      nrow()
  })
  
  atend_prazo = reactive({
    prazo() %>% 
      filter(
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
      ) %>% 
        
        #equipe %in% input$equip,
             #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }) %>% 
      group_by(status) %>% 
      summarise(n = n()) %>% 
      filter(status %in% c("Avulso","Fora do prazo","No Prazo"))%>%
      ungroup() %>%
      mutate(p = n/sum(n),
             p = round(100*p,0))
  }) 
  atend_tipo <- reactive({
    atendimentos() %>% 
      filter(
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #equipe %in% input$equip,
             #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
             ) %>% 
      group_by(atendimento) %>% 
      summarise(n = n()) %>% 
      ungroup() %>% 
      arrange(desc(n))
    
  })
  atend_og <- reactive({
    prazo() %>% 
      filter(
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #equipe %in% input$equip,
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
      ) %>%
      mutate(origem_da_ocorrencia = case_when(
        origem_da_ocorrencia == "Sem origem definida" ~ "Avulso",
        TRUE ~ origem_da_ocorrencia)) %>% 
      summarise(n=n(),.by = origem_da_ocorrencia)
  })
  atend_prev_cor <- reactive({
    prazo() %>% 
      filter(data_hora == if(input$filtro == Sys.Date()){
        if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
      } else {
        input$filtro
      }) %>% 
      mutate(origem_da_ocorrencia = case_when(
        origem_da_ocorrencia %in% c("Ronda própria", "Sem origem definida") ~ "Preventivo",
        origem_da_ocorrencia %!in% c("Ronda própria", "Sem origem definida") ~ "Corretivo"
      )) %>% 
      summarise(n=n(),.by = origem_da_ocorrencia)
  })
  atend_equipe <- reactive({
    atendimentos() %>% 
      filter(
        atendimento != "MOD - Modernizado",
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        ) %>% 
      group_by(equipe,atendimento) %>% 
      summarise(n = n()) %>% 
      mutate(atendimento = factor(atendimento,levels = c("Impossibilidade","Encontrado normal","Atendido","Fora do escopo do contrato","Atendimento relacionado","Vistoria"))) %>% 
      complete(atendimento)  %>% 
      ungroup() %>% 
      group_by(equipe) %>%
      mutate(total = sum(n,na.rm = T)) %>% 
      ungroup() %>% 
      arrange(desc(total))
  })
  prazo_equipe <- reactive({
    prazo() %>% 
      filter(
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
      ) %>% 
      group_by(equipe,status) %>% 
      summarise(n = n()) %>% 
      filter(status %in% c("Avulso","Fora do prazo","No Prazo"))%>%
      mutate(status = factor(status,levels = c("Avulso","No Prazo","Fora do prazo"))) %>% 
      complete(status)  %>% 
      ungroup() %>% 
      group_by(equipe) %>%
      mutate(total = sum(n,na.rm = T)) %>% 
      ungroup() %>% 
      arrange(desc(total))  
  })
  media_equipe = reactive({
    atendimentos() %>% 
      filter( 
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        ) %>% 
      group_by(equipe) %>% 
      summarise(n = n()) %>% 
      summarise(media = mean(n)) %>% pull(media)
  }) 
  atend_bairros <- reactive({
    atendimentos() %>% 
      group_by(nome_bairro) %>%
      summarise(n= n()) %>% 
      arrange(desc(n)) %>% 
      slice(1:10) %>% 
      replace_na(replace = list(nome_bairro="Sem Nome")) %>% 
      mutate(p = round(100*(n/sum(n)),1) )
  })
  mod_equipe <- reactive({
    atendimentos() %>% 
      filter(
        atendimento == "MOD - Modernizado",
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
      ) %>% 
      group_by(equipe) %>% 
      summarise(n = n()) %>% 
      arrange(desc(n))
  })

  
  output$c_at <- renderbs4ValueBox({
    
    
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;"
                              
                               #HTML("<h1 style='font-size: 70px;display:inline;'>" ,at_dia(),"</h1>"),
                               #HTML("<h3 style='display:inline;font-weight: lighter;'> Atendimentos</h3>")
                               #info(texto = paste("Total de SolicataC'C5es recebidas em",Sys.Date()))
                               
                               
                               
                              
                           
                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;",
                         #info(texto = paste("Total de Atendimentos realizados em",Sys.Date())),
                        
                         fluidRow(
                           column(3,
                         highchart() %>%  
                           hc_yAxis(title = list(text = " ",
                                                  style = list(fontSize = '13px',
                                                               fontWeight= 'bold')),
                                     labels = list(style = list(fontSize = '11px',
                                                                fontWeight= 'bold')),
                                     gridLineWidth =  0) %>% 
                           hc_xAxis(title = list(text = " "),
                                    labels = list(rotation = -0,
                                                  style = list(fontSize = '17px',
                                                               color = "black",
                                                               fontWeight= 'bold')),
                                    categories = list(format(input$filtro,"%d/%m/%Y"))
                           ) |>
                           hc_add_dependency("plugins/grouped-categories.js") %>%
                           hc_add_series(data = atend_tipo() %>% 
                                           filter(atendimento == "Atendido") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Efetivos",
                                         color = list(
                                           linearGradient= c( list(x1=0), list(x2=0), list(y1=0), list(y2=1)),
                                           stops= list(
                                             c(0, '#26a5bf'),
                                             c(0.5,"#00586e"),
                                             c(1, "#064354")
                                           )
                                         )) %>% 
                           hc_add_series(data = atend_tipo() %>% 
                                           filter(atendimento == "Impossibilidade") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Impossibilitados",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#bb0606'),
                                             c(0.5,"#750f0f"),
                                             c(1, "#3d1010")
                                           )
                                         ))  %>% 
                           hc_add_series(data = atend_tipo() %>% filter(atendimento == "Encontrado normal") %>%  pull(n),
                                         type="bar",
                                         name = "Encontrado Normal",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#dda33b'),
                                             c(0.5,"#be892a"),
                                             c(1, "#bf7b01")
                                           )
                                         ))  %>% 
                           hc_add_series(data = atend_tipo() %>% filter(atendimento == "Atendimento relacionado") %>%  pull(n),
                                         type="bar",
                                         name = "Relacionado",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#34b030'),
                                             c(0.5,"#098305"),
                                             c(1, "#043d02")
                                           )
                                         )) %>% 
                           hc_add_series(data = atend_tipo() %>% filter(atendimento == "Fora do escopo do contrato") %>%  pull(n),
                                         type="bar",
                                         name = "Fora do Escopo",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#e06208'),
                                             c(0.5,"#9d4506"),
                                             c(1, "#6c3005")
                                           )
                                         )) %>%
                           hc_add_series(data = atend_tipo() %>% filter(atendimento == "MOD - Modernizado") %>%  pull(n),
                                         type="bar",
                                         name = "Modernizado",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#0edee6'),
                                             c(0.5,"#09797d"),
                                             c(1, "#146e59")
                                           )
                                         )) %>% 
                           hc_add_series(data = atend_tipo() %>% filter(atendimento == "Vistoria") %>%  pull(n),
                                         type="bar",
                                         name = "Vistoria",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#940ced'),
                                             c(0.5,"#6c209e"),
                                             c(1, "#3b0d59")
                                           )
                                         )) %>% 
                           hc_plotOptions(bar = list(
                             dataLabels = list(
                               enabled = TRUE,
                               color = 'white',
                               format = '{point.y} {series.name}',
                               #shape = NULL,
                               style = list(textOutline = NULL,
                                            fontSize = '12px'))),
                             series = list(
                               #pointWidth=25,
                               
                               pointPadding= 0,
                               groupPadding =0,
                               lineWidth = 1,
                               borderWidth = 1,
                               borderColor = "white",
                               dataLabels = list(enabled = TRUE,
                                                 color = "white")
                             )
                           ) %>% 
                           hc_legend(enabled = F,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                           hc_tooltip(table = T,useHTML  =TRUE,
                                      headerFormat= "<span style='font-size:13px;'><b> Tipo de Atendimento </b></span><br>",
                                      pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y} </b> </span><br>",
                                      #xDateFormat =  '%Y-%m-%d',
                                      
                                      style = list(fontSize = '14px')
                                      #backgroundColor = "#ffffff",
                                      #borderColor= '#000000'
                           ) %>% 
                           hc_title(text = "Status dos Atendimentos",style = list(color = "white",fontSize = '22px')) %>% 
                           hc_size(height = 250) %>%   
                           hc_add_theme(hc_theme_sparkline_vb()) %>% 
                           hc_credits(enabled = FALSE) %>% 
                           hc_boost(enabled = TRUE)
                         ),
                         
                         column(3,
                         highchart() %>%  
                           hc_yAxis( title = list(text = " ",
                                                  style = list(fontSize = '13px',
                                                               fontWeight= 'bold')),
                                     labels = list(style = list(fontSize = '11px',
                                                                fontWeight= 'bold')),
                                     gridLineWidth =  0) %>% 
                           hc_xAxis(title = list(text = " "),
                                    labels = list(rotation = -0,
                                                  style = list(fontSize = '17px',
                                                               color = "black",
                                                               fontWeight= 'bold')),
                                    categories = list(
                                      format(input$filtro,"%d/%m/%Y"))
                           ) |>
                           hc_add_dependency("plugins/grouped-categories.js") %>%
                           hc_add_series(data = atend_prazo() %>%
                                           filter(status == "No Prazo") %>%
                                           pull(n),
                                         type="column",
                                         name = "No Prazo",
                                         color = list(
                                           linearGradient= c( list(x1=0), list(x2=0), list(y1=0), list(y2=1)),
                                           stops= list(
                                             c(0, '#26a5bf'),
                                             c(0.5,"#00586e"),
                                             c(1, "#064354")
                                           )
                                         )) %>% 
                           hc_add_series(data = atend_prazo() %>% 
                                           filter(status == "Avulso") %>%
                                           pull(n),
                                         type="column",
                                         name = "Avulsos",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#dda33b'),
                                             c(0.5,"#be892a"),
                                             c(1, "#bf7b01")
                                           )
                                         )) %>% 
                           hc_add_series(data = atend_prazo() %>%
                                           filter(status == "Fora do prazo") %>%
                                           pull(n),
                                         type="column",
                                         name = "Fora do Prazo",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#bb0606'),
                                             c(0.5,"#750f0f"),
                                             c(1, "#3d1010")
                                           )
                                         ))  %>% 
                           hc_plotOptions(column = list(
                             dataLabels = list(
                               enabled = TRUE,
                               color = 'white',
                               format = '{point.y} {series.name}',
                               #shape = NULL,
                               style = list(textOutline = NULL,
                                            fontSize = '12px'))),
                             series = list(
                               groupPadding= 0,
                               pointPadding= 0,
                               lineWidth = 1,
                               borderWidth = 1,
                               borderColor = "white",
                               dataLabels = list(enabled = TRUE,
                                                 color = "white")
                             )
                           ) %>% 
                           hc_legend(enabled=F,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                           hc_tooltip(table = T,useHTML  =TRUE,
                                      headerFormat= "<span style='font-size:13px;'><b> Prazo dos Atendimentos </b></span><br>",
                                      pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y} </b> </span><br>",
                                      #xDateFormat =  '%Y-%m-%d',
                                      
                                      style = list(fontSize = '14px')
                                      #backgroundColor = "#ffffff",
                                      #borderColor= '#000000'
                           ) %>% 
                           hc_title(text = "Prazo dos Atendimentos",style = list(color = "white",fontSize = '22px')) %>% 
                           hc_size(height = 250) %>%   
                           hc_add_theme(hc_theme_sparkline_vb()) %>% 
                           hc_credits(enabled = FALSE) %>% 
                           hc_boost(enabled = TRUE)
                         ),
                         column(3,
                                highchart() %>%  
                                  hc_yAxis( title = list(text = " ",
                                                         style = list(fontSize = '13px',
                                                                      fontWeight= 'bold')),
                                            labels = list(style = list(fontSize = '11px',
                                                                       fontWeight= 'bold')),
                                            gridLineWidth =  0) %>% 
                                  hc_xAxis(title = list(text = " "),
                                           labels = list(rotation = -0,
                                                         style = list(fontSize = '17px',
                                                                      color = "black",
                                                                      fontWeight= 'bold')),
                                           categories = list(
                                             format(input$filtro,"%d/%m/%Y"))
                                  ) |>
                                  hc_add_dependency("plugins/grouped-categories.js") %>%
                                  hc_add_series(data = atend_og() %>%
                                                  filter(origem_da_ocorrencia  == "Call Center") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "Call Center",
                                                color = list(
                                                  linearGradient= c( list(x1=0), list(x2=0), list(y1=0), list(y2=1)),
                                                  stops= list(
                                                    c(0, '#26a5bf'),
                                                    c(0.5,"#00586e"),
                                                    c(1, "#064354")
                                                  )
                                                )) %>% 
                                  hc_add_series(data = atend_og() %>% 
                                                  filter(origem_da_ocorrencia == "Avulso") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "Avulsos",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#dda33b'),
                                                    c(0.5,"#be892a"),
                                                    c(1, "#bf7b01")
                                                  )
                                                )) %>% 
                                  hc_add_series(data = atend_og() %>%
                                                  filter(origem_da_ocorrencia == "Ronda prC3pria") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "Ronda",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#34b030'),
                                                    c(0.5,"#098305"),
                                                    c(1, "#043d02")
                                                  )
                                                ))  %>% 
                                  hc_add_series(data = atend_og() %>%
                                                  filter(origem_da_ocorrencia == "Prefeitura") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "Prefeitura",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#7c3202'),
                                                    c(0.5,"#6a2a02"),
                                                    c(1, "#3e1901")
                                                  )
                                                )) %>% 
                                  hc_add_series(data = atend_og() %>%
                                                  filter(origem_da_ocorrencia == "App") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "App",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#02a890'),
                                                    c(0.5,"#016e5e"),
                                                    c(1, "#01463c")
                                                  )
                                                )) %>% 
                                  hc_add_series(data = atend_og() %>%
                                                  filter(origem_da_ocorrencia == "Internet") %>%
                                                  pull(n),
                                                type="bar",
                                                name = "Internet",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#03a148'),
                                                    c(0.5,"#037535"),
                                                    c(1, "#01461f")
                                                  )
                                                )) %>% 
                                  hc_plotOptions(bar = list(
                                    dataLabels = list(
                                      enabled = TRUE,
                                      color = 'white',
                                      format = '{point.y} {series.name}',
                                      #shape = NULL,
                                      style = list(textOutline = NULL,
                                                   fontSize = '12px'))),
                                    series = list(
                                      groupPadding= 0,
                                      pointPadding= 0,
                                      lineWidth = 1,
                                      borderWidth = 1,
                                      borderColor = "white",
                                      dataLabels = list(enabled = TRUE,
                                                        color = "white")
                                    )
                                  ) %>% 
                                  hc_legend(enabled=F,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                                  hc_tooltip(table = T,useHTML  =TRUE,
                                             headerFormat= "<span style='font-size:13px;'><b> Prazo dos Atendimentos </b></span><br>",
                                             pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y} </b> </span><br>",
                                             #xDateFormat =  '%Y-%m-%d',
                                             
                                             style = list(fontSize = '14px')
                                             #backgroundColor = "#ffffff",
                                             #borderColor= '#000000'
                                  ) %>% 
                                  hc_title(text = "Origem dos Atendimentos",style = list(color = "white",fontSize = '22px')) %>% 
                                  hc_size(height = 250) %>%   
                                  hc_add_theme(hc_theme_sparkline_vb()) %>% 
                                  hc_credits(enabled = FALSE) %>% 
                                  hc_boost(enabled = TRUE)
                                ),
                         column(3,
                                highchart() %>%  
                                  hc_yAxis( title = list(text = " ",
                                                         style = list(fontSize = '13px',
                                                                      fontWeight= 'bold')),
                                            labels = list(style = list(fontSize = '11px',
                                                                       fontWeight= 'bold')),
                                            gridLineWidth =  0) %>% 
                                  hc_xAxis(title = list(text = " "),
                                           labels = list(rotation = -0,
                                                         style = list(fontSize = '17px',
                                                                      color = "black",
                                                                      fontWeight= 'bold')),
                                           categories = list(
                                             format(input$filtro,"%d/%m/%Y"))
                                  ) |>
                                  hc_add_dependency("plugins/grouped-categories.js") %>%
                                  hc_add_series(data = atend_prev_cor() %>%
                                                  filter(origem_da_ocorrencia  == "Preventivo") %>%
                                                  pull(n),
                                                type="column",
                                                name = "Preventivo",
                                                color = list(
                                                  linearGradient= c( list(x1=0), list(x2=0), list(y1=0), list(y2=1)),
                                                  stops= list(
                                                    c(0, '#26a5bf'),
                                                    c(0.5,"#00586e"),
                                                    c(1, "#064354")
                                                  )
                                                )) %>% 
                                  hc_add_series(data = atend_prev_cor() %>% 
                                                  filter(origem_da_ocorrencia == "Corretivo") %>%
                                                  pull(n),
                                                type="column",
                                                name = "Corretivo",
                                                color = list(
                                                  linearGradient= c( list(x1=0),
                                                                     list(x2=0),
                                                                     list(y1=0),
                                                                     list(y2=1)),
                                                  stops= list(
                                                    c(0, '#dda33b'),
                                                    c(0.5,"#be892a"),
                                                    c(1, "#bf7b01")
                                                  )
                                                )) %>% 
                                  hc_plotOptions(column = list(
                                    dataLabels = list(
                                      enabled = TRUE,
                                      color = 'white',
                                      format = '{point.y} {series.name}',
                                      #shape = NULL,
                                      style = list(textOutline = NULL,
                                                   fontSize = '12px'))),
                                    series = list(
                                      groupPadding= 0,
                                      pointPadding= 0,
                                      lineWidth = 1,
                                      borderWidth = 1,
                                      borderColor = "white",
                                      dataLabels = list(enabled = TRUE,
                                                        color = "white")
                                    )
                                  ) %>% 
                                  hc_legend(enabled=F,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                                  hc_tooltip(table = T,useHTML  =TRUE,
                                             headerFormat= "<span style='font-size:13px;'><b> Tipo de Atendimento </b></span><br>",
                                             pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y} </b> </span><br>",
                                             #xDateFormat =  '%Y-%m-%d',
                                             
                                             style = list(fontSize = '14px')
                                             #backgroundColor = "#ffffff",
                                             #borderColor= '#000000'
                                  ) %>% 
                                  hc_title(text = "Tipo de Atendimento",style = list(color = "white",fontSize = '22px')) %>% 
                                  hc_size(height = 250) %>%   
                                  hc_add_theme(hc_theme_sparkline_vb()) %>% 
                                  hc_credits(enabled = FALSE) %>% 
                                  hc_boost(enabled = TRUE)
                         )
                         
                         )
                         
                         
                       
                  )
                
                
    )
    
  })
  output$c_at_valor <- renderbs4ValueBox({
    
    
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;",
                               
                               HTML("<h1 style='font-size: 55px;display:inline;'>" ,at_dia(),"</h1>"),
                               HTML("<h3 style='font-size: 30px;display:inline;font-weight: lighter;'> Atendimentos</h3>")

                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  
               
                    tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;",
                           )
                 
                ,icon = icon('ok',lib = "glyphicon")
                
    )
    
  })
  output$c_at_equipe <- renderbs4ValueBox({
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;"
               
                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;",
                         highchart() %>%  
                           hc_yAxis(title = list(text = " ",
                                                 style = list(fontSize = '13px',
                                                              fontWeight= 'bold')),
                                    labels = list(style = list(fontSize = '11px',
                                                               fontWeight= 'bold')),
                                    gridLineWidth =  0,
                                    plotLines = list(
                                      list(
                                        value = media_equipe(),
                                        label = list(text = "Média",
                                                     align = "right",
                                                     
                                                     fontColor = "white",
                                                     rotation = 0),
                                        color = "white",
                                        dashStyle = "dash",
                                        width = 1)),
                                    stackLabels= list(
                                      enabled= TRUE,
                                      style = list(
                                        textOutline= 'none',
                                        color = "white",
                                        fontSize = "14px"
                                      )

                                    )
                           ) %>% 
                           hc_xAxis(title = list(text = " "),
                                    labels = list(rotation = -0,
                                                  style = list(fontSize = '13px',
                                                               color = "white",
                                                               fontWeight= 'bold')),
                                    categories =  if(length(unique(atend_equipe()$equipe)) == 1)
                                      list(unique(atend_equipe()$equipe)) else
                                        unique(atend_equipe()$equipe),
                                    labels = list(style = list(fontSize = "13px"))
                           ) |>
                           hc_add_dependency("plugins/grouped-categories.js") %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Fora do escopo do contrato") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Fora do Escopo",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#e06208'),
                                             c(0.5,"#9d4506"),
                                             c(1, "#6c3005")
                                           )
                                         )
                           ) %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Vistoria") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Vistoria",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#940ced'),
                                             c(0.5,"#6c209e"),
                                             c(1, "#3b0d59")
                                           )
                                         )
                           ) %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Atendimento relacionado") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Relacionado",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#34b030'),
                                             c(0.5,"#098305"),
                                             c(1, "#043d02")
                                           )
                                         )
                           ) %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Encontrado normal") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Encontrado Normal",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#d4ca0b'),
                                             c(0.5,"#b29b00"),
                                             c(1, "#736404")
                                           )
                                         )) %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Impossibilidade") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Impossibilitados",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#bb0606'),
                                             c(0.5,"#750f0f"),
                                             c(1, "#3d1010")
                                           )
                                         )) %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Atendido") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Efetivos",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#26a5bf'),
                                             c(0.5,"#00586e"),
                                             c(1, "#064354")
                                           )
                                         ))%>% 
                           hc_legend(enabled = T,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                           hc_plotOptions(
                             bar = list(stacking= "normal",
                                        dataLabels = list(
                                          enabled = TRUE,
                                          color = 'white',
                                          format = '{point.y} ',
                                          shadow= F,
                                          shape = NULL,
                                          style = list(textOutline= 'none',
                                                       fontSize = '13px'))
                             ),
                             series = list(
                               dataSorting= list(
                                 enabled= T,
                                 sortKey= 'n'
                               ),
                               pointPadding= 0,
                               groupPadding =0.2,
                               lineWidth = 1,
                               shadow= F,
                               borderWidth = 1,
                               borderColor = "white",
                               dataLabels = list(enabled = TRUE,
                                                 textOutline= 'none',
                                                 color = "white"))
                           ) %>% 
                           hc_title( text = "Atendimentos por Equipe",
                                     style = list(color = "white",
                                                  useHTML = TRUE,
                                                  fontSize = '18px',
                                                  fontWeight= 'bold')) %>% 
                           hc_tooltip(table = T,
                                      useHTML  =TRUE,
                                      headerFormat= "<span style='font-size:17px;'><b>{point.key} </b></span><br>",
                                      pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y}  </b> </span><br>",
                                      #xDateFormat =  '%Y-%m-%d',
                                      
                                      style = list(fontSize = '14px')
                                      #backgroundColor = "#ffffff",
                                      #borderColor= '#000000'
                           ) %>% 
                           hc_size(height = 850)  %>% 
                           hc_boost(enabled = TRUE)
                         )
                )
  })
  output$c_avulso_equipe <- renderbs4ValueBox({
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;"
                               
                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;",
                         highchart() %>%  
                           hc_yAxis(title = list(text = " ",
                                                 style = list(fontSize = '13px',
                                                              fontWeight= 'bold')),
                                    labels = list(style = list(fontSize = '11px',
                                                               fontWeight= 'bold')),
                                    gridLineWidth =  0
                             
                           ) %>% 
                           hc_xAxis(title = list(text = " "),
                                    labels = list(rotation = -0,
                                                  style = list(fontSize = '13px',
                                                               color = "white",
                                                               fontWeight= 'bold')),
                                    categories =  if(length(unique(atend_equipe()$equipe)) == 1)
                                      list(unique(atend_equipe()$equipe)) else
                                        unique(atend_equipe()$equipe),
                                    labels = list(style = list(fontSize = "13px"))
                           ) |>
                           hc_add_dependency("plugins/grouped-categories.js") %>%
                           hc_add_series(data = atend_equipe() %>% 
                                           filter(atendimento == "Atendido") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Atendimentos Efetivos",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#26a5bf'),
                                             c(0.5,"#00586e"),
                                             c(1, "#064354")
                                           )
                                         ))%>% 
                           hc_add_series(data = prazo_equipe() %>% 
                                           drop_na(equipe) %>% 
                                           filter(status == "Avulso") %>%
                                           pull(n),
                                         type="bar",
                                         name = "Atendimentos Avulsos",
                                         color = list(
                                           linearGradient= c( list(x1=0),
                                                              list(x2=0),
                                                              list(y1=0),
                                                              list(y2=1)),
                                           stops= list(
                                             c(0, '#dda33b'),
                                             c(0.5,"#be892a"),
                                             c(1, "#bf7b01")
                                           )
                                         )) %>% 
                           hc_legend(enabled = T,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                           hc_plotOptions(
                             bar = list(
                               #stacking= "normal",
                                        dataLabels = list(
                                          enabled = TRUE,
                                          color = 'white',
                                          format = '{point.y} ',
                                          shadow= F,
                                          shape = NULL,
                                          style = list(textOutline= 'none',
                                                       fontSize = '13px'))
                             ),
                             series = list(
                               dataSorting= list(
                                 enabled= T,
                                 sortKey= 'n'
                               ),
                               lineWidth = 1,
                               pointPadding= 0,
                               groupPadding =0.2,
                               shadow= F,
                               borderWidth = 1,
                               borderColor = "white",
                               dataLabels = list(enabled = TRUE,
                                                 textOutline= 'none',
                                                 color = "white"))
                           ) %>% 
                           hc_title( text = "Atendimentos por Equipe",
                                     style = list(color = "white",
                                                  useHTML = TRUE,
                                                  fontSize = '18px',
                                                  fontWeight= 'bold')) %>% 
                           hc_tooltip(table = T,
                                      useHTML  =TRUE,
                                      headerFormat= "<span style='font-size:17px;'><b>{point.key} </b></span><br>",
                                      pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y}  </b> </span><br>",
                                      #xDateFormat =  '%Y-%m-%d',
                                      
                                      style = list(fontSize = '14px')
                                      #backgroundColor = "#ffffff",
                                      #borderColor= '#000000'
                           )%>% 
                           hc_size(height = 850)  %>% 
                           hc_boost(enabled = TRUE)
                  )
    )
  })
  output$c_bairros <- renderbs4ValueBox({
    
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;"
                               
                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;",
                         hchart(atend_bairros(),
                                "bar",
                                hcaes(x = nome_bairro,y = n,color= highcharter::colorize(n,colors  = c("#26a5bf")
                                                                                        #c("#367096","#f10707")
                                ))) %>% 
                           hc_xAxis(title = list(text = " "),labels = list(rotation = -0,style = list(fontSize = '13px',color = "white",fontWeight= 'bold'))) %>% 
                           hc_yAxis(gridLineWidth =  0,title = list(text = " ",style = list(fontSize = '13px',fontWeight= 'bold')),labels = list(style = list(fontSize = '11px',fontWeight= 'bold'))) %>% 
                           hc_tooltip(table = T,useHTML  =TRUE,
                                      headerFormat= "<span style='font-size:17px;'><b> {point.key} </b></span><br>",
                                      pointFormat= "<span <span style='font-size:15px'><b></b></span><b>N: R${point.n} ({point.p} %)</b> </span><br>",
                                      #xDateFormat =  '%Y-%m-%d',
                                      
                                      style = list(fontSize = '14px')
                                      #backgroundColor = "#ffffff",
                                      #borderColor= '#000000'
                           ) %>% 
                           hc_plotOptions(bar = list(
                             #pointWidth = 35,
                             dataLabels = list(
                               enabled = TRUE,
                               color = 'white',
                               format = '{point.y} ({point.p} %)',
                               shape = NULL,
                               style = list(textOutline = NULL,
                                            fontSize = '13px',
                                            color = "black"))),
                             series = list(lineWidth = 1,borderWidth = 1,borderColor = "white",
                                           dataLabels = list(format = 'R$ {point.y}', fontSize = '17px',enabled = TRUE,color = "black"))) %>% 
                           hc_colors(c("#881126"))%>% 
                           hc_title( text = " Top 10 Bairros",
                                     style = list(color = "white",
                                                  useHTML = TRUE,
                                                  fontSize = '15px',
                                                  fontWeight= 'bold')) %>% 
                           hc_caption(text = paste0("<b> Top 10 Bairros ",
                                                    format(Sys.Date()-1,"%d/%m/%Y"),"
             </b>"),style = list(color = "black")) %>% 
                           hc_boost(enabled = TRUE)
                  )
    )
    
  })

  

  
  # SOLICITACOES
  solic_dia = reactive({
    solicitacoes() %>%
      filter(
        origem_ocorrencia != "Ronda própria",
        data_reclamacao ==  input$filtro 

        #data_reclamacao ==Sys.Date()
        ) %>% 
      nrow()
  })
  output$c_solic <- renderbs4ValueBox({
    
    
    
    bs4ValueBox(color = "primary",
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               HTML("<h1 style='font-size: 55px;display:inline;'>",solic_dia(),"</h1>"),
                               HTML("<h3 style='font-size: 30px;display:inline;font-weight: lighter;'> Solicitações </h3>")
                               #info(texto = paste("Total de SolicataC'C5es recebidas em",Sys.Date()))
                               ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                    tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;"
                           #info(texto = paste("Total de SolicataC'C5es recebidas em",Sys.Date()))
                           )
               , icon = icon('earphone',lib = "glyphicon")
                
    )
    
  })

  # OCORRENCIAS ATRASADAS
  output$c_oc_atrasadas <- renderbs4ValueBox({
    
    valor = reactive(nrow(ocorrencias_atrasadas()))
    
    progresso = reactive(round(100*(valor()/(sum(nrow(p_moni()),nrow(p_oc())))),1))
    
    bs4ValueBox(color = "primary",
                value = tags$p(style = "font-size: 40px;font-weight: lighter;text-align: center;",
                               "Ocorrências",
                               
                               HTML("<h1 style='font-size: 60px;display:inline;text-align:left;'>",
                                    nrow(p_moni())+nrow(p_oc()),"</h1>"),
                               HTML("<h3 style='display:inline;font-weight: lighter;'> Pendentes</h3>"),
                               HTML("<br>"),
                               HTML("<h1 style='font-size: 60px;display:inline;'>",
                                    valor(),"</h1>"),
                               HTML("<h3 style='display:inline;font-weight: lighter;'> Atrasadas</h3>"),
                               HTML("<h3 style='display:inline;font-weight: lighter;'>",paste0("(",progresso(),"%)"),"</h3>")
                               
                               
                               ),
                gradient = T,
                footer = tagList(
                  bs4ProgressBar(
                    value = progresso(),
                    size = "xxs",status = "danger",animated = T,striped = T
                  )),
                subtitle = tags$p(style = "font-size: 25px;font-weight: lighter;text-align: center;"
                                
                ),
                icon = icon('time',lib = "glyphicon")
    )
    
  })
  
  # CARD TABELA
  output$c_historico <- renderbs4ValueBox({
    
    
    meses <- \(mes){
      mes <- month(mes,locale = "pt_BR.utf8")
      ultimos_meses <- (mes - 2):(mes)
      ultimos_meses[ ultimos_meses <= 0 ] <- ultimos_meses[ ultimos_meses <= 0 ] + 12
      
      ultimos_meses <- ultimos_meses %>% 
        month(label = T,abbr = F,locale = "pt_BR.utf8") %>% 
        str_to_title() %>% 
        as.factor() %>% 
        levels() %>% 
        
      
      return(ultimos_meses)
      
    }
  
    
    oc_mes <- reactive({
      prazo() %>% filter(mes == month(Sys.Date(),label = T,abbr = F,locale = "pt_BR.utf8") %>% str_to_title()) %>% 
        nrow()
    })
    oc_atrasadas_mes <- reactive({
      prazo() %>%
        filter(mes == month(Sys.Date(),label = T,abbr = F,locale = "pt_BR.utf8") %>% str_to_title(),
                       status == "Fora do prazo") %>% 
        nrow()
    })
    oc_tri <- reactive({
      prazo() %>% filter(
        data_hora >= "2024-04-01"
       # mes %in% meses(Sys.Date())
        ) %>% 
        nrow()
    })
    oc_atrasadas_tri <- reactive({
      prazo() %>% filter(
        data_hora >= "2024-04-01",
        #mes %in% meses(Sys.Date()),
                       status == "Fora do prazo") %>% 
        nrow()
    })
    
    
    mini_data_oc <- reactive({
      data.frame(
        Ocorrencias = c(month(Sys.Date(),label = T,abbr = F,locale = "pt_BR.utf8") %>% str_to_title(),"Ultimo Trimestre"),
        Atrasadas = c(oc_atrasadas_mes(),oc_atrasadas_tri()),
        Total = c(paste0(round((oc_atrasadas_mes()/oc_mes())*100,1),"%") ,paste0(round((oc_atrasadas_tri()/oc_tri())*100,1),"%"))
      ) 
    }) 
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Histórico de Ocorrências"),
                               hr(),
                               mini_data_oc() %>% 
                                 reactable(
                                   theme =  reactableTheme(
                                     highlightColor = "rgb(24 164 255 / 10%)",
                                     #borderColor = "hsl(0, 0%, 93%)",
                                     headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                   ),
                                   #width = 400,
                                   #theme = nytimes(),
                                   highlight = T,
                                   defaultPageSize = 8,
                                   style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                backgroundColor ="rgb(255 255 255 / 0%)"),
                                   defaultColDef = colDef(align = "left"
                                   ),
                                   bordered = F,
                                   compact = T,borderless = TRUE,
                                   columns = list(
                                     Ocorrencias  = colDef(
                                       align = "left",
                                       name = "Periodo",
                                       minWidth = 120,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     Atrasadas = colDef(
                                       align = "center",
                                       name = "Atrasadas",
                                       minWidth = 110,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     Total = colDef(
                                       align = "center",
                                       name = "%",
                                       minWidth = 110,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     )
                                   )
                                  
                                 )),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )
  
    
  })
  
  output$c_autorizar <- renderbs4ValueBox({
    
    
    oc_autorizar <- reactive({
     ocorrencias_aturorizar() %>%
        filter(data_reclamacao == Sys.Date()) %>% 
        nrow()
    })
    
    oc_at_aturorizar <- reactive({
      atendimentos() %>%
        filter(data_hora == Sys.Date(),
               protocolo %in% c(ocorrencias_aturorizar() %>% pull(protocolo))) %>% 
        distinct(protocolo) %>% 
        nrow()
    })
    
    oc_autorizar_acum <- reactive({
      ocorrencias_aturorizar() %>% nrow()
    })
    
    mini_data_oc <- reactive({
      data.frame(
        Ocorrencias = c("Mapeadas","Atendidas","Acumuladas"),
        Qnt = c(oc_autorizar(),oc_at_aturorizar(),oc_autorizar_acum())
      ) 
    }) 
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Ocorrências À  Autorizar"),
                               hr(),
                               mini_data_oc() %>% 
                                 reactable(
                                   theme =  reactableTheme(
                                     highlightColor = "rgb(24 164 255 / 10%)",
                                     #borderColor = "hsl(0, 0%, 93%)",
                                     headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                   ),
                                   #width = 400,
                                   #theme = nytimes(),
                                   highlight = T,
                                   defaultPageSize = 8,
                                   style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                backgroundColor ="rgb(255 255 255 / 0%)"),
                                   defaultColDef = colDef(align = "left",
                                                          style = list(#fontWeight = "bold",
                                                            color = "white")
                                   ),
                                   bordered = F,
                                   borderless = T,
                                   compact = T,
                                   columns = list(
                                     Ocorrencias  = colDef(
                                       align = "left",
                                       name = "Ocorrências",
                                       minWidth = 120,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     Qnt = colDef(
                                       align = "center",
                                       name = "Quantidade",
                                       minWidth = 110,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     )
                                   )
                                   
                                 )),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )

  })
  
  output$c_oc_og <- renderbs4ValueBox({
    
    oc_og <- reactive({
      oc_pendentes() %>% 
        group_by(
          #"tipo_de_ocorrencia"= input$c_tipo_oc
          origem_ocorrencia
        ) %>% 
        summarise(n = n()) %>% 
        arrange(desc(n)) 
    })
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Origem das Ocorrências"),
                               hr(),
                               oc_og() %>% 
                                 reactable(
                                   theme =  reactableTheme(
                                     highlightColor = "rgb(24 164 255 / 10%)",
                                     #borderColor = "hsl(0, 0%, 93%)",
                                     headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                   ),
                                   #width = 400,
                                   #theme = nytimes(),
                                   highlight = T,
                                   defaultPageSize = 8,
                                   style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                backgroundColor ="rgb(255 255 255 / 0%)"),
                                   defaultColDef = colDef(align = "left",
                                                          style = list(#fontWeight = "bold",
                                                            color = "white")
                                   ),
                                   bordered = F,
                                   compact = T,
                                   columns = list(
                                     origem_ocorrencia  = colDef(
                                       align = "left",
                                       name = "Origem",
                                       minWidth = 120,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     n = colDef(
                                       align = "center",
                                       name = "Quantidade",
                                       minWidth = 110,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     )
                                   ), 
                                   details = function(index){
                                     
                                     dados_intra <- oc_pendentes()[oc_pendentes()$origem_ocorrencia == oc_og()$origem_ocorrencia[index],]
                                     
                                     htmltools::div(style = "padding: 1rem",
                                                    reactable(
                                                      dados_intra %>% 
                                                        select(protocolo,dif) 
                                                      ,
                                                      style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                                   backgroundColor ="rgb(255 255 255 / 0%)"),
                                                      highlight = T,
                                                      compact = T,
                                                      defaultSorted = "dif",
                                                      defaultSortOrder = "asc",
                                                      columns = list(
                                                        dif = colDef(name = "Prazo",
                                                                     style = list(fontSize = ".9rem"),
                                                                     headerStyle = list(fontSize = "1rem",
                                                                                        color = "white"),
                                                                     format = colFormat(suffix = " Horas"),
                                                                     cell =  color_tiles(dados_intra,
                                                                                         bold_text = T,
                                                                                         box_shadow = T,
                                                                                         color_ref  = "cor_vencimento",
                                                                                         number_fmt = scales::number_format(suffix = " Horas")
                                                                                         
                                                                     ))
                                                      )
                                                      
                                                    )
                                     )
                                   }
                                 )),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )
    
    
  })
  
  output$c_oc_tipo <- renderbs4ValueBox({
    
    oc_tipo <- reactive({
      oc_pendentes() %>% 
        group_by(tipo_de_ocorrencia) %>% 
        summarise(n = n()) %>% 
        arrange(desc(n)) 
    })
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Tipos de Ocorrências"),
                               hr(),
                               oc_tipo() %>% 
                                 reactable(
                                   theme =  reactableTheme(
                                     highlightColor = "rgb(24 164 255 / 10%)",
                                     #borderColor = "hsl(0, 0%, 93%)",
                                     headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                   ),
                                   #width = 400,
                                   #theme = nytimes(),
                                   highlight = T,
                                   defaultPageSize = 30,
                                   style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                backgroundColor ="rgb(255 255 255 / 0%)"),
                                   defaultColDef = colDef(align = "left",
                                                          style = list(#fontWeight = "bold",
                                                            color = "white")
                                   ),
                                   bordered = F,
                                   compact = T,
                                   columns = list(
                                     tipo_de_ocorrencia  = colDef(
                                       align = "left",
                                       name = "Ocorrência",
                                       minWidth = 120,
                                       style = list(fontSize = "1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     n = colDef(
                                       align = "center",
                                       name = "Quantidade",
                                       minWidth = 110,
                                       style = list(fontSize = "1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     )
                                   ), 
                                   details = function(index){
                                     
                                     dados_intra <- oc_pendentes()[oc_pendentes()$tipo_de_ocorrencia == oc_tipo()$tipo_de_ocorrencia[index],]
                                     
                                     
                                     
                                     
                                     
                                     htmltools::div(style = "padding: 1rem",
                                                    reactable(
                                                        dados_intra %>% 
                                                          select(protocolo,origem_ocorrencia,dif)
                                                      ,
                                                      style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                                   backgroundColor ="rgb(255 255 255 / 0%)"),
                                                      highlight = T,
                                                      compact = T,
                                                      defaultSorted = "dif",
                                                      defaultSortOrder = "asc",
                                                      columns = list(
                                                        origem_ocorrencia = colDef(name = "Origem",
                                                                                   style = list(fontSize = ".9rem"),
                                                                                   headerStyle = list(fontSize = "1rem",
                                                                                                      #fontWeight = "bold",
                                                                                                      color = "white")),
                                                        dif = colDef(name = "Prazo",
                                                                     style = list(fontSize = ".9rem"),
                                                                     headerStyle = list(fontSize = "1rem",
                                                                                        #fontWeight = "bold",
                                                                                        color = "white"),
                                                                     format = colFormat(suffix = " Horas"),
                                                                     cell =  color_tiles(dados_intra,
                                                                                         bold_text = T,
                                                                                         box_shadow = T,
                                                                                         color_ref  = "cor_vencimento",
                                                                                         number_fmt = scales::number_format(suffix = " Horas")
                                                                                         #colors = RColorBrewer::brewer.pal(5, 'RdBu')
                                                                     ))
                                                      )
                                                      
                                                    )
                                     )
                                   }
                                 )),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )
  })
  
  output$c_modernizacao <- renderbs4ValueBox({
    
    mod_dia <- reactive({
      mod_materiais() %>% 
        filter(data_hora ==  if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }) %>% 
        nrow()
    })
    mod_mes <- reactive({
      mod_materiais() %>% 
        filter(mes == month( if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        },label = T,abbr = F,locale = "pt_BR.utf8") %>% str_to_title()) %>% 
        nrow()
    })

    
    mini_data_mod <- reactive({
      data.frame(
        
        hist = c("Dia",
                 month(
                   if(input$filtro == Sys.Date()){
                     if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                   } else {
                     input$filtro
                   }
                   
                   ,label = T,abbr = F,locale = "pt_BR.utf8") %>% str_to_title()
        ),
        
        mod = c(mod_dia(),
                mod_mes()
        )
      ) 
    }) 
    
    
    
    
    
    data_mod <- reactive({
      mod_materiais() %>% 
        filter(
          #atendimento == "MOD - Modernizado",
          data_hora == if(input$filtro == Sys.Date()){
            if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
          } else {
            input$filtro
          }
          
          #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        ) %>% 
        group_by(equipe) %>% 
        summarise(n = n()) %>% 
        arrange(desc(n))
    })
    
    
    
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Modernização"),
                               hr(),
                               mini_data_mod() %>% 
                                 reactable(
                                   theme =  reactableTheme(
                                     highlightColor = "rgb(24 164 255 / 10%)",
                                     #borderColor = "hsl(0, 0%, 93%)",
                                     headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                   ),
                                   #width = 400,
                                   #theme = nytimes(),
                                   highlight = T,
                                   defaultPageSize = 8,
                                   style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                backgroundColor ="rgb(255 255 255 / 0%)"),
                                   defaultColDef = colDef(align = "left"
                                   ),
                                   bordered = F,
                                   compact = T,
                                   columns = list(
                                     hist  = colDef(
                                       align = "left",
                                       name = "Modernizações",
                                       minWidth = 120,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     ),
                                     mod = colDef(
                                       align = "center",
                                       name = "Realizadas",
                                       minWidth = 110,
                                       style = list(fontSize = "1.1rem"),
                                       headerStyle = list(fontSize = "1.1rem",
                                                          #fontWeight = "bold",
                                                          color = "white")
                                     )
                                   )
                                   
                                 ),
                               hr(),
                               
                               if(nrow(mod_equipe()) == 0 ){
                                 h6("Não Houve Modernização Nessa Data")
                               } else {
                                 highchart() %>%  
                                   hc_yAxis(title = list(text = " ",
                                                         style = list(fontSize = '13px',
                                                                      fontWeight= 'bold')),
                                            labels = list(style = list(fontSize = '11px',
                                                                       fontWeight= 'bold')),
                                            gridLineWidth =  0,
                                         
                                            stackLabels= list(
                                              enabled= TRUE,
                                              style = list(
                                                textOutline= 'none',
                                                color = "white",
                                                fontSize = "14px"
                                              )
                                              
                                            )
                                   ) %>% 
                                   hc_xAxis(title = list(text = " "),
                                            labels = list(rotation = -0,
                                                          style = list(fontSize = '13px',
                                                                       color = "white",
                                                                       fontWeight= 'bold')),
                                            categories =  if(length(unique(data_mod()$equipe)) == 1)
                                              list(unique(data_mod()$equipe)) else
                                                unique(data_mod()$equipe),
                                            labels = list(style = list(fontSize = "13px"))
                                   ) |>
                                   hc_add_dependency("plugins/grouped-categories.js") %>%
                                   hc_add_series(data = data_mod() %>% 
                                                   pull(n),
                                                 type="bar",
                                                 name = "Modernizado",
                                                 color = list(
                                                   linearGradient= c( list(x1=0),
                                                                      list(x2=0),
                                                                      list(y1=0),
                                                                      list(y2=1)),
                                                   stops= list(
                                                     c(0, '#26a5bf'),
                                                     c(0.5,"#28c5bf"),
                                                     c(1, "#26a5bf")
                                                   )
                                                 )
                                   ) %>%
                                   hc_legend(enabled = T,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '11px')) %>% 
                                   hc_plotOptions(
                                     bar = list(stacking= "normal",
                                                dataLabels = list(
                                                  enabled = TRUE,
                                                  color = 'white',
                                                  format = '{point.y} ',
                                                  shadow= F,
                                                  shape = NULL,
                                                  style = list(textOutline= 'none',
                                                               fontSize = '13px'))
                                     ),
                                     series = list(
                                       dataSorting= list(
                                         enabled= T,
                                         sortKey= 'n'
                                       ),
                                       pointPadding= 0,
                                       groupPadding =0.2,
                                       lineWidth = 1,
                                       shadow= F,
                                       borderWidth = 1,
                                       borderColor = "white",
                                       dataLabels = list(enabled = TRUE,
                                                         textOutline= 'none',
                                                         color = "white"))
                                   ) %>% 
                                   hc_title( text = "Modernizações por Equipe",
                                             style = list(color = "white",
                                                          useHTML = TRUE,
                                                          fontSize = '18px',
                                                          fontWeight= 'bold')) %>% 
                                   hc_tooltip(table = T,
                                              useHTML  =TRUE,
                                              headerFormat= "<span style='font-size:17px;'><b>{point.key} </b></span><br>",
                                              pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y}  </b> </span><br>",
                                              #xDateFormat =  '%Y-%m-%d',
                                              
                                              style = list(fontSize = '14px')
                                              #backgroundColor = "#ffffff",
                                              #borderColor= '#000000'
                                   )#
                               }
                               
                               
                               
                               
                               
                ),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )
    
    
    
    
    
    
    
    
   # bs4ValueBox(color = "primary",width = 12,
   #             value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
   #                            h4("ModernizaC'C#o"),
   #                            hr(),
   #                            mini_data_mod() %>% 
   #                              reactable(
   #                                theme =  reactableTheme(
   #                                  highlightColor = "rgb(24 164 255 / 10%)",
   #                                  #borderColor = "hsl(0, 0%, 93%)",
   #                                  headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
   #                                ),
   #                                #width = 400,
   #                                #theme = nytimes(),
   #                                highlight = T,
   #                                defaultPageSize = 8,
   #                                style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
   #                                             backgroundColor ="rgb(255 255 255 / 0%)"),
   #                                defaultColDef = colDef(align = "left"
   #                                ),
   #                                bordered = F,
   #                                compact = T,
   #                                columns = list(
   #                                  hist  = colDef(
   #                                    align = "left",
   #                                    name = "ModernizaC'C5es",
   #                                    minWidth = 120,
   #                                    style = list(fontSize = "1.1rem"),
   #                                    headerStyle = list(fontSize = "1.1rem",
   #                                                       #fontWeight = "bold",
   #                                                       color = "white")
   #                                  ),
   #                                  mod = colDef(
   #                                    align = "center",
   #                                    name = "Realizadas",
   #                                    minWidth = 110,
   #                                    style = list(fontSize = "1.1rem"),
   #                                    headerStyle = list(fontSize = "1.1rem",
   #                                                       #fontWeight = "bold",
   #                                                       color = "white")
   #                                  )
   #                                )
   #                                
   #                              ),
   #                            hr(),
   #                            
   #                            if(nrow(mod_equipe()) == 0 ){
   #                              h6("NC#o Houve ModernizaC'C#o Nessa Data")
   #                            } else {
   #                              hchart(mod_equipe(),
   #                                     "bar",
   #                                     hcaes(x = equipe,y = n,color= highcharter::colorize(n,colors  = c("#26a5bf")
   #                                                                                         #c("#367096","#f10707")
   #                                     ))) %>% 
   #                                hc_xAxis(title = list(text = " "),labels = list(rotation = -0,style = list(fontSize = '13px',color = "white",fontWeight= 'bold'))) %>% 
   #                                hc_yAxis(gridLineWidth =  0,title = list(text = " ",style = list(fontSize = '13px',fontWeight= 'bold')),labels = list(style = list(fontSize = '11px',fontWeight= 'bold'))) %>% 
   #                                hc_tooltip(table = T,useHTML  =TRUE,
   #                                           headerFormat= "<span style='font-size:17px;'><b> {point.key} </b></span><br>",
   #                                           pointFormat= "<span <span style='font-size:15px'><b></b></span><b>N:{point.n} </b> </span><br>",
   #                                           #xDateFormat =  '%Y-%m-%d',
   #                                           
   #                                           style = list(fontSize = '14px')
   #                                           #backgroundColor = "#ffffff",
   #                                           #borderColor= '#000000'
   #                                ) %>% 
   #                                hc_plotOptions(bar = list(
   #                                  #pointWidth = 35,
   #                                  dataLabels = list(
   #                                    enabled = TRUE,
   #                                    color = 'white',
   #                                    format = '{point.y}',
   #                                    shape = NULL,
   #                                    style = list(textOutline = NULL,
   #                                                 fontSize = '13px',
   #                                                 color = "black"))),
   #                                  series = list(lineWidth = 1,borderWidth = 1,borderColor = "white",
   #                                                dataLabels = list(format = 'R$ {point.y}', fontSize = '17px',enabled = TRUE,color = "black"))) %>% 
   #                                hc_colors(c("#881126"))%>% 
   #                                hc_title( text = "ModernizaC'C5es por Equipe",
   #                                          style = list(color = "white",
   #                                                       useHTML = TRUE,
   #                                                       fontSize = '15px',
   #                                                       fontWeight= 'bold')) %>% 
   #                                hc_caption(text = paste0("<b> ModernizaC'C5es por Equipe ",
   #                                                         format(input$filtro,"%d/%m/%Y"),"
   #          </b>"),style = list(color = "white"))
   #                            }
   #                            
   #                            
   #                            
   #                            
   #                            
   #             ),
   #             gradient = T,
   #             footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
   #             subtitle = 
   #               tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
   # )
   # 
   # 
   # 
   # 
   # 
   # 
  })
  #----
  

  # TABELAS/MAPAS ----
  os_status_data <- reactive({
    os() %>% 
      filter(
        desc_tipo_ordem_servico != "Modernização IP",
        data >= paste(Sys.Date(), "00:00:00") ,
        status %in% c("Pendente", "Parcialmente Executada","Executada")
      ) %>% 
      filter(status %in% c("Executada","Pendente", "Parcialmente Executada")) %>% 
      #mutate(prazo = as.numeric(prazo)) %>% 
      filter(!str_detect(prazo,"-") ) %>% 
      select(id_ordem_servico,equipe,data_hora_recebido,tipo=desc_tipo_ordem_servico,status,tarefas_finalizadas,avanco) %>% 
      mutate(avanco = as.numeric(str_remove(avanco,"%"))/100,
             status_col = case_when(
               status == "Parcialmente Executada" ~ "darkgreen",
               status == "Executada" ~ "#00586e",
               TRUE ~ "red"),
             data_hora_recebido = format(as.POSIXct(data_hora_recebido, format = "%d/%m/%Y %H:%M"),format = "%H:%M")
      ) %>% left_join(p_moni() %>%
                        select(id_ordem_servico,atrasado) %>%
                        tabyl(id_ordem_servico,atrasado),
                      by = "id_ordem_servico")
  })
  oc_pendentes <- reactive({
    p_oc() %>% 
      select(protocolo,tipo_de_ocorrencia,data_reclamacao,data_limite_para_atendimento,data_limite,dif,lat,lon,endereco) %>% 
      rbind(
        p_moni() %>% 
          select(protocolo,tipo_de_ocorrencia,data_reclamacao,data_limite_para_atendimento,data_limite,dif,lat,lon,endereco)
      ) %>% 
      left_join(solicitacoes()
                %>% select(protocolo,origem_ocorrencia,status,tempo_restante)
                ,by = "protocolo") %>% 
      mutate(
        #vencimento = as.numeric(round(difftime(data_limite, as.POSIXct(Sys.time(),"GMT"),units = "days"),0)),
        cor_vencimento = case_when(
          dif <= 0  ~  "darkred",
          dif > 0 & dif <= 24 ~  "red",
          dif > 24 & dif <= 48 ~  "orange",
          dif > 48 ~  "green",
        )
      ) %>% 
      relocate(dif, .after = last_col())
  })
  hist_os <- reactive({
    os() %>% 
      filter(
        desc_tipo_ordem_servico != "Modernização IP",
        data >= paste(Sys.Date()-7, "06:00:00"),
        data <= format(Sys.time(), "%Y-%m-%d %X"),
        status %in% c("Pendente", "Parcialmente Executada","Executada")
      ) %>% 
      filter(status %in% c("Executada","Pendente", "Parcialmente Executada")) %>% 
      #mutate(prazo = as.numeric(prazo)) %>% 
      #filter(!str_detect(prazo,"-") ) %>% 
      select(data,id_ordem_servico,equipe,data_hora_recebido,tipo=desc_tipo_ordem_servico,status,tarefas_finalizadas,avanco,total_pontos,total_atendidos) %>% 
      mutate(avanco = as.numeric(str_remove(avanco,"%"))/100,
             status_col = case_when(
               status == "Parcialmente Executada" ~ "darkgreen",
               status == "Executada" ~ "#00586e",
               TRUE ~ "red"),
             data_hora_recebido = format(as.POSIXct(data_hora_recebido, format = "%d/%m/%Y %H:%M"),format = "%H:%M")
      ) %>% 
      #left_join(p_moni() %>%
      #                  select(id_ordem_servico,atrasado) %>%
      #                  tabyl(id_ordem_servico,atrasado),
      #                by = "id_ordem_servico") %>% 
      mutate(data = as.Date(format(as.POSIXct(data),"%Y-%m-%d"))) %>% 
      group_by(data) %>% 
      summarise(pontos_realizados = sum(as.numeric(total_atendidos)),
                pontos_total = sum(as.numeric(total_pontos))) %>% 
      mutate(p = round(100*(pontos_realizados/pontos_total),1),
             pontos_n_realizados = pontos_total - pontos_realizados)
    
  })
  os_equipes <- reactive({
    os() %>% 
      filter(
        desc_tipo_ordem_servico != "Modernização IP",
        data >= paste(input$daterange[1],"06:00:00"),
        data <= paste(input$daterange[2],"23:59:99"),
        #data >= if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){paste(Sys.Date(), "00:00:00") } else{  paste(Sys.Date()-7, "06:00:00") },
        #data <= if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){paste(Sys.Date(), "00:00:00") } else{  paste(Sys.Date(), "06:00:00") },
        status %in% c("Pendente", "Parcialmente Executada","Executada")
      ) %>% 
      select(data,equipe,status,total_pontos,total_atendidos) %>% 
      mutate(data = as.Date(format(as.POSIXct(data),"%Y-%m-%d")),
             total_pontos = as.numeric(total_pontos),
             total_atendidos = as.numeric(total_atendidos),
             total_n_atendido = total_pontos - total_atendidos) %>% 
      group_by(Equipe = equipe) %>% 
      summarise(n_atendidos = sum(total_n_atendido),
                atendido = sum(total_atendidos)
      )
  }) 
  
  output$status_os <- renderUI({
    
      os_status_data() %>% 
        reactable(
          language = reactableLang(
            searchPlaceholder = "Procurar"
          ),
          pagination = F,
          highlight = T,
          theme = reactableTheme(
            highlightColor = "rgb(24 164 255 / 10%)",
            #borderColor = "hsl(0, 0%, 93%)",
            headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
          ),
          #theme = reactableTheme(highlightColor = "rgba(197,222,225,0.9305847338935574)"),
          #theme = pff(header_font_size = 15),
          striped = TRUE,
          searchable = TRUE,
          wrap = FALSE,
          resizable =TRUE,
          bordered = F,
          compact = T,
          style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                       backgroundColor ="rgb(255 255 255 / 0%)"),
          defaultColDef = colDef(align = "center",
                                 style = list(fontWeight = "bold",
                                              color = "black")
          ),
          defaultSorted = 'avanco',
          defaultSortOrder = 'desc',
          columns = list(
            avanco = colDef(name = "Progresso",
                            headerStyle = list(fontSize = "1rem",
                                               fontWeight = "bold",
                                               color = "black"),
                            minWidth = 200,
                            format = colFormat(suffix = "dias"),
                            #cell = color_tiles(.,box_shadow = TRUE,colors = c("#ffe4cc","#750f0f", "#bb0606")),
                            cell = data_bars(.,text_size = 12,
                                             box_shadow = TRUE,
                                             max_value = 1, 
                                             fill_color = c( "#bb0606","#750f0f"),
                                             fill_gradient = TRUE,
                                             number_fmt = scales::percent)
                            #,colors = c("#ffe4cc","#750f0f", "#bb0606")
                            #style = color_scales(dados_tabela,colors = c("#ffe4cc","#750f0f", "#bb0606"))
            ),
            status = colDef(name = "Status",
                            minWidth = 155,
                            headerStyle = list(fontSize = "1rem",
                                               fontWeight = "bold",
                                               color = "black"),
                            cell = pill_buttons(.,
                                                color_ref = "status_col",
                                                opacity = 0.7)
            ),
            status_col = colDef(show = FALSE),
            id_ordem_servico = colDef(name = "OS",
                                      headerStyle = list(fontSize = "1rem",
                                                         fontWeight = "bold",
                                                         color = "black"),
                                      minWidth = 60,
                                      align = "center"),
            tarefas_finalizadas = colDef(name = "Pontos Realizados",
                                         style = list(fontSize = "1.2rem",
                                                      fontWeight = "bold",
                                                      color = "black"),
                                         headerStyle = list(fontSize = "1rem",
                                                            fontWeight = "bold",
                                                            color = "black"),
                                         minWidth = 80,
                                         align = "center"),
            equipe = colDef(name = "Equipe",
                            headerStyle = list(fontSize = "1rem",
                                               fontWeight = "bold",
                                               color = "black")),
            Atrasada = colDef(name = "Atrasadas",
                              style = list(fontSize = "1.2rem",
                                           fontWeight = "bold",
                                           color = "black"),
                              headerStyle = list(fontSize = "1rem",
                                                 fontWeight = "bold",
                                                 color = "black"),
                              align = "center",
                              maxWidth = 95
                              
            ),
            data_hora_recebido = colDef(name = "Hora Login Equipe",
                                        style = list(fontSize = "1.2rem",
                                                     fontWeight = "bold",
                                                     color = "black"),
                                        headerStyle = list(fontSize = "1rem",
                                                           fontWeight = "bold",
                                                           color = "black"),
                                        align = "center",
                                        minWidth = 110
                                        
            ),
            tipo = colDef(show = F,name = "Tipo",
                                        style = list(fontSize = "1.2rem",
                                                     fontWeight = "bold",
                                                     color = "black"),
                                        headerStyle = list(fontSize = "1rem",
                                                           fontWeight = "bold",
                                                           color = "black"),
                                        align = "center",
                                        minWidth = 155
                                        
            ),
            "No Prazo" = colDef(show = F,name = "No Prazo",
                                style = list(fontSize = "1.2rem",
                                                               fontWeight = "bold",
                                                               color = "black"),
                                headerStyle = list(fontSize = "1rem",
                                                   fontWeight = "bold",
                                                   color = "black"),
                                align = "center",maxWidth = 95
            )
          ),
          details = function(index){
            dados_os <- p_moni()[p_moni()$id_ordem_servico ==  os_status_data()$id_ordem_servico[index], ]   %>% 
              mutate(
                cor_atraso = case_when(
                  dias_prazo >= 0 ~ "darkgreen",
                  TRUE ~ "red"
                ))
            
            htmltools::div(style = "padding: 1rem",
                           reactable(dados_os %>% 
                                       select(equipe,id_ordem_servico,protocolo,atrasado,dias_prazo,data_reclamacao,data_limite_atendimento,tipo_de_ocorrencia,bairro,endereco) ,
                                     defaultSorted = 'dias_prazo',
                                     resizable =TRUE,
                                     searchable = TRUE,
                                     columns = list(
                                       dias_prazo = colDef(
                                         headerStyle = list(fontSize = ".85rem",
                                                            fontWeight = "bold",
                                                            color = "black"),
                                         cell = pill_buttons(dados_os,
                                                             color_ref = "cor_atraso",
                                                             opacity = 0.7)
                                       )
                                     )
                                     ,outlined = TRUE))
          }
        ) 
  
    
   
  })
 
  output$status_os_hist <- renderbs4ValueBox({
    
    
    bs4ValueBox(color = "primary",
                
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;"
                               
                ),
                gradient = T,footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(
    highchart() %>%  
      hc_yAxis(title = list(text = " ",
                            style = list(fontSize = '13px',
                                         fontWeight= 'bold')),
               labels = list(enabled = F,
                             style = list(fontSize = '11px',
                                          fontWeight= 'bold')),
               gridLineWidth =  0,
               stackLabels= list(
                 enabled= F,
                 style = list(
                   textOutline= 'none',
                   color = "white",
                   fontSize = "14px"
                 )
                 
               )
      ) %>% 
      hc_xAxis(title = list(text = " "),
               labels = list(rotation = -0,
                             style = list(fontSize = '13px',
                                          color = "white",
                                          fontWeight= 'bold')),
               categories = c(format(hist_os()$data,"%d %B")),
               labels = list(style = list(fontSize = "13px"))
      ) |>
      hc_add_dependency("plugins/grouped-categories.js") %>%
      hc_add_series(data = hist_os() %>% 
                      pull(pontos_n_realizados),
                    type="column",
                    name = "Não Realizados",
                    color = list(
                      linearGradient= c( list(x1=0),
                                         list(x2=0),
                                         list(y1=0),
                                         list(y2=1)),
                      stops= list(
                        c(0, '#bb0606'),
                        c(0.5,"#750f0f"),
                        c(1, "#3d1010")
                      )
                    )) %>%
      hc_add_series(data = hist_os() %>% 
                      pull(pontos_realizados),
                    type="column",
                    name = "Realizados",
                    color = list(
                      linearGradient= c( list(x1=0),
                                         list(x2=0),
                                         list(y1=0),
                                         list(y2=1)),
                      stops= list(
                        c(0, '#26a5bf'),
                        c(0.5,"#00586e"),
                        c(1, "#064354")
                      )
                    ))%>% 
      hc_legend(enabled = T,layout= 'horizontal',itemStyle = list(color = "white", fontSize = '13px')) %>% 
      hc_plotOptions(
        column = list(stacking= "normal",
                      dataLabels = list(
                        enabled = TRUE,
                        color = 'white',
                        format = '{point.y} ',
                        shadow= F,
                        shape = NULL,
                        style = list(textOutline= 'none',
                                     fontSize = '13px'))
        ),
        series = list(
          dataSorting= list(
            enabled= T,
            sortKey= 'n'
          ),
          pointPadding= 0,
          groupPadding =0.2,
          lineWidth = 1,
          shadow= F,
          borderWidth = 1,
          borderColor = "white",
          dataLabels = list(enabled = TRUE,
                            textOutline= 'none',
                            color = "white"))
      ) %>% 
      hc_title( text = "Pontos Realizados x Não Realizados (Ultima Semana)",
                style = list(color = "white",
                             useHTML = TRUE,
                             fontSize = '18px',
                             fontWeight= 'bold')) %>% 
      hc_tooltip(table = T,
                 useHTML  =TRUE,
                 headerFormat= "<span style='font-size:17px;'><b>{point.key} </b></span><br>",
                 pointFormat= "<span <span style='color:{series.color};font-size:15px'><b> {series.name}</b></span>: <b> {point.y}  </b> </span><br>",
                 #xDateFormat =  '%Y-%m-%d',
                 
                 style = list(fontSize = '14px')
                 #backgroundColor = "#ffffff",
                 #borderColor= '#000000'
      ) %>% 
      hc_boost(enabled = TRUE)
                  )
    )
  })
  
  output$c_hist_os_equipe <- renderUI({
    
    
    
    bs4ValueBox(color = "primary",width = 12,
                value = tags$p(style = "font-size: 30px;font-weight: lighter;text-align: center;", 
                               h4("Pontos Realizados x Não Realizados"),
                               hr(),
                               os_equipes() %>% 
                                 reactable(compact = TRUE,
                                           defaultSortOrder = 'desc',
                                           defaultSorted = 'n_atendidos',
                                           theme =  reactableTheme(
                                             highlightColor = "rgb(24 164 255 / 10%)"
                                             #borderColor = "hsl(0, 0%, 93%)",
                                             #headerStyle = list(borderColor = "hsl(0, 0%, 90%)")
                                           ),
                                           resizable = T,
                                           borderless = T,
                                           highlight = T,
                                           pagination = T,
                                           style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                                                        backgroundColor ="rgb(255 255 255 / 0%)"),
                                           columns = list(
                                             Equipe = colDef(name = "Equipe" ,align = "left"),
                                             n_atendidos = colDef(
                                               name = 'Pontos Não Atendidos',
                                               minWidth =200,
                                               align = 'right',
                                               cell = data_bars(
                                                 data = .,
                                                 text_position = 'outside-end',
                                                 align_bars = "right",
                                                 background = "rgb(238 238 238 / 0%)",
                                                 text_color = "white",
                                                 fill_color =  c("#FEE5D9" ,"#8f3c3e", "#ad262a" ,"#CB181D","#ff0006"),
                                                 number_fmt = scales::number_format(accuracy = 1)
                                               )
                                             ),
                                             atendido = colDef(
                                               name = 'Pontos Atendidos',
                                               minWidth = 200,
                                               align = 'left',
                                               cell = data_bars(
                                                 data = .,
                                                 text_position = 'outside-end',
                                                 background = "rgb(238 238 238 / 0%)",
                                                 text_color = "white",
                                                 fill_color = RColorBrewer::brewer.pal(5,"Greens"),
                                                 number_fmt = scales::number_format(accuracy = 1)
                                               )
                                             )
                                           )
                                 )
                ),
                gradient = T,
                footer = tags$p(style = "heigth:0px;margin-bottom: 0rem;"),
                subtitle = 
                  tags$p(style = "font-size: 20px;font-weight: lighter;text-align: center;")
    )
    
  })
   
  # p_map_tab DATA ----
  makeColoredIcon <- function(cor) {
    svg_icon <- sprintf(
      '<svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" width="24" height="24" style="shape-rendering:geometricPrecision;text-rendering:geometricPrecision;image-rendering:optimizeQuality;fill-rule:evenodd;clip-rule:evenodd" viewBox="0 0 6.827 6.827"><defs><style>.fil0{fill:none}</style></defs><g id="Layer_x0020_1"><g id="_486581072"><path id="_486581456" class="fil0" d="M0 0h6.827v6.827H0z"/><path id="_486581144" class="fil0" d="M.853.853h5.12v5.12H.853z"/></g><path d="M4.702 1.386a1.772 1.772 0 0 0-1.29-.533c-.503 0-.934.18-1.287.533a1.726 1.726 0 0 0-.533 1.29c0 .337.081.64.239.912l.034.051 1.512 2.334L4.983 3.61a1.78 1.78 0 0 0 .251-.933c0-.507-.179-.937-.532-1.29z" style="fill:%s"/><path d="M3.411 1.859a.808.808 0 0 0-.618.255.839.839 0 0 0-.255.618c0 .243.085.447.255.622a.84.84 0 0 0 .618.255.856.856 0 0 0 .622-.255.856.856 0 0 0 .256-.622.84.84 0 0 0-.256-.618.822.822 0 0 0-.622-.255z" style="fill:black;"/></g></svg>',
      #'<svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" width="2048" height="2048" style="shape-rendering:geometricPrecision;text-rendering:geometricPrecision;image-rendering:optimizeQuality;fill-rule:evenodd;clip-rule:evenodd"><path d="M558 393.777c137.406 46.74 308.961 64.193 477.381 54.327 167.639-9.82 331.362-46.671 454.244-108.595l46.376-23.37v679.488l-17.626 8.882c-130.785 65.907-303.533 105.038-479.494 115.347-176.078 10.314-356.199-8.193-501.38-57.577L558 393.778z" style="fill:%s;fill-rule:nonzero"/><path d="M576.002 287.999c0-17.673-14.328-32-32-32-17.674 0-32.002 14.327-32.002 32v1472c0 17.673 14.328 32 32.001 32s32.001-14.327 32.001-32v-1472z" style="fill:%s;fill-rule:nonzero"/><path style="fill:none" d="M0 0h2048v2048H0z"/></svg>',
      cor
    )
    
    makeIcon(
      iconUrl = sprintf("data:image/svg+xml;charset=UTF-8,%s", URLencode(svg_icon)),
      iconWidth = 24*2, iconHeight = 24*2,
      iconAnchorX = 12*2, iconAnchorY = 12*2,
      popupAnchorX = 0, popupAnchorY = 0
    )
  }
  
  atendimentos_realizados <- reactive({
    atendimentos() %>% 
      filter(
        atendimento != "MOD - Modernizado",
        data_hora == if(input$filtro == Sys.Date()){
          if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
        } else {
          input$filtro
        }
        #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
      ) %>% 
      select(n_atendimento = no_atendimento,protocolo,equipe,atendimento,tipo_de_ocorrencia,motivo,endereco,lat,lon,data_atendimento,hora_inicio,hora_conclusao) %>% 
      left_join(solicitacoes() %>% 
                  select(protocolo,origem_ocorrencia,tempo_restante,data_reclamacao)) %>% 
      mutate(cor_atendimento = case_when(
        atendimento == "Atendido" ~ "#00586e",
        atendimento == "Impossibilidade" ~ "#bb0606",
        atendimento == "Encontrado normal" ~ "#dda33b",
        atendimento == "Atendimento relacionado" ~ "#34b030",
        atendimento == "Fora do escopo do contrato"~  "#e06208" 
      )
      )%>% 
      left_join(dados_materias() %>%
                  filter(
                    data_hora == if(input$filtro == Sys.Date()){
                      if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                    } else {
                      input$filtro
                    }
                    #data_hora == if(format(Sys.time(), "%Y-%m-%d %X") < paste(Sys.Date(), "06:00:00")){   Sys.Date()-1 } else{   Sys.Date() }
                  ) %>% 
                  group_by(n_atendimento) %>% summarise(gasto = sum(gasto_total)),by = "n_atendimento")  %>% 
      replace_na(replace = list(gasto = 0,
                                origem_ocorrencia = "Avulso",
                                protocolo = "Avulso",
                                tempo_restante = "Avulso/Sem Prazo"))
    
    
    
  })
  
  funcao_cor <- \(){
    c("red", "darkred", "orange", "beige", "green", "darkgreen", "lightgreen", "blue", "darkblue", "lightblue", "purple", "pink", "cadetblue", "white", "gray", "lightgray", "black")
    #viridisLite::viridis(30)
    #paste0("#", paste0(sample(c(0:9, letters[1:6]), 6, replace = TRUE), collapse = ""))
  }
  funcao_cor_at <- \(){
    c(
      "brown","cadetblue","cyan", "bisque","blue","green", "red","black", "aquamarine","coral","aliceblue","blueviolet", "chocolate", "beige","darkgreen","darkolivegreen","darksalmon","darkorange","darkseagreen","darkslategray","deeppink","deepskyblue", "darkred","darkgrey","antiquewhite","darkorchid", "darkmagenta","tan","olivedrab","darkkhaki","cornflowerblue","darkslateblue","white" ,"blanchedalmond","darkcyan","plum","indianred","sandybrown","burlywood","chartreuse","darkgoldenrod"
    )
    #viridisLite::viridis(30)
    #paste0("#", paste0(sample(c(0:9, letters[1:6]), 6, replace = TRUE), collapse = ""))
  }
  
  cor_equipe <- reactive({
    set.seed(9)
    sample(funcao_cor(),length(unique(p_moni()$equipe)),replace = F)
  })
  cor_equipe_at <- reactive({
    set.seed(9)
    sample(funcao_cor_at(),length(unique(atendimentos_realizados()$equipe)),replace = F)
  })
  
  data_cor_equipe <- reactive({
    data.frame(equipe = unique(p_moni()$equipe), cor_equipes = cor_equipe())
  })
  data_cor_equipe_at <- reactive({
    data.frame(equipe = unique(atendimentos_realizados()$equipe), cor_equipes = cor_equipe_at())
  })
  
  data_tabela_mapa <- reactive({
    p_moni() %>% 
      mutate(
        cor_vencimento = case_when(
          dif <= 0  ~  "darkred",
          dif > 0 & dif <= 24 ~  "red",
          dif > 24 & dif <= 48 ~  "orange",
          dif > 48 ~  "green",
        )
      ) %>% 
      left_join(data_cor_equipe(),by = "equipe") %>% 
      filter(
        if(input$c_view == "Atendimentos Pendentes"){
          !str_detect(pattern ="RONDA",equipe)
        } else if(input$c_view == "Rondas Pendentes"){
          str_detect(pattern ="RONDA",equipe)
        }
      )
  })
  data_tabela_mapa_at <- reactive({
    atendimentos_realizados()%>% 
      left_join(data_cor_equipe_at(),by = "equipe")
  })
  
  icons <- reactive({
    awesomeIcons(icon = "flag",
                 iconColor = "black",
                 #iconColor =data_tabela_mapa()$cor_equipes,
                 library = "ion",
                 markerColor =data_tabela_mapa()$cor_equipes,
                 text = ~paste0(data_tabela_mapa()$dif,"h")
    )
  })
  icons_oc <- reactive({
    awesomeIcons(icon = "flag",
                 text = ~paste0(oc_pendentes()$dif,"h"),
                 iconColor = "black",
                 library = "ion",
                 markerColor = oc_pendentes()$cor_vencimento
    )
  })
  
  protocolos_share <- reactive({
    SharedData$new(data_tabela_mapa()
                   ,group = "protocolos")
  })
  protocolos_share_at <- reactive({
    SharedData$new(data_tabela_mapa_at()
                   ,group = "protocolos")
  })
  protocolos_share_oc <- reactive({
    SharedData$new(oc_pendentes()
                   ,group = "protocolos")
  })
  
  data_share <- reactive({
    data_tabela_mapa() %>% 
      select(protocolo,id_ordem_servico,equipe,tipo_de_ocorrencia,endereco,data_limite_para_atendimento,dif,cor_atraso,bairro,cor_equipes,cor_vencimento)  %>% 
      
      SharedData$new(group = "protocolos")
  })
  data_share_at <- reactive({
    data_tabela_mapa_at() %>% 
      #select(protocolo,id_ordem_servico,equipe,tipo_de_ocorrencia,endereco,data_reclamacao,data_limite_atendimento,dias_prazo,cor_atraso,bairro,cor_equipes)  %>% 
      
      SharedData$new(group = "protocolos")
  })
  data_share_oc <- reactive({
    oc_pendentes() %>% 
      SharedData$new(group = "protocolos")
  })
  
  
  mapa <- reactive({
    leaflet(
      protocolos_share()
    ) %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng =-47.063240 ,lat = -22.907104,zoom = 11) %>% 
      addGeoJSON(jsonlite::fromJSON("municipio.geojson"),opacity = 0.05) %>% 
      addAwesomeMarkers(icon = icons(),popup = ~paste(
        "<b> Protocolo: </b>",protocolo,"<br>",
        "<b> Equipe: </b>",equipe,"<br>",
        "<b> Endereço: </b>",endereco,"<br>",
        "<b> Bairro: </b>",bairro,"<br>",
        "<b> Tipo de Ocorrência: </b>",tipo_de_ocorrencia,"<br>",
        "<b> Reclamação: </b>",data_reclamacao,"<br>",
        "<b> Limite Atendimento: </b>",data_limite,"<br>",
        "<b> Prazo: </b>",dif," horas","<br>"
      )) %>% 
      addLegend("bottomright",
                colors = unique(data_tabela_mapa()$cor_equipes),
                labels = unique(data_tabela_mapa()$equipe),
                title = "Equipes") 
  })
  mapa_at <- reactive({
    leaflet(
      protocolos_share_at()
    ) %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng =-47.063240 ,lat = -22.907104,zoom = 11) %>% 
      addGeoJSON(jsonlite::fromJSON("municipio.geojson"),opacity = 0.05) %>% 
      addMarkers(
        lng = atendimentos_realizados()$lon,
        lat = atendimentos_realizados()$lat,
        icon = makeColoredIcon(data_tabela_mapa_at()$cor_equipes),
        popup = ~paste("<b> Protocolo: </b>",protocolo,"<br>",
                       "<b> Equipe: </b>",equipe,"<br>",
                       "<b> Endereço: </b>",endereco,"<br>",
                       #"<b> Bairro: </b>",bairro,"<br>",
                       "<b> Tipo de Ocorrência: </b>",tipo_de_ocorrencia,"<br>",
                       "<b> Motivo: </b>",motivo,"<br>",
                       "<b> Origem Ocorrência: </b>",origem_ocorrencia,"<br>",
                       "<b> Reclamação: </b>",data_reclamacao,"<br>",
                       "<b> Atendimento: </b>",data_atendimento,"<br>",
                       "<b> Hora Inicio Atendimento: </b>",hora_inicio,"<br>",
                       "<b> Hora Conclusão Atendimento: </b>",hora_conclusao,"<br>",
                       "<b> Atendimento Quanto ao Prazo: </b>",tempo_restante,"<br>"
                       
                       
                       
        )
      ) %>% 
      addLegend("bottomright",
                colors = unique(data_tabela_mapa_at()$cor_equipes),
                labels = unique(data_tabela_mapa_at()$equipe),
                title = "Equipes") 
  })
  mapa_oc <- reactive({
    leaflet(
      protocolos_share_oc()
    ) %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      setView(lng =-47.063240 ,lat = -22.907104,zoom = 11) %>% 
      addGeoJSON(jsonlite::fromJSON("municipio.geojson"),opacity = 0.05) %>% 
      addAwesomeMarkers(icon = icons_oc(),popup = ~paste("<b> Protocolo: </b>",protocolo,"<br>",
                                                         "<b> Endereço: </b>",endereco,"<br>",
                                                         "<b> Tipo de Ocorrência: </b>",tipo_de_ocorrencia,"<br>",
                                                         "<b> Origem Ocorrência: </b>",origem_ocorrencia,"<br>",
                                                         "<b> Reclamação: </b>",data_reclamacao,"<br>",
                                                         "<b> Data Limite: </b>",data_limite,"<br>",
                                                         "<b> Status: </b>",status,"<br>",
                                                         "<b> Vencimento: </b>",dif," Horas","<br>"
                                                         
                                                         
                                                         
      )) %>% 
      addLegend("bottomright",
                #labFormat = labelFormat(aling = "left"),
                colors = c("darkred","red","orange","green"),
                labels = c("Vencido","Vence em 24h","Vence em 48h","Vence apC3s 48h"),
                title = "Prazos para Vencimento")
  })
  
  
  tbl <- reactive({
    data_share() %>% 
      reactable(
        language = reactableLang(
          searchPlaceholder = "Procurar",
          pageInfo = 
        ),
        pagination = F,
        height = 500,
        highlight = T,
        theme = reactableTheme( rowSelectedStyle = list(backgroundColor = "#eee",
                                                        boxShadow = "inset 2px 0 0 0 #ffa62d"),
                                highlightColor = "rgb(24 164 255 / 10%)",
                                headerStyle = list(fontWeight = "bold",
                                                   borderColor = "hsl(0, 0%, 90%)",
                                                   #background = "rgb(173 194 208 / 98%)",
                                                   backgroundImage =  "linear-gradient(to bottom,#2e892fab,rgb(12 68 89))",
                                                   color = "white")
        ),
        
        striped = TRUE,
        searchable = TRUE,
        wrap = FALSE,
        resizable =TRUE,
        bordered = F,
        style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                     backgroundColor ="rgb(255 255 255 / 0%)"),
        defaultColDef = colDef(align = "left",
                               style = list(fontWeight = "bold",
                                            color = "black")
        ),
        selection = "multiple",
        onClick = "select",
        rowStyle = list(cursor = "pointer"),
        minRows = 10,
        defaultSorted = 'dif',
        columns = list(
          cor_atraso = colDef(show = FALSE),
          endereco = colDef(name = "Endereço",
                            show = F,
                            minWidth = 200,
                            resizable = T),
          tipo_de_ocorrencia = colDef(name = "Tipo de Ocorrências",
                                      resizable = T,
                                      align = "center",
                                      minWidth = 100),
          equipe = colDef(name = "Equipe",minWidth = 100,
                          align = "center",
                          cell = color_tiles(data_tabela_mapa(),
                                             color_ref = "cor_equipes"
                          )
          ),
          id_ordem_servico = colDef(name = "OS",show = F),
          protocolo = colDef(name = "Protocolo",maxWidth = 110,align = "center"),
          data_limite_para_atendimento = colDef(name = "Data Limite",
                                                align = "center",
                                                minWidth = 120,
                                                resizable = T),
          dif = colDef(name = "Vencimento (Horas)",
                       align = "center",
                       format = colFormat(suffix = " Horas"),
                       cell =  color_tiles(data_tabela_mapa(),
                                           bold_text = T,
                                           box_shadow = T,
                                           color_ref  = "cor_vencimento",
                                           number_fmt = scales::number_format(suffix = " Horas")
                       )
          ),
          bairro = colDef(show = F),
          cor_equipes = colDef(show = F),
          cor_vencimento = colDef(show = F)
        )
      )
  }) 
  tbl_at <- reactive({
    data_share_at() %>% 
      reactable(
        pagination = T,
        highlight = T,
        theme = reactableTheme( rowSelectedStyle = list(backgroundColor = "#eee",
                                                        boxShadow = "inset 2px 0 0 0 #ffa62d"),
                                highlightColor = "rgb(24 164 255 / 10%)",
                                headerStyle = list(fontWeight = "bold",
                                                   borderColor = "hsl(0, 0%, 90%)",
                                                   backgroundImage =  "linear-gradient(to bottom,#2e892fab,rgb(12 68 89))",
                                                   color = "white")
        ),
        striped = TRUE,
        defaultSorted = 'gasto',
        defaultSortOrder = "desc",
        searchable = TRUE,
        wrap = FALSE,
        resizable =TRUE,
        bordered = F,
        compact = T,
        selection = "multiple",
        onClick = "select",
        rowStyle = list(cursor = "pointer"),
        style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                     backgroundColor ="rgb(255 255 255 / 0%)"),
        defaultColDef = colDef(align = "center",
                               style = list(fontWeight = "bold",
                                            color = "black")
        ),
        columns = list(
          n_atendimento = colDef(name = "Nº: Atend",
                                 maxWidth = 100,
                                 footer = "Total",
                                 footerStyle = list(fontSize = "1rem",
                                                    fontWeight = "bold",
                                                    color = "black"),
                                 headerStyle = list(fontSize = "1rem",
                                                    fontWeight = "bold",
                                                    color = "white")),
          protocolo = colDef(name = "Protocolo",
                             maxWidth = 100,
                             footerStyle = list(fontSize = "1rem",
                                                fontWeight = "bold",
                                                color = "black"),
                             headerStyle = list(fontSize = "1rem",
                                                fontWeight = "bold",
                                                color = "white")),
          equipe = colDef(name = "Equipe",
                          minWidth = 120,
                          headerStyle = list(fontSize = "1rem",
                                             fontWeight = "bold",
                                             color = "white"),
                          cell = color_tiles(data_tabela_mapa_at(),
                                             color_ref = "cor_equipes"
                          )
          ),
          atendimento = colDef(name = "Status",align = 'center',
                               headerStyle = list(fontSize = "1rem",
                                                  fontWeight = "bold",
                                                  color = "white"),
                               cell = pill_buttons(atendimentos_realizados(),
                                                   color_ref = "cor_atendimento",
                                                   box_shadow = T,
                                                   opacity = 0.7)),
          origem_ocorrencia = colDef(name = "Origem",
                                     headerStyle = list(fontSize = "1rem",
                                                        fontWeight = "bold",
                                                        color = "white")),
          tempo_restante = colDef(name = "Prazo",
                                  headerStyle = list(fontSize = "1rem",
                                                     fontWeight = "bold",
                                                     color = "white")),
          tipo_de_ocorrencia = colDef(name = "Tipo Ocorrência",
                                      headerStyle = list(fontSize = "1rem",
                                                         fontWeight = "bold",
                                                         color = "white")),
          motivo =colDef(name = "Motivo",
                         headerStyle = list(fontSize = "1rem",
                                            fontWeight = "bold",
                                            color = "white")),
          endereco = colDef(name = "Endereço",
                            headerStyle = list(fontSize = "1rem",
                                               fontWeight = "bold",
                                               color = "white")),
          lat = colDef(show = F),
          lon = colDef(show = F),
          hora_inicio = colDef(show = F),
          data_atendimento = colDef(show = F),
          hora_conclusao = colDef(name = "Hora Atendimento",
                                  headerStyle = list(fontSize = "1rem",
                                                     fontWeight = "bold",
                                                     color = "white")),
          cor_atendimento= colDef(show = F),
          data_reclamacao = colDef(name = "Reclamação",
                                   headerStyle = list(fontSize = "1rem",
                                                      fontWeight = "bold",
                                                      color = "white")),
          gasto = colDef(name = "Gasto",align = "center",
                         headerStyle = list(fontSize = "1rem",
                                            fontWeight = "bold",
                                            color = "white"),
                         cell = icon_assign(atendimentos_realizados(),
                                            icon = "dollar-sign",
                                            align_icons = "right",
                                            fill_color = "red",
                                            empty_color = "white",
                                            buckets =3,
                                            show_values = "left",
                                            number_fmt =  scales::number_format(prefix = "R$ "),
                                            empty_opacity = 0
                         ),
                         footer = \(values){ sprintf("R$%.2f", sum(values)) },
                         footerStyle = list(fontSize = "1rem",
                                            fontWeight = "bold",
                                            color = "black")
          ),
          cor_equipes = colDef(show = F)
        ),
        details = function(index){
          dados_at <- dados_materias()[dados_materias()$n_atendimento ==  atendimentos_realizados()$n_atendimento[index], ] 
          
          htmltools::div(style = "padding: 1rem",
                         reactable(dados_at %>% 
                                     select(n_atendimento,protocolo,codigo,descricao,equipe,quantidade,valor_unitario),
                                   resizable =TRUE,
                                   searchable = TRUE
                                   ,outlined = TRUE))
        }
      )
    
  })
  tbl_oc <- reactive({
    data_share_oc() %>% 
      reactable(
        pagination = F,
        height = 500,
        highlight = T,
        theme = reactableTheme( rowSelectedStyle = list(backgroundColor = "#eee",
                                                        boxShadow = "inset 2px 0 0 0 #ffa62d"),
                                highlightColor = "rgb(24 164 255 / 10%)",
                                headerStyle = list(fontWeight = "bold",
                                                   borderColor = "hsl(0, 0%, 90%)",
                                                   backgroundImage =  "linear-gradient(to bottom,#2e892fab,rgb(12 68 89))",
                                                   color = "white")
        ),
        striped = TRUE,
        defaultSorted = 'dif',
        searchable = TRUE,
        wrap = FALSE,
        resizable =TRUE,
        bordered = F,
        compact = T,
        selection = "multiple",
        onClick = "select",
        rowStyle = list(cursor = "pointer"),
        style = list(fontFamily = "-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif",
                     backgroundColor ="rgb(255 255 255 / 0%)"),
        defaultColDef = colDef(align = "left",
                               style = list(fontWeight = "bold",
                                            color = "black")
        ),
        columns = list(
          protocolo = colDef(name = "Protocolo",
                             maxWidth = 100,
                             footerStyle = list(fontSize = "1rem",
                                                fontWeight = "bold",
                                                color = "black"),
                             headerStyle = list(fontSize = "1rem",
                                                fontWeight = "bold",
                                                color = "white")),
          origem_ocorrencia = colDef(name = "Origem",
                                     headerStyle = list(fontSize = "1rem",
                                                        fontWeight = "bold",
                                                        color = "white")),
          tempo_restante = colDef(name = "Prazo",show = F,
                                  headerStyle = list(fontSize = "1rem",
                                                     fontWeight = "bold",
                                                     color = "white")),
          tipo_de_ocorrencia = colDef(name = "Tipo Ocorrência",
                                      headerStyle = list(fontSize = "1rem",
                                                         fontWeight = "bold",
                                                         color = "white")),
          endereco = colDef(name = "Endereço",
                            headerStyle = list(fontSize = "1rem",
                                               fontWeight = "bold",
                                               color = "white")),
          status = colDef(name = "Status",
                          headerStyle = list(fontSize = "1rem",
                                             fontWeight = "bold",
                                             color = "white")),
          lat = colDef(show = F),
          lon = colDef(show = F),
          data_reclamacao = colDef(name = "Reclamação",
                                   headerStyle = list(fontSize = "1rem",
                                                      fontWeight = "bold",
                                                      color = "white")),
          data_limite_para_atendimento = colDef(name = "Data Limite",
                                                minWidth = 180,
                                                resizable = T),
          dif = colDef(name = "Vencimento (Horas)",
                       style = list(fontSize = ".9rem"),
                       headerStyle = list(fontSize = "1rem",
                                          color = "white"),
                       format = colFormat(suffix = " Horas"),
                       cell =  color_tiles(oc_pendentes(),
                                           bold_text = T,
                                           box_shadow = T,
                                           color_ref  = "cor_vencimento",
                                           number_fmt = scales::number_format(suffix = " Horas")
                       )),
          data_limite = colDef(show = F),
          lat = colDef(show = F),
          lon = colDef(show = F),
          cor_vencimento = colDef(show = F),
          tempo_restante = colDef(show = F)
        )
      )
  })  
  
  # ----
  output$p_map_tab <- renderUI({
    
    if(input$c_view %in%  c("Rondas Pendentes","Atendimentos Pendentes")){
      htmltools::browsable(
        htmltools::tagList(mapa(), tbl())
        )
    } else if(input$c_view == "Atendimentos Realizados" ){
      htmltools::browsable(
        htmltools::tagList(mapa_at(), tbl_at())
        )
    } else{
      htmltools::browsable(
        htmltools::tagList(mapa_oc(), tbl_oc())
      )
    }
    
  })
  
}

shinyApp(ui, server)
