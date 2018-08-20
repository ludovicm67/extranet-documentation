# Useful variables:
SCRIPTS = $(wildcard *.sh)
DOC_FILES = $(wildcard *.md)

# Build all targets (default)
.PHONY: all
all: pdf

# Building the pdf file
doc.pdf: $(DOC_FILES)
	@./generate_pdf.sh

# Targets to call manually
.PHONY: doc
doc: doc.pdf

.PHONY: pdf
pdf: doc

.PHONY: clean
clean:
	rm -f ./*.pdf

# if needed…
.PHONY: exec
exec:
	chmod +x $(SCRIPTS)
