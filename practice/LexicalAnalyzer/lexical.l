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
{number}                                {yylval.num = malloc(100); strcpy(yylval.num , yytext); return NUMBER;}
[-+*/(){}=;]                             {return yytext[0];}
{id}                                    {yylval.id = malloc(100); strcpy(yylval.id , yytext); return ID;}

.	                                    {printf("\nInvalid syntax!");}


%%

int yywrap(void)        /* called at end of input */
{
    return -1;           /* terminate now */
}