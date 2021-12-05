%{

#include <stdio.h>
#include <string.h>

%}

delim     [ \t\n]
letter    [A-Za-z] 
digit     [0-9]	

%%

{delim}+                                        {printf("%s is delim",yytext);}
{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?         {printf("%d is NUM",yytext);}


"=="                        |
"!="                        |
">"                         |
"<"                         |
">="                        |
"<="                        {printf("%s is Relope",yytext);}

"if"                        {printf("%s is Keyword",yytext);}
"else"                      {printf("%s is Keyword",yytext);}
"while"                     {printf("%s is Keyword",yytext);}
"for"                       {printf("%s is Keyword",yytext);}
"in"                        {printf("%s is Keyword",yytext);}

{letter}({letter}|{digit})*                     {printf("%s is ID",yytext);}
.					                            printf("unexpected character\n");

%%


main {
    printf("\n----------------------------------------------- ALYEK Compiler -----------------------------------------------\n\n\n");

    yylex();
}
