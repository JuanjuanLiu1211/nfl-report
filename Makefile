.PHONY: all preview

all: reports/report.html

output/tables/yujing_summary.csv: data/nfl_leaders.csv R/yujing_summary.R
	mkdir -p output/tables
	Rscript R/yujing_summary.R
	test -f $@

output/figures/jitong_rankings.png: data/nfl_leaders.csv config.yml R/jitong_rankings.R
	mkdir -p output/figures
	Rscript R/jitong_rankings.R
	test -f $@

output/figures/kyurhi_relationship.png: data/nfl_leaders.csv R/kyurhi_relationship.R
	mkdir -p output/figures
	Rscript R/kyurhi_relationship.R
	test -f $@

reports/report.html: report/report.Rmd R/render_report.R config.yml \
	output/tables/yujing_summary.csv \
	output/figures/jitong_rankings.png \
	output/figures/kyurhi_relationship.png
	Rscript R/render_report.R

preview:
	Rscript R/render_report.R
