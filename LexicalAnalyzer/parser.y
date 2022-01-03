%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int temp_variable = 1;

/* function prototypes here */
    extern int yylex();
    void yyerror(char *msg);

%}

%start program

%union {
    char[10] num;
    char[20] id;
    char[5] relop;
    char[50] nonterminal;
    int keyword;
}



%token <num> number
%token <id> id
%token <relop> RELOP
%token <keyword> if else for while in range

%type <nonterminal> block stmts stmt expr rel add term factor


%%

program : block                                 {;}
        ;

block   : '{' stmts '}'                         {;}
        | stmts                                 {;}
        ;

stmts   : stmts stmt                            {;}
        |                                       {;}
        ;

stmt    : expr ';'                              {strcpy($$, $1);}
        | block                                 {;}
        ;

expr    :  rel '=' expr                         {strcpy($$, $3); printf("%s = %s ;\n", $1, $3);}
        |  rel                                  {strcpy($$, $1);}
        ;


rel     :  rel RELOP add                        {sprintf($$, "t%d", temp_variable++); printf("%s = %s %s %s;\n", $$, $1, $2, $3);}
        |  add                                  {strcpy($$, $1);}
        ;


add     :  add '+' factor                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s + %s;\n", $$, $1, $3);}
	    |  add '-' factor                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s - %s;\n", $$, $1, $3);}
        |  factor                                 {strcpy($$, $1);}
        ;


factor  : '(' expr ')'                          {strcpy($$ , $2);}
        | '-' factor                            {strcpy($$ , -$2);}
        | number                                {strcpy($$ , $1);}
        | id                                    {strcpy($$ , $1);}
        ;

%%


void yyerror(char *msg) {
    fprintf(stderr,"%s\n",msg);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}


