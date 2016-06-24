%{
#include <stdio.h>
#include "latexTOhtml.h"
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
%token <string> NOME
%token <string> CONTEUDO

%start start

%%

start:
      conf inicio progLatex
      | TITULO RCHV conteudo LCHV                      {title();}
    ;
progLatex:
      corpo fim
    | corpoAninhado fim
    ;
conf:
      classe TITULO RCHV conteudo LCHV                      {title();}
    | classe AUTOR RCHV conteudo LCHV TITULO RCHV conteudo LCHV
    ;
classe:
      CLASSE RCHV NOME LCHV
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
      CAPITULO RCHV conteudo LCHV
    ;
secao:
      SECAO RCHV conteudo LCHV
    ;
subsecao:
      SUBSECAO RCHV conteudo LCHV
    ;
corpo:
    | corpo texto
    | corpo listaNumerada
    | corpo listaItens
    | corpo conteudo
    ;
texto:
      PARAGRAFO RCHV conteudo LCHV
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
conteudo:
      CONTEUDO                                              {list_insert(in_listG, $1);}
    | conteudo NEGRITO RCHV conteudo LCHV                   {black();}
    | conteudo SUBLINHADO RCHV conteudo LCHV                {underline();}
    | conteudo ITALICO RCHV conteudo LCHV                   {italic();}
    ;
begin:
      T_BEGIN RCHV
    ;
