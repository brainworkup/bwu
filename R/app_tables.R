library(shiny)
library(DT)

rowNames <- FALSE # whether to show row names in the table
colIndex <- as.integer(rowNames)

neurocog[, "date"] <- ""

df <- cbind(Selected = "remove", neurocog)

colDate <- which(names(df) == "date")

callback <- c(
  "$.contextMenu({",
  "  selector: '#table th',",
  "  trigger: 'right',",
  "  autoHide: true,",
  "  items: {",
  "    text: {",
  "      name: 'Enter column header:',",
  "      type: 'text',",
  "      value: ''",
  "    }",
  "  },",
  "  events: {",
  "    show: function(opts){",
  "      $.contextMenu.setInputValues(opts, {text: opts.$trigger.text()});",
  "    },",
  "    hide: function(opts){",
  "      var $this = this;",
  "      var data = $.contextMenu.getInputValues(opts, $this.data());",
  "      var $th = opts.$trigger;",
  "      $th.text(data.text);",
  "    }",
  "  }",
  "});"
)

ui <- fluidPage(
  tags$head(
    tags$link(
      rel = "stylesheet",
      href = "https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.css"
    ),
    tags$script(
      src = "https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"
    )
  ),
  DTOutput("table")
)
server <- function(input, output){
  output[["table"]] <- renderDT({
    datatable(neurocog[,1:10],
              callback = JS(callback),
              rownames = rowNames,
              extensions = c("Select", "Buttons", "Responsive"),
              selection = "none",
              options = list(
                dom = "BRSPQfrtip",
                buttons = list("copy", "csv", "pdf", "colvis"),
                select = list(
                  style = 'multiple',
                  items = 'row',
                  selector = "td:not(.notselectable)"
                ),
                responsive = TRUE)
              )
  }, server = FALSE)
}
shinyApp(ui, server)
