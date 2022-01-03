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
    char* num;
    char* id;
    char* nonterminal;
}



%token <num> NUMBER
%token <id> ID
%type <nonterminal> expr add factor


%%

program : expr                                 {;}
        ;


expr    :  add '=' expr                         {$$ = $3; printf("%s = %s ;\n", $1, $3);}
        |  add                                  {$$ = $1;}
        ;



add     :  add '+' factor                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s + %s;\n", $$, $1, $3);}
	|  add '-' factor                         {sprintf($$, "t%d", temp_variable++); printf("%s = %s - %s;\n", $$, $1, $3);}
        |  factor                                 {$$ = $1;}
        ;


factor  : '(' expr ')'                          {$$ = $2;}
        | '-' factor                            {$$ = $2;}
        | NUMBER                                {$$ = $1;}
        | ID                                    {$$ = $1;}
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
