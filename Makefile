latexTOhtml: latexTOhtml.l latexTOhtml.y latexTOhtml.c
	bison -d latexTOhtml.y
	flex latexTOhtml.l
	gcc -o latexTOhtml latexTOhtml.tab.c latexTOhtml.c  lex.yy.c -lfl

flex: latexTOhtml.l
	flex latexTOhtml.l
	gcc -o $@ lex.yy.c -lfl

clear:
	rm latexTOhtml.tab.* lex.yy.c latexTOhtml
