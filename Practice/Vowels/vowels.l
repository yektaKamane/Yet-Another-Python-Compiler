%{

#include <stdio.h>
int vowels=0;
int cons=0;

%}

%%
"a"|"e"|"i"|"o"|"u"|"A"|"E"|"I"|"O"|"U" {printf("is a vowel");vowels++;}
[a-zA-Z] {printf("is a Constant");cons++;}
%%
int yywrap()
{
return 1;
}

main() 
{
printf("\n----------------------------------------------- ALYEK Compiler -----------------------------------------------\n\n\n");
printf("Please Enter Your Character:\n");
yylex();
printf("Vowel=%d and constant=%d",vowels,cons);
}
