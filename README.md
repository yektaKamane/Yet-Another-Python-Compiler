# Yet Another Python Compiler



## To Run 
After installing flex and bison follow below commands:

``` 
$ bison -d  parser.y
$ flex lexical.l
$ gcc lex.yy.c parser.tab.c -o ALYEK
$ ./ALYEK < input.c | cat > output.c
