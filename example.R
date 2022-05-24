library(targets)
tar_dir({
  # Parameterized R Markdown:
  report <- "..."
  writeLines(lines, "report.Rmd")

  tar_script({
    options(tidyverse.quiet = TRUE)
    library(tidyverse)
    library(rmarkdown)
    library(tinytex)
    library(tarchetypes)
    list(
      tar_target(my_number, 1),
      tar_target(my_figure, {
        (ggplot(data.frame(x = 1, y = 1)) +
          geom_point(aes(x, y))) %>%
          ggsave(filename = "my_fig.png", plot = ., device = "png")
      }),
      tar_target(latex_file,
        "doc/template.latex", format = "file"
      ),
      tar_render(raw_pdf,
        "./report.Rmd", output_dir = "output/doc/",
        intermediates_dir = "output/doc/", clean = FALSE
      )
    )
  })
  tar_make()
})
