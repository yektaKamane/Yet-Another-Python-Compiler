%{

#include <stdio.h>
#include <string.h>

%}

delim     [ \t\n]
letter    [A-Za-z] 
digit     [0-9]	

%%

{delim}+                                        {;}
{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?         {strcpy(yylval.num , yytext); return NUM;}
[+-/*=,(){}]                                  {return yytext[0];}

"=="                        |
"!="                        |
">"                         |
"<"                         |
">="                        |
"<="                        {strcpy(yylval.relo, yytext); printf("%s is Relope",yytext); return RELOP;}

"if"                        {return IF;}
"else"                      {return ELSE;}
"while"                     {return WHILE;}
"for"                       {return FOR;}
"in"                        {return IN;}

{letter}({letter}|{digit})*                     {strcpy(yylval.id , yytext); return ID;}
.					                            printf("unexpected character\n");

%%


main {
    printf("\n----------------------------------------------- ALYEK Compiler -----------------------------------------------\n\n\n");

    yylex();
}
