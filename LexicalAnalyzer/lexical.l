%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}

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
.	


%%