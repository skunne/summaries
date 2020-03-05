BUILD = build
NAME = summaries.pdf
UNCITED = uncited_references.txt
FIND_UNCITED = script_python/find_uncited_entries.py
#SRCDIR = src
#SRCFILES = main.tex
#SRC = $(addprefix $(SRCDIR)/,$(SRCFILES))
SRC = summaries.tex
REF = summaries.bib
#CC = pdflatex	#should use latexmk instead
#CC = pdflatex --output-directory=$(BUILD) -interaction=nonstopmode
BIBCC = bibtex
CC = lualatex --output-directory=$(BUILD) -interaction=nonstopmode
#CC = latexmk -pdf -pdflatex="pdflatex --output-directory=$(BUILD) -interaction=nonstopmode" -use-make -auxdir=$(BUILD)

all: $(NAME) $(UNCITED)

$(BUILD):
	mkdir $(BUILD)

$(NAME): $(BUILD) $(REF) $(SRC)
	$(CC) $(SRC)
	$(BIBCC) $(BUILD)/summaries
	mv $(BUILD)/$(NAME) $(NAME)

$(UNCITED): $(SRC) $(REF) $(FIND_UNCITED)
	$(FIND_UNCITED) $(SRC) $(REF) > $(UNCITED)

clean:
	rm -f -- $(addprefix $(BUILD)/*,.aux .log .nav .out .snm .toc)
	#latexmk -CA

#fclean: clean
#	rm -f -- $(NAME)

#re: fclean all
re: clean 2

2: $(UNCITED)
	$(CC) $(SRC)
	$(BIBCC) $(BUILD)/summaries
	$(CC) $(SRC)
	$(CC) $(SRC)
	mv $(BUILD)/$(NAME) $(NAME)

.PHONY: all clean re 2
