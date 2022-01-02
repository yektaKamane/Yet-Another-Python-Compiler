%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

extern void yyerror(const char *);  /* prints grammar violation message */

%}

delim     [ \t\n]
ws        {delim}+   
letter    [A-Za-z] 
digit     [0-9]	
id        {letter} ({letter} | {digit})*
number    {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%

ws                          { ; }

"=="                        {return EQ_OP;}
"!="                        {return NE_OP;}
">="                        {return GE_OP;}
"<="                        {return LE_OP;}
">"                         {return ">";}
"<"                         {return "<";}

"if"                        {return IF;}
"else"                      {return ELSE;}
"while"                     {return WHILE;}
"for"                       {return FOR;}
"in"                        {return IN;}
"range"                     {return RANGE;}

{letter}({letter}|{digit})*                     {return ID;}
.	


%%

int yywrap(void)        /* called at end of input */
{
    return 1;           /* terminate now */
}