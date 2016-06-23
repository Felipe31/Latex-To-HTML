#ifndef _LATEXTOHTML_
#define _LATEXTOHTML_
// ibison
extern int yylineno;
extern FILE* yyin;
int yyparse(void);
int yylex();



typedef struct list{
    char * string;
    struct list * next;
    struct list * pred;
} list;

typedef struct head_list
{
    list * first;
    list * last;
} head_list;

/*************************************************************************************************
**************************************************************************************************
*************************************** VARIÁVEIS GLOBAIS ****************************************
**************************************************************************************************
*************************************************************************************************/
FILE * arqG;
head_list * in_listG;

void title();
void black();
void underline();
void italic();


/*************************************************************************************************
**************************************************************************************************
************************************* ALGORITMOS AUXILIARES **************************************
**************************************************************************************************
*************************************************************************************************/

char * pTOp(char * text);
// char * capture_data();
char * capture_from(head_list * lista);
head_list * list_new();
list * list_insert(head_list* fila, char * v_list);
char * list_remove(head_list* fila);
char * list_remove_last(head_list* lista);
#endif
