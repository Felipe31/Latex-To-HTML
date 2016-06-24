latexTOhtml: latexTOhtml.l latexTOhtml.y latex2html.c
	bison -d latexTOhtml.y
	flex latexTOhtml.l
	gcc latex2html.c latexTOhtml.tab.c lex.yy.c -lfl -g

debug:
	bison -d latexTOhtml.y --debug -r all
	flex latexTOhtml.l
	gcc latex2html.c latexTOhtml.tab.c lex.yy.c -lfl -g

clean:
	rm latexTOhtml.tab.* lex.yy.c
