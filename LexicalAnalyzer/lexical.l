%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern void yyerror(const char *);  /* prints grammar violation message */

%}

delim     [ \t\r\v\f]
ws        {delim}+   
letter    [A-Za-z] 
digit     [0-9]	
id        {letter}({letter}|{digit})*
number    {digit}+(\.{digit}+)?([eE][+\-]?{digit}+)?

%%

{ws}                                    {;}
[\n]                                    {return 0;}

{number}                                {strcpy(yylval.num , yytext); return NUMBER;}
[-+*/%(){}]                             {return yytext[0];}


"=="                                    |
"!="                                    |
">="                                    |
"<="                                    |
">"                                     |
"<"                                     {strcpy(yylval.relop , yytext); return RELOP;}

"if"                                    {return IF;}
"else"                                  {return ELSE;}
"while"                                 {return WHILE;}
"for"                                   {return FOR;}
"in"                                    {return IN;}
"range"                                 {return RANGE;}

{id}                                    {strcpy(yylval.id , yytext); return ID;}

.	                                    {printf("\nInvalid syntax!");}


%%

int yywrap(void)        /* called at end of input */
{
    return -1;           /* terminate now */
}