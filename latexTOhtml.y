%{
#include <stdio.h>
#include "latexTOhtml.h"
// extern int yydebug;
// #define YYDEBUG 1
// yydebug = 1;
%}

%union{
    char *string;
}

%token NEGRITO
%token SUBLINHADO
%token ITALICO
%token <string> TITULO
%token AUTOR
%token CLASSE
%token RCHV
%token LCHV
%token T_BEGIN
%token END
%token DOCUMENT
%token SECAO
%token SUBSECAO
%token PARAGRAFO
%token ENUMERATE
%token ITEMIZE
%token ITEM
%token CAPITULO
%token <string> COMENTARIO
%token <string> ARTICLE
%token <string> CONTEUDO

%start starte

%%

starte:
      conf inicio progLatex
    ;
progLatex:
      corpo fim
    | corpoAninhado fim
    ;
conf:
      classe TITULO RCHV tag LCHV                      {title();}
    | classe AUTOR RCHV tag LCHV TITULO RCHV tag LCHV
    ;
classe:
      CLASSE RCHV ARTICLE LCHV
    ;
inicio:
      begin DOCUMENT LCHV
    ;
fim:
      END RCHV DOCUMENT LCHV
    ;
corpoAninhado: capitulo corpo secao corpo subsecao corpo
    | capitulo corpo secao corpo subsecao corpo corpoAninhado
    ;
capitulo:
      CAPITULO RCHV tag LCHV
    ;
secao:
      SECAO RCHV tag LCHV
    ;
subsecao:
      SUBSECAO RCHV tag LCHV
    ;
corpo:
    | corpo texto
    | corpo listaNumerada
    | corpo listaItens
    | corpo tag                                         {print_file();}
    ;
texto:
      PARAGRAFO RCHV tag LCHV
    ;
listaNumerada:
      enumerate itens END RCHV ENUMERATE LCHV
    | enumerate sublistas END RCHV ENUMERATE LCHV
    ;
enumerate:
      begin ENUMERATE LCHV
    ;
listaItens:
      itemize itens END RCHV ITEMIZE LCHV
    | itemize sublistas END RCHV ITEMIZE LCHV
    ;
itemize:
      begin ITEMIZE LCHV
    ;
itens:
      item CONTEUDO LCHV
    | item CONTEUDO LCHV itens
    ;
item:
      ITEM RCHV
    ;
sublistas:
    | listaNumerada
    | listaItens
    ;
tag:
    | tag conteudo
    | tag NEGRITO RCHV tag LCHV                    {bold();}
    | tag SUBLINHADO RCHV tag LCHV                 {underline();}
    | tag ITALICO RCHV tag LCHV                    {italic();}
    ;

conteudo:
      CONTEUDO                                              {conteudo($1);}
    ;
begin:
      T_BEGIN RCHV
    ;
