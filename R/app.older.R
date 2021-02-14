# load libraries
library(shiny)
library(DT)
library(knitr)
library(kableExtra)
library(dplyr)
library(readr)
library(googlesheets4)
library(lubridate)
library(here)
library(purrr)
library(glue)
library(gt)
library(tibble)
library(forcats)
gs4_deauth()




# Callbacks
callback <- c(
  sprintf("table.on('click', 'td:nth-child(%d)', function(){", colIndex+1),
  "  var td = this;",
  "  var cell = table.cell(td);",
  "  var $row = $(td).closest('tr');",
  sprintf("  var cell_date = table.cell($row[0], %d);", colDate + colIndex - 1),
  "  var today = new Date();",
  "  var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();",
  "  if(cell.data() === 'ok'){",
  "    cell.data('remove');",
  "    cell_date.data('');",
  "  } else {",
  "    cell.data('ok');",
  "    cell_date.data(date);",
  "  }",
  "  $row.toggleClass('excluded');",
  "  var excludedRows = [];",
  "  table.$('tr').each(function(i, row){",
  "    if($(this).hasClass('excluded')){",
  "      excludedRows.push(parseInt($(row).attr('id').split('_')[1]))",
  "    }",
  "  });",
  "  Shiny.setInputValue('excludedRows', excludedRows);",
  "})"
)
restore <- c(
  "function(e, table, node, config) {",
  "  table.$('tr').removeClass('excluded').each(function(){",
  sprintf("    var td = $(this).find('td').eq(%d)[0];", colIndex),
  "    var cell = table.cell(td);",
  "    cell.data('remove');",
  "  });",
  "  Shiny.setInputValue('excludedRows', null);",
  "}"
)
render <- c(
  'function(data, type, row, meta){',
  '  if(type === "display"){',
  '    var color = data === "remove" ? "red" : "forestgreen";',
  '    return "<span style=\\\"color:" + color +',
  '           "; font-size:18px\\\"><i class=\\\"glyphicon glyphicon-" +',
  '           data + "\\\"></i></span>";',
  '  } else {',
  '    return data;',
  '  }',
  '}'
)

ui <- fluidPage(tags$head(tags$style(
  HTML(".excluded { color: rgb(211,211,211); font-style: italic; }")
)),

br(),
DTOutput("mytable"))
server <- function(input, output, session) {
  output$mytable <- renderDataTable({
    datatable(
      df,
      rownames = rowNames,
      extensions = c("Select", "Buttons", "Responsive"),
      selection = "none",
      callback = JS(callback),
      options = list(
        scrollY = "700px",
        paging = FALSE,
        scrollCollapse = TRUE,
        rowId = JS(
          sprintf("function(df){return df[%d];}",
                  ncol(df) - 1 + colIndex)
        ),
        columnDefs = list(
          list(visible = FALSE, targets = ncol(df) - 1 + colIndex),
          list(className = "dt-center", targets = "_all"),
          list(className = "notselectable", targets = colIndex),
          list(targets = colIndex, render = JS(render))
        ),
        dom = "BRSPQfrtip",
        buttons = list("copy", "csv", "pdf", "colvis"),
        list(
          extend = "collection",
          text = 'Unselect all rows',
          action = JS(restore)
        ),
        select = list(
          style = 'os',
          items = 'row',
          selector = "td:not(.notselectable)"
        ),
        responsive = TRUE
      )
    )
  }, server = FALSE)


}

shinyApp(ui, server)
