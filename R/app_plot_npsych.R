# load libraries
library(shiny)
library(DT)
library(dplyr)
library(readr)
library(ggplot2)
library(ggthemes)
library(here)
library(shinyBS)
library(shinyjs)

dat <- neurocog[,1:12]

# shiny
ui <- fluidPage(uiOutput("modals"),
                DTOutput("table"))

server <- function(input, output, session) {

  buttons <- lapply(1:ncol(dat), function(i) {
    actionButton(
      paste0("this_id_is_not_used", i),
      "plot",
      class = "btn-primary btn-sm",
      style = "border-radius: 50%;",
      onclick = sprintf(
        "Shiny.setInputValue('button', %d, {priority:'event'});
        $('#modal%d').modal('show');",
        i,
        i
      )
    )
  })

  output[["table"]] <- renderDT({
    sketch <- tags$table(class = "row-border stripe hover compact",
                         tableHeader(c("", names(dat))),
                         tableFooter(c("", buttons)))
    datatable(dat,
              container = sketch,
              options =
                list(columnDefs = list(
                  list(className = "dt-center",
                       targets = "_all")
                )))
  })

  # modals ####
  output[["modals"]] <- renderUI({
    lapply(1:ncol(dat), function(i) {
      bsModal(
        id = paste0("modal", i),
        title = names(dat)[i],
        trigger = paste0("this_is_not_used", i),
        if (is.numeric(dat[[i]]) && length(unique(dat[[i]])) > 1) {
          fluidRow(column(5, radioButtons(
            paste0("radio", i),
            "",
            c("domain", "subdomain"),
            inline = TRUE
          )),
          column(
            7,
            conditionalPanel(
              condition = sprintf("input.radio%d=='domain'", i),
              conditionalPanel(condition = sprintf("input.radio%d=='subdomain'", i),)
            )
          ))
        },
        plotOutput(paste0("plot", i))
      )
    })
  })

  # plots in modals ####
  for (i in 1:ncol(dat)) {
    local({
      ii <- i
      output[[paste0("plot", ii)]] <- renderPlot({
        if (is.numeric(dat[[ii]]) && length(unique(dat[[ii]])) > 1) {
          if (input[[paste0("radio", ii)]] == "domain") {
            ggplot(dat,
                   aes(x = z, y = reorder(domain, z))) +
              geom_segment(aes(xend = 0, yend = domain), size = 1) +
              geom_point(shape = 21, size = 8, color = "black", fill = "orange"
              ) +
              theme_fivethirtyeight() +
              # Set the entire chart region to a light gray color
              theme(panel.background = element_rect(fill = "white")) +
              theme(plot.background = element_rect(fill = "white")) +
              theme(panel.border = element_rect(colour = "white"))
          } else{
            ggplot(dat,
                   aes(x = z, y = reorder(subdomain, z))) +
              geom_segment(aes(xend = 0, yend = subdomain), size = 1) +
              geom_point(shape = 21,size = 8,color = "black", fill = "orange") +
              theme_fivethirtyeight() +
              # Set the entire chart region to a light gray color
              theme(panel.background = element_rect(fill = "white")) +
              theme(plot.background = element_rect(fill = "white")) +
              theme(panel.border = element_rect(colour = "white"))
          }

        }
      })
    })
  }
}

shinyApp(ui, server)
