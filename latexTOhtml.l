%option noyywrap
%{
#include <string.h>
#include "latexTOhtml.h"
#include "latexTOhtml.tab.h"
%}

ENUMERATE   "enumerate"
ARTICLE     "article"
ITEMIZE     "itemize"
DOCUMENT    "document"
ITEM        "\\item"
NEGRITO     "\\textbf"
SUBLINHADO  "\\underline"
ITALICO     "\\textit"
TITULO      "\\title"
AUTOR       "\\author"
CLASSE      "\\documentclass"
T_BEGIN     "\\begin"
END         "\\end"
CAPITULO    "\\chapter"
SECAO       "\\section"
SUBSECAO    "\\subsection"
PARAGRAFO   "\\paragraph"
RCHV        "{"
LCHV        "}"
letra       [a-z]
letraM 	    [A-Z]
digito 	    [0-9]
espaco      " "
N_LINHA     "\newline"
simbolos    ("!"|"?"|"."|","|"("|")"|"\""|"\'"|"/")
COMENTARIO  "%"(.)*\n
CONTEUDO    ({letra}|{letraM}|{digito}|{simbolos})({letra}|{letraM}|{digito}|{simbolos}|{espaco})*

%%
[\t\n]
{DOCUMENT}      { puts("DOCUMENT"); return DOCUMENT; }
{NEGRITO}       { puts("NEGRITO"); taG = 1; return NEGRITO;}
{SUBLINHADO}    { puts("SUBLINHADO"); taG = 2; return SUBLINHADO;}
{ITALICO}       { puts("ITALICO"); taG = 3; return ITALICO;}
{PARAGRAFO}     { puts("PARAGRAFO"); taG = 4; return PARAGRAFO; }
{CAPITULO}      { puts("CAPITULO"); taG = 5; return CAPITULO; }
{SECAO}         { puts("SECAO"); taG = 6; return SECAO; }
{SUBSECAO}      { puts("SUBSECAO"); taG = 7; return SUBSECAO; }
{ENUMERATE}     { puts("ENUMERATE"); taG = 8; return ENUMERATE; }
{ITEMIZE}       { puts("ITEMIZE"); taG = 9; return ITEMIZE; }
{ITEM}          { puts("ITEM"); taG = 10; return ITEM; }
{TITULO}        { puts("TITULO"); return TITULO;}
{AUTOR}         { puts("AUTOR"); return AUTOR;}
{CLASSE}        { puts("CLASSE"); return CLASSE;}
{ARTICLE}       { puts("ARTICLE"); return ARTICLE;}
{COMENTARIO}    { puts("COMENTARIO"); yylval.string = pTOp(yytext); return COMENTARIO;}
{N_LINHA}       { puts("espaco"); yylval.string = pTOp("</br>"); return CONTEUDO;}
{CONTEUDO}      { puts("CONTEUDO"); yylval.string = pTOp(yytext); return CONTEUDO;}
{LCHV}          { puts("LCHV"); return LCHV; }
{RCHV}          { puts("RCHV"); return RCHV; }
{T_BEGIN}       { puts("T_BEGIN"); return T_BEGIN; }
{END}           { puts("END"); return END; }
