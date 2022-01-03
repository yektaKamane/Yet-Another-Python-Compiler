%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int IF = 256;
    int ELSE = 257;
    int WHILE = 258;
    int FOR = 259;
    int RANGE = 260;
    int IN = 261;

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
    char[5] arith;
    char[50] nonterminal;
    int keyword;
}



%token <num> NUMBER
%token <id> ID
%token <arith> ARITH 
%token <relop> RELOP
%token <keyword> IF, ELSE, WHILE, FOR, IN, RANGE

%type <nonterminal> program, block, stmts, stmt, expr


%left '*' '/' '//' '%'
%left '+' '-'
%right '**' '='


%%

program : block                                 {;}
        ;

block   : '{' stmts '}'                         {;}
        | stmts                                 {;}
        ;

stmts   : stmts stmt                            {;}
        | 
        ;

stmt    : expr                                  {strcpy($$, $1);}
        |  if ( expr ) stmt                     {;}
        |  if ( expr ) stmt else stmt           {;}
        |  while ( expression ) stmt            {;}
        |  for id in range ( number ) stmt      {;}
        |  block                                {;}
        ;

expr    :  rel '=' expr                         {strcpy($$, $3); printf("%s = %s ;\n", $1, $3);}
        |  rel                                  {strcpy($$, $1);}
        ;


rel     :  rel '<'  add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s <  %s;\n", $$, $1, $3);}
        |  rel "<=" add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s <= %s;\n", $$, $1, $3);}
        |  rel '>'  add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s >  %s;\n", $$, $1, $3);}
        |  rel ">=" add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s >= %s;\n", $$, $1, $3);}
        |  rel "==" add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s == %s;\n", $$, $1, $3);}
        |  rel "!=" add                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s != %s;\n", $$, $1, $3);}
        |  add                                  {strcpy($$, $1);}
        ;


add     :  add '+' term                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s + %s;\n", $$, $1, $3);}
	    |  add '-' term                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s - %s;\n", $$, $1, $3);}
        |  term                                 {strcpy($$, $1);}
        ;


term    :  term  '*'   power                    {sprintf($$, "t%d", temp_variable++); printf("%s = %s * %s;\n", $$, $1, $3);}                
	    |  term  '/'   power                    {sprintf($$, "t%d", temp_variable++); printf("%s = %s / %s;\n", $$, $1, $3);}
        |  term  "//"  power                    {sprintf($$, "t%d", temp_variable++); printf("%s = %s // %s;\n", $$, $1, $3);}
        |  term  '%'   power                    {sprintf($$, "t%d", temp_variable++); printf("%s = %s % %s;\n", $$, $1, $3);}
	    |  power                                {strcpy($$ , $1);}
        ;


power   : factor "**" power                     {sprintf($$, "t%d", temp_variable++); printf("%s = %s ** %s;\n", $$, $1, $3);}
        | factor                                {strcpy($$, $1);}
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


