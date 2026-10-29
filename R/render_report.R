# Run this script from the project root.
project_root <- normalizePath(".")

dir.create(
  file.path(project_root, "reports"),
  recursive = TRUE,
  showWarnings = FALSE
)

rmarkdown::render(
  input = file.path(project_root, "report", "report.Rmd"),
  output_file = "report.html",
  output_dir = file.path(project_root, "reports"),
  knit_root_dir = project_root
)
