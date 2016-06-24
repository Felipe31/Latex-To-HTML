latexTOhtml: latexTOhtml.l latexTOhtml.y latexTOhtml.c
	bison -d latexTOhtml.y
	flex latexTOhtml.l
	gcc latexTOhtml.c latexTOhtml.tab.c lex.yy.c -lfl

debug:
	bison -d latexTOhtml.y --debug -r all
	flex latexTOhtml.l
	gcc latexTOhtml.c latexTOhtml.tab.c lex.yy.c -lfl

clean:
	rm latexTOhtml.tab.* lex.yy.c
