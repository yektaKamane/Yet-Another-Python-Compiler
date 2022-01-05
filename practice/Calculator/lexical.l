
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

delim     [ \t\f\v\r]
ws        {delim}+
digit     [0-9]
number    {digit}+(\.{digit}+)?([eE][+\-]?{digit}+)?

%%

{number}                                     {yylval.f = atof(yytext); return NUM;}
[-+()*/]                                     {return yytext[0];}
[\n]                                         {return 0;}
{ws}                                         { ; }
.                                            {printf("invalid syntax");}

%%


int yywrap()
{
    return -1;
}