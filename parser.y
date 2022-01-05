%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdarg.h>
    #include <ctype.h>

    int whileLableCounter = 1;
    int ifLableCounter = 1;
    int tempVar = 1;
    int elseLableCounter = 1;

   /* prints grammar violation message */

    extern int yylex();
    extern FILE *yyin;
    extern FILE *yyout;
    void yyerror(char *msg);

%}

%start Program


%union{
    int labelCounter;
    char relo[500];
    char id[500];
    char num[500];
    char nonTerminal[500];
}


%token <num> NUM
%token <id> ID
%token <labelCounter> IF ELSE WHILE FOR IN RANGE
%token <relo> RELOP

%type <nonTerminal>  IDs optexpr expr rel add term factor

/* Precedence Operator */

%right '='
%left  RELOP
%left  '-' '+'
%left  '*' '/'
%left  UMINUS 

%%

Program : block                       { ; }
        ;

block   : '{' stmts '}'               { printf("\n"); }
        | stmts                       { printf("\n"); }
        ;

stmts   : stmts  stmt                 { ; }
        | %empty                      
        ;

stmt    : optexpr ';'	              { printf(";\n"); }
        | expr    ';'	              { printf(" "); }


        |IF                           { printf("IF_BEGIN_%d:\n", $1=ifLableCounter++); printf("\n"); }
        '('                           { printf("IF_CONDITION_%d:\n", $1); printf("\n"); }
        expr ')'                      { printf("ifTrue (%s) goto ELSE_CODE_%d;\n", $5, $1); printf("goto IF_CODE_%d;\n", $1); printf("\n"); }
                                      { printf("IF_CODE_%d:\n", $1); }
        stmt                          { printf("goto ELSE_END_%d;\n", $1); }

        |ELSE                          { printf("ELSE_CODE_%d:\n", $1); } 
        stmt                          { printf("ELSE_END_%d:\n", $1); printf("\n"); } 
        

        |WHILE                        { printf("WHILE_BEGIN_%d:\n", $1=whileLableCounter++); printf("\n"); } 
        '('                           { printf("WHILE_CONDITION_%d:\n", $1); printf("\n"); }
        expr ')'                      { printf("ifTrue (%s) goto WHILE_END_%d;\n", $5, $1); printf("goto WHILE_CODE_%d;\n", $1); printf("}\n"); printf("WHILE_CODE_%d:\n", $1); } 
        stmt                          { printf("goto WHILE_CONDITION_%d;\n", $1); printf("\n"); printf("WHILE_END_%d:\n", $1); }

        |block                        
        ;

optexpr:    
        expr                         { strcpy($$, $1); }
        |%empty                      { ; }
        ;

IDs     : IDs ',' ID	             { sprintf($$, "%s, %s", $1, $3); }
	| IDs ',' ID '=' expr	     { sprintf($$, "%s, %s = %s", $1, $3, $5); }
	| ID			     { sprintf($$, "%s",$1);}
	| ID '=' expr	             { sprintf($$, "%s = %s", $1, $3); }
	;


expr    : ID '=' expr               { strcpy($$, $3); printf("%s = %s;\n", $1, $3); }
        | rel                       { strcpy($$, $1); }
        ;

rel     : rel RELOP add             { sprintf($$, "t%d", tempVar++); printf("%s = %s %s %s;\n", $$, $1, $2, $3); }
        | add                       { strcpy($$, $1);}
        ;

add     : add '+' term              { sprintf($$, "t%d", tempVar++); printf("%s = %s + %s;\n", $$, $1, $3); }
        | add '-' term              { sprintf($$, "t%d", tempVar++); printf("%s = %s - %s;\n", $$, $1, $3); }
        | term                      { strcpy($$, $1);}
        ;

term    : term '*' factor           { sprintf($$, "t%d", tempVar++); printf("%s = %s * %s;\n", $$, $1, $3); }
        | term '/' factor           { sprintf($$, "t%d", tempVar++); printf("%s = %s / %s;\n", $$, $1, $3); }
        | factor                    { strcpy($$, $1); }
        ;

factor  : '(' expr ')'              { strcpy($$, $2); }
        | NUM                       { strcpy($$, $1); }
        | ID                        { strcpy($$, $1); }
        ;

%%

void yyerror(char *msg) {
    fprintf(stderr,"%s\n",msg);
    exit(1);
}


int yywrap() {
    return 1;
}

int main() {
   yyparse();
}
