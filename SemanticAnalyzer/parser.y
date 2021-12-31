%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();

// function prototypes here

%}

%token LE_OP GE_OP EQ_OP NE_OP
%token IF, ELSE, WHILE, FOR, IN, RANGE

%%





%%

void yyerror(char *msg)  {
    fprintf(stderr,"%s\n",msg);
    exit(1);
}

int main(){
    yyparse();
    return 0;
}