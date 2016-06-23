#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "latexTOhtml.h"

void title()
{
    char * title = capture_from(in_listG);
    if(!title)
    {
        puts("Erro no título!");
        return;
    }
    printf("%s\n", title);
    fprintf(arqG, "<!doctype html>\n<html>\n<head>\n");
    //fprintf(arqG, "<title>%s</title>\n", title2);
    fprintf(arqG, "</head>\n<body>\n");
    fprintf(arqG, "<center><p>%s</p></center>\n", title);
}
void black()
{
    char * in = list_remove_last(in_listG);
    char * data = (char *) calloc(20000, sizeof(char));
    strcat(data, "<b>");
    strcat(data, in);
    strcat(data, "</b>");
    printf("%s\n",data );
    list_insert(in_listG, data);
}

void underline()
{
}

void italic()
{
}



/*************************************************************************************************
**************************************************************************************************
************************************* ALGORITMOS AUXILIARES **************************************
**************************************************************************************************
*************************************************************************************************/

void yyerror(char *s, ...){}

char * pTOp(char * text)
{
    int i = strlen(text);
    char * new = (char *) malloc(sizeof(char)*i);
    for(; i > 0; i--)
    {
        new[i-1] = text[i-1];
    }

    return new;
}
//
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
//char * capture_tag()
// /{
    // char * temp, * data = (char *) calloc(10000, sizeof(char));
//
//
    // temp = list_remove(tag_listG);
//     while(temp)
//     {
//         strcat(data, temp);
//         temp = list_remove(tag_listG);
//     }
//
//     temp = list_remove(h_listG);
//     while(temp)
//     {
//         strcat(data, temp);
//         temp = list_remove(h_listG);
//     }
//
//     temp = list_remove(tag_listG);
//     while(temp)
//     {
//         strcat(data, temp);
//         temp = list_remove(tag_listG);
//     }
//
//     return data;
// }

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

	char * string = lista->first->string;
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

    char * string = lista->last->string;
    list * aux = lista->last;

    lista->last = lista->last->pred;

	free(aux);
	return string;
}

/*************************************************************************************************
**************************************************************************************************
************************************ ALGORITMOS AUXILIARES **************************************
**************************************************************************************************
*************************************************************************************************/
/*
!!              ****    ****  ************  **  ****     **             !!
!!              ** **  ** **  **        **  **  ** **    **             !!
!!              **   **   **  **        **  **  **  **   **             !!
!!              **        **  ************  **  **   **  **             !!
!!              **        **  **        **  **  **    ** **             !!
!!              **        **  **        **  **  **     ****             !!
*/

int main(int argc, char const *argv[])
{

    arqG = fopen(".//saida.html","w");
    in_listG = list_new();

    yyin = fopen("teste.in", "r");
    if (!yyin) return -1;

    yyparse();

    fclose(yyin);
    fclose(arqG);

}
