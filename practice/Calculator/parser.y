%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(char *msg);
%}

%union {
    float f;
}

%token <f> NUM
%type  <f> Starter Expr Term Factor
%start Starter

%%

Starter : Expr                              {printf("%f\n", $1);}
        ;

Expr    : Expr '+' Term                     {$$ = $1 + $3;}
        | Expr '-' Term                     {$$ = $1 - $3;}
        | Term                              {$$ = $1;}
        ;

Term    : Term '*' Factor                   {$$ = $1 * $3;}
        | Term '/' Factor                   {$$ = $1 / $3;}
        | Factor                            {$$ = $1;}
        ;


Factor  : '(' Expr ')'                      {$$ =  $2;}
        | '-' Factor                        {$$ = -$2;}
        | NUM                               {$$ =  $1;}
        ;

%%

void yyerror(char *msg)  {
    fprintf(stderr,"%s\n",msg);
    exit(1);
}

int main(){
    yyparse();
    return 0;
}