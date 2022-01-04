%{
/* defination */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h"

/* prints grammar violation message */
extern void yyerror(const char *);  

%}


delim     [ \t\r\v\f]
ws        {delim}+   
letter    [A-Za-z] 
digit     [0-9]	
id        {letter}({letter}|{digit})*
number    {digit}+(\.{digit}+)?([eE][+\-]?{digit}+)?


/* pattern actions/Rules */
%%


{ws}                                    {;}
[\n]                                    {return 0;}

{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?         {strcpy(yylval.num , yytext); return NUM;}
[-+/*=,;(){}]                                  {return yytext[0];}

"=="                        |
"!="                        |
">"                         |
">="                        |
"<"                         |
"<="                        {strcpy(yylval.relo, yytext); return RELOP;}


"if"                        {return IF;}
"else"                      {return ELSE;}
"while"                     {return WHILE;}
"for"                       {return FOR;}
"in"                        {return IN;}
"range"                     {return RANGE;}

{id}                        {strcpy(yylval.id , yytext); return ID;}
.					        {printf("unexpected character\n");}

%%

/* User code Segment */

/* int main() {
    yyin  = fopen("input.txt","r");
    yyout = fopen("output.txt", "w");   

    /* runs the Rule section */
    /* yylex();          */


    /* fclose(yyin); */
    /* fclose(yyout); */

    /* return 0; */
//} */