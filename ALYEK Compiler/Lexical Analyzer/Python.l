%{

#include <stdio.h>
#include <string.h>
#include "myscanner.h"

%}

delim     [ \t\n]
ws        {delim}+   
letter    [A-Za-z] 
digit     [0-9]	
id        {letter} ({letter} | {digit})*
number    {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%

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
"range"                     {return RANGE;}

{letter}({letter}|{digit})*                     {strcpy(yylval.id , yytext); return ID;}
.					                            printf("unexpected character\n");

%% 

int yywrap(void){
    return 1;
}
