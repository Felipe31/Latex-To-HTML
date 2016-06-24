%option noyywrap
%{
#include <string.h>
#include "latexTOhtml.h"
#include "latexTOhtml.tab.h"
%}

ENUMERATE   "enumerate"
ARTICLE     "article"
ITEM        "item"
ITEMIZE     "itemize"
DOCUMENT    "document"
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
COMENTARIO  "%"(.)*\n
ESPACO      " "
SIMBOLOS    ("!"|"?"|"."|","|"("|")")
CONTEUDO    ({letra}|{letraM}|{digito}|{ESPACO}|{SIMBOLOS})*

%%
[\t\n]
{DOCUMENT}      { puts("DOCUMENT"); return DOCUMENT; }
{ENUMERATE}     { puts("ENUMERATE"); return ENUMERATE; }
{ITEMIZE}       { puts("ITEMIZE"); return ITEMIZE; }
{ITEM}          { puts("ITEM"); return ITEM; }
{NEGRITO}       { puts("NEGRITO"); taG = 1; return NEGRITO;}
{SUBLINHADO}    { puts("SUBLINHADO"); taG = 2; return SUBLINHADO;}
{ITALICO}       { puts("ITALICO"); taG = 3; return ITALICO;}
{TITULO}        { puts("TITULO"); return TITULO;}
{AUTOR}         { puts("AUTOR"); return AUTOR;}
{CLASSE}        { puts("CLASSE"); return CLASSE;}
{ARTICLE}       { puts("ARTICLE"); return ARTICLE;}
{COMENTARIO}    { puts("COMENTARIO"); yylval.string = pTOp(yytext); return COMENTARIO;}
{CONTEUDO}      { puts("CONTEUDO"); yylval.string = pTOp(yytext); return CONTEUDO;}
{ESPACO}        { puts("ESPACO???????????????????????"); yylval.string = pTOp(" "); return CONTEUDO;}
{LCHV}          { puts("LCHV"); return LCHV; }
{RCHV}          { puts("RCHV"); return RCHV; }
{T_BEGIN}       { puts("T_BEGIN"); return T_BEGIN; }
{END}           { puts("END"); return END; }
{CAPITULO}      { puts("CAPITULO"); return CAPITULO; }
{SECAO}         { puts("SECAO"); return SECAO; }
{SUBSECAO}      { puts("SUBSECAO"); return SUBSECAO; }
{PARAGRAFO}     { puts("PARAGRAFO"); return PARAGRAFO; }
