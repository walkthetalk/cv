tex_name=main

pdf_name=cv

dir_self := $(shell dirname $(shell readlink -fe $(lastword ${MAKEFILE_LIST})))
dir_main := $(shell readlink -fe ${dir_self})

tex_deps:=$(shell find . -type f -name \*.tex)
tex_deps+=$(shell find . -type f -name \*.bib)
tex_deps+=$(shell find . -type f -name \*.lua)
tex_deps+=$(shell find . -type f -name \*.mkiv)

define clean_misc =
	rm -f $(tex_name).aux $(tex_name).bbl $(tex_name).blg $(tex_name).log $(pdf_name).tuc
endef


.PHONY: all
all: $(pdf_name).pdf

.PHONY: clean
clean:
	@rm -f $(pdf_name).pdf
	@$(call clean_misc)

$(pdf_name).pdf: $(tex_deps) $(eps_files)
	@echo [gen] $@
	@context --purge --environment=env_cmm --path=$(dir_main)/env/ --result=$(pdf_name).pdf $(tex_name).tex; $(call clean_misc)
