# NFL Player Statistics Report

A DATA550 group project summarizing NFL quarterback passing performance.

## Team

- Shihan Liu: team lead; project setup, configuration, code review, and report integration.
- Yujing Liu: descriptive statistics table.
- Jitong Jiang: quarterback ranking chart.
- Kyurhi Kim: passing attempts versus passing yards scatterplot.

## Data

Use data/nfl_leaders.csv and include only quarterbacks (Pos = QB).
The CSV contains two columns named Yds. Use the first Yds column
for passing yards; the second represents yards lost to sacks.

## Assigned files

| Member | Analysis script | Generated output |
| --- | --- | --- |
| Yujing | R/yujing_summary.R | output/tables/yujing_summary.csv |
| Jitong | R/jitong_rankings.R | output/figures/jitong_rankings.png |
| Kyurhi | R/kyurhi_relationship.R | output/figures/kyurhi_relationship.png |

## Coding guidelines

- Run scripts from the project root (the nfl-report folder).
- Use relative paths, such as data/nfl_leaders.csv.
- Each script should load its required packages and run independently.
- Calculate results from the data rather than hard-code values.
- Document how missing values are handled.
- Jitong's script should read top_n from config.yml.
- Coordinate changes to shared files with Shihan.

## Collaboration

1. Clone the repository to your computer.
2. Update your local main branch before starting a new task.
3. Create a separate branch for your work.
4. Commit and push your changes to that branch.
5. Open a pull request into main with a description of your changes
   and instructions for running your script.
6. Shihan will review, test, and merge the pull request.

## Run the report

Run these commands from the project folder:

```bash
Rscript -e 'renv::restore()'
make
```

The report will be saved as reports/report.html.

To change the number of players in the ranking chart, edit
top_n in config.yml and run make again.
