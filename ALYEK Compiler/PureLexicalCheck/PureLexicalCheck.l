%{

#include <stdio.h>
#include <string.h>

%}

delim     [ \t\n]
letter    [A-Za-z] 
digit     [0-9]	

%%

{delim}+                                        {printf("%s is delim\n",yytext);}
{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?         {printf("%s is NUM\n",yytext);}
[+-/*%=,(){}]                                  {printf("%s is oprator\n", yytext);}


"=="                        |
"!="                        |
">"                         |
"<"                         |
">="                        |
"<="                        {printf("%s is Relope\n",yytext);}

"if"                        {printf("%s is Keyword\n",yytext);}
"else"                      {printf("%s is Keyword\n",yytext);}
"while"                     {printf("%s is Keyword\n",yytext);}
"for"                       {printf("%s is Keyword\n",yytext);}
"in"                        {printf("%s is Keyword\n",yytext);}

{letter}({letter}|{digit})*                     {printf("%s is ID\n",yytext);}
.					                            {printf("unexpected character\n");}

%%

int yywrap(void){
    return 1;
}


int main() {
    printf("\n----------------------------------------------- ALYEK Compiler -----------------------------------------------\n\n\n");

    printf("Enter: \n");

    yylex();
}
