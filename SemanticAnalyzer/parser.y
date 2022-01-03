%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();

// function prototypes here

%}

%union{
    char[10] num;
    char[20] id;
    char[5] relop;
    char[5] arith;
}

%token<> 
%token<> IF, ELSE, WHILE, FOR, IN, RANGE
%type<> program, block, stmts, stmt, expr

%%

program : block         {$$ = $1;}
         ;

block   : { stmts }     {$$ = $2;}
         ;

stmts   : stmts stmt    {$$ = }
        | 
        ;

stmt    : expr                                  {$$ = $1;}
        |  if ( expr ) stmt                     {$$;}
        |  if ( expr ) stmt else stmt           {;}
        |  while ( expression ) stmt            {;}
        |  for id in range ( number ) stmt      {;}
        |  block                                {;}
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