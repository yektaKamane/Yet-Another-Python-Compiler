%{

	/* defination */

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <stdarg.h>
    #include <ctype.h>

    #include "parser.tab.h"

	/* prints grammar violation message */
	extern void yyerror(const char *);  

%}


delim     [ \t\r\v\f\n]
ws        {delim}+  
letter    [A-Za-z] 
digit     [0-9]	
id        {letter}({letter}|{digit})*
number    {digit}+(\.{digit}+)?([eE][+\-]?{digit}+)?


/* pattern actions/Rules */
%%

{ws}                                    { ; }

"**"                        			{strcpy(yylval.arithP, yytext); return ARITHP;}
"//"                        			{strcpy(yylval.arithD, yytext); return ARITHD;}

{number}  								{strcpy(yylval.num , yytext); return NUM;}
[-+/*=,;(){}%]                          {return yytext[0];}


"=="                        			|
"!="                        			|
">"                         			|
">="                        			|
"<"                         			|
"<="                        			{strcpy(yylval.relo, yytext); return RELOP;}


"if"                        			{return IF;}
"else"                      			{return ELSE;}
"while"                     			{return WHILE;}
"for"                       			{return FOR;}
"in"                        			{return IN;}
"range"                     			{return RANGE;}

{id}                        			{strcpy(yylval.id , yytext); return ID;}
.					        			{printf("Error occured ...\n");}

%%

/* User Code Segment */