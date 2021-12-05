#include <stdio.h>
#include "myscanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

char *data[] = {"if", "12", "<", "5"};

int main(void){

    int ntoken, vtoken;

    ntoken = yylex();
    while(ntoken){
        print("%d\n", ntoken);
        ntoken = yylex();
    }

    return 0;

}