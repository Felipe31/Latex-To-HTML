%option noyywrap
%{
#include <string.h>
#include "latexTOhtml.h"
#include "latexTOhtml.tab.h"
%}


ENUMERATE   "enumerate"
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
CONTEUDO    ("---asd"|"---qwerty")
NOME        ({letra}|{letraM})({letra}|{letraM}|{digito})*
COMENTARIO  "%"(.)*\n
ESPACO      [ \t\n]

%%

{DOCUMENT}      { puts("DOCUMENT"); return DOCUMENT; }
{ENUMERATE}     { puts("ENUMERATE"); return ENUMERATE; }
{ITEMIZE}       { puts("ITEMIZE"); return ITEMIZE; }
{ITEM}          { puts("ITEM"); return ITEM; }
{NEGRITO}       { puts("NEGRITO"); return NEGRITO;}
{SUBLINHADO}    { puts("SUBLINHADO"); return SUBLINHADO;}
{ITALICO}       { puts("ITALICO"); return ITALICO;}
{TITULO}        { puts("TITULO"); return TITULO;}
{AUTOR}         { puts("AUTOR"); return AUTOR;}
{CLASSE}        { puts("CLASSE"); return CLASSE;}
{COMENTARIO}    { puts("COMENTARIO"); yylval.string = pTOp(yytext); return COMENTARIO;}
{NOME}          { puts("NOME"); yylval.string = pTOp(yytext); return NOME;}
{CONTEUDO}      { puts("CONTEUDO"); yylval.string = pTOp(yytext); return CONTEUDO;}
{LCHV}          { puts("LCHV"); return LCHV; }
{RCHV}          { puts("RCHV"); return RCHV; }
{T_BEGIN}       { puts("T_BEGIN"); return T_BEGIN; }
{END}           { puts("END"); return END; }
{CAPITULO}      { puts("CAPITULO"); return CAPITULO; }
{SECAO}         { puts("SECAO"); return SECAO; }
{SUBSECAO}      { puts("SUBSECAO"); return SUBSECAO; }
{PARAGRAFO}     { puts("PARAGRAFO"); return PARAGRAFO; }
