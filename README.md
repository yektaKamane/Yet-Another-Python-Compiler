# Yet Another Python Compiler
Simple But Hope to Create Precise compiler to Convert Python Syntax Code to Three-Address-Code(TAC).

### Ubuntu

``` 
$ sudo apt-get update
$ sudo apt-get install flex
$ sudo apt-get install bison

```

### Run 
After installing flex and bison follow below commands:

``` 
$ bison -d  parser.y
$ flex lexical.l
$ gcc lex.yy.c parser.tab.c -o ALYEK
$ ./ALYEK < input.txt | cat > output.txt

```
