%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();

// function prototypes here

%}

%union{
    
}

%token<> LE_OP GE_OP EQ_OP NE_OP
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