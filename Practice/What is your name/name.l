/* Declaration */

/* auxiliary declarations */
%{                          
    #include <stdio.h>          /* imports */
    #include <math.h>           /* need this for the call to atof() below */
    int yyerror( char* );       /* function prototype */  
    int num;                    /* global variable */
%}

           
/* Rules */
%%

[0-9]+                           { return atoi(yytext);}
[a-zA-Z]+                        { printf("Hello, %s\n", yytext); return 0;}
.+                               { return yyerror(yytext);}

%%

/* Auxiliary functions */
int yywrap(void) { 
    return 1; 
}

int main() { 
  printf("What is your name?\n");
  yylex();
  printf("What is your age?");
  num = yylex();
  (num  > 18 )  ?
    printf("How you doing?"):
    printf("Call me when your 18." );
  
  return 0;
}

int yyerror(char *error_value) { 
  fprintf(stderr,"I don't understand '%s' .\n", error_value); 
}