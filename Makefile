BUILD = build
NAME = summaries.pdf
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

all: $(NAME)

$(BUILD):
	mkdir $(BUILD)

$(NAME): $(BUILD) $(REF) $(SRC)
	$(BIBCC) $(BUILD)/summaries
	$(CC) $(SRC)
	mv $(BUILD)/$(NAME) $(NAME)

clean:
	rm -f $(addprefix $(BUILD)/*,.aux .log .nav .out .snm .toc)
	#latexmk -CA

#fclean: clean
#	rm -f $(NAME)

#re: fclean all
re: clean all

2:
	$(CC) $(SRC)
	$(BIBCC) $(REF)
	$(CC) $(SRC)
	mv $(BUILD)/$(NAME) $(NAME)

.PHONY: all clean re 2
