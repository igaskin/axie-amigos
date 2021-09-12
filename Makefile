# Settings
JEKYLL=bundle config set --local path .vendor/bundle && bundle install && bundle update && bundle exec jekyll
DST=_site

## I. Commands for both workshop and lesson websites
## =================================================

.PHONY: site docker-serve repo-check clean clean-rmd

## * serve            : render website and run a local server
serve :
	${JEKYLL} serve

## * site             : build website but do not run a server
site :
	${JEKYLL} build

## * docker-serve     : use Docker to serve the site
docker-serve :
	@docker pull carpentries/lesson-docker:latest
	@docker run --rm -it \
		-v $${PWD}:/home/rstudio \
		-p 4000:4000 \
		-p 8787:8787 \
		-e USERID=$$(id -u) \
		-e GROUPID=$$(id -g) \
		carpentries/lesson-docker:latest


## * clean            : clean up junk files
clean :
	@rm -rf ${DST}
	@rm -rf .sass-cache
	@rm -rf bin/__pycache__
	@rm -rf .vendor
	@rm -rf .bundle
	@rm -f Gemfile.lock
	@find . -name .DS_Store -exec rm {} \;
	@find . -name '*~' -exec rm {} \;
	@find . -name '*.pyc' -exec rm {} \;

## * clean-rmd        : clean intermediate R files (that need to be committed to the repo)
clean-rmd :
	@rm -rf ${RMD_DST}
	@rm -rf fig/rmd-*
