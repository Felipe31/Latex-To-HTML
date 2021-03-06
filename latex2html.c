#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "latexTOhtml.h"
#include "latexTOhtml.tab.h"

int yyerror(const char *s)
{
  printf("Error %s", s);
  exit(1);
}

void title()
{
    flag_printG = -1;
    include_tag("","");
    char * head = capture_from(in_listG);
    if(!head)
    {
        puts("Erro no h1!");
        return;
    }
    // char * title = capture_from(title_listG);
    // if(!title)
    // {
        // puts("Erro no título!");
        // return;
    // }
    fprintf(arqG, "<!doctype html>\n<html>\n<head>\n");
    // fprintf(arqG, "<title>%s</title>\n", title);
    fprintf(arqG, "</head>\n<body>\n");
    fprintf(arqG, "<center><h1>%s</h1></center>\n", head);
    flag_printG = 0;
}

void numerate()
{
    taG = 8;
    Nnumerate++;
    include_tag("<ol>", "</ol>");
    Nnumerate = 0;
}
void itemize()
{
    taG = 8;
    Nnumerate++;
    include_tag("<ul>", "</ul>");
    Nnumerate = 0;
}

void conteudo(char * cont)
{
    switch (taG) {
        case 1:     Nneg++; break;
        case 2:     Nunder++; break;
        case 3:     Nit++; break;
        case 4:     Nparagraph++; break;
        case 5:     Nchapter++; break;
        case 6:     Nsection++; break;
        case 7:     Nsubsection++; break;
        case 10:    Nitem++; break;

    }
    list_insert(in_listG, cont);
}


/*************************************************************************************************
**************************************************************************************************
************************************* ALGORITMOS AUXILIARES **************************************
**************************************************************************************************
*************************************************************************************************/

//void yyerror(const char *s, ...){}

void print_file()
{
    fprintf(arqG, "%s\n", capture_from(in_listG));
}

char * pTOp(char * text)
{
    int i = strlen(text);
    char * new = (char *) calloc(i, sizeof(char));
    for(; i > 0; i--)
    {
        new[i-1] = text[i-1];
    }
    return new;
}

int include_tag(char * open, char * close)
{
    char * aux;
    int N = 1;

    switch (taG) {
        case 1:     N = Nneg; break;
        case 2:     N = Nunder; break;
        case 3:     N = Nit; break;
        case 4:     N = Nparagraph; break;
        case 5:     N = Nchapter; break;
        case 6:     N = Nsection; break;
        case 7:     N = Nsubsection; break;
        case 8:     N = Nnumerate; break;
        case 9:     N = Nitemize; break;
        case 10:    N = Nitem; Nnumerate++;break;
    }

    taG = Nunder = Nneg = Nit = Nparagraph = Nchapter = Nsection = Nsubsection = Nitem = 0;

    char * in = capture_n_last(in_listG, N);
    if(!in) return -1;

    char * data = (char *) calloc(20000, sizeof(char));
    strcat(data, open);
    strcat(data, in);
    strcat(data, close);
    list_insert(in_listG, data);
    return 0;
}

char * capture_from(head_list * lista)
{
    char * temp, * data = (char *) calloc(10000, sizeof(char));
    temp = list_remove(lista);
    if(!temp) return NULL;

    while(temp)
    {
        strcat(data, temp);
        temp = list_remove(lista);
    }
    return data;
}
char * capture_n_last(head_list * lista, int n)
{
    if(!lista || n < 1) return NULL;
    int i;
    char * v[n];
    char * temp, * data = (char *) calloc(10000, sizeof(char));
    v[0] = list_remove_last(lista);
    if(!temp) return NULL;

    for(i=1; i < n && v[i-1]; ++i)
        v[i] = list_remove_last(lista);

    --i;
    for(; i > -1; --i)
        strcat(data, v[i]);
    return data;
}

head_list * list_new()
{
	return (head_list *) calloc(1, sizeof(head_list));
}

list * list_insert(head_list* lista, char * string)
{
	if(!lista || !string) return NULL;

	list * l = (list *) malloc(sizeof(list));
	if(l)
	{
		l->string = pTOp(string);
		if(lista->last)
        {
			lista->last->next = l;
            l->pred = lista->last;
        }
        else
        {
			lista->first = l;
            l->pred = NULL;
        }

        lista->last = l;
		l->next = NULL;
	}
	return l;
}

char * list_remove(head_list* lista)
{
	if(!lista) return NULL;
	if(!lista->first) return NULL;

    char * string = pTOp(lista->first->string);
	list * aux = lista->first;
    lista->first = lista->first->next;

	if(!lista->first)
		lista->last = NULL;
    else
        lista->first->pred = NULL;

	free(aux);
	return string;
}

char * list_remove_last(head_list* lista)
{
	if(!lista) return NULL;
	if(!lista->first) return NULL;

    char * string = pTOp(lista->last->string);
    list * aux = lista->last;

    lista->last = lista->last->pred;
    if(lista->last)
        lista->last->next = NULL;
    else
        lista->first = NULL;

	free(aux);
	return string;
}

/**************************************************************************************************
***************************************************************************************************
**                          ****    ****  ************  **  ****     **                          **
**                          ** **  ** **  **        **  **  ** **    **                          **
**                          **   **   **  **        **  **  **  **   **                          **
**                          **        **  ************  **  **   **  **                          **
**                          **        **  **        **  **  **    ** **                          **
**                          **        **  **        **  **  **     ****                          **
***************************************************************************************************
**************************************************************************************************/
int main(int argc, char const *argv[])
{

    arqG = fopen(".//saida.html","w");
    in_listG = list_new();
    title_listG = list_new();
    flag_printG = -1; // indica que <title> nao foi executado
    taG = Nunder = Nneg = Nit = Nparagraph = Nchapter = Nsection = Nsubsection = Nnumerate = Nitemize = Nitem = 0;

    yyin = fopen("teste.in", "r");
    if (!yyin) return -1;

    yyparse();

    fclose(yyin);
    fclose(arqG);

}
