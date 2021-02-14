## Render Neuropsych Reports with Pagedown

render_report <- function(input) {

  require(rmarkdown)
  require(pagedown)

  output <- rmarkdown::render(
    input = input,
    output_format = "pagedown::book_crc",
    params = "ask"
    )

  pagedown::chrome_print(
    output,
    paste0(patient, "_", "npsych-report", "_", Sys.Date(), ".pdf"))

}

patient <- "Smalls-Biggie"

render_report("index_kb2.Rmd")
