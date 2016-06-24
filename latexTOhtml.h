#ifndef _LATEXTOHTML_
#define _LATEXTOHTML_
// ibison
extern int yylineno;
extern FILE* yyin;
extern int yyparse(void);
int yylex();
int yyerror ( const char *s);


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
head_list * title_listG;
char * aux;
int flag_printG, Nunder, Nneg, Nit, Nparagraph, Nchapter, Nsection, Nsubsection, Nnumerate, Nitemize, Nitem;
int taG;
/*
NEGRITO = 1
SUBLINHADO = 2
ITALICO = 3
*/
/*************************************************************************************************
**************************************************************************************************
******************************************** FUNCOES *********************************************
**************************************************************************************************
*************************************************************************************************/

void title();
void conteudo(char * cont);
void numerate();
void itemize();



#define bold() \
        include_tag("<b>", "</b>")
#define underline() \
        include_tag("<u>", "</u>")
#define italic() \
        include_tag("<i>", "</i>")
#define paragraph() \
        include_tag("<p>", "</p>")
#define chapter() \
        include_tag("<h2>", "</h2>")
#define section() \
        include_tag("<h3>", "</h3>")
#define subsection() \
        include_tag("<h4>", "</h4>")
#define item() \
        include_tag("<li>", "</li>")


/*************************************************************************************************
**************************************************************************************************
************************************* ALGORITMOS AUXILIARES **************************************
**************************************************************************************************
*************************************************************************************************/

void print_file();
int include_tag(char * open, char * close);
char * pTOp(char * text);
// char * capture_data();
char * capture_from(head_list * lista);
char * capture_n_last(head_list * lista, int n);
head_list * list_new();
list * list_insert(head_list* fila, char * v_list);
char * list_remove(head_list* fila);
char * list_remove_last(head_list* lista);
#endif
