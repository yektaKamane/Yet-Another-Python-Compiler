# Yet Another Python Compiler
The front-end of a compiler that converts python code to Three-Address-Code(TAC).

### Installation
To install Flex and Bison run the below commands in a terminal
``` 
$ sudo apt-get update
$ sudo apt-get install flex
$ sudo apt-get install bison
```

### To Run 
After installing Flex and Bison follow the below commands:
``` 
$ bison -d  parser.y
$ flex lexical.l
$ gcc lex.yy.c parser.tab.c -o compiler
$ ./compiler < ./data/input/input1.txt | cat > ./data/output/output1.txt
```
\
Alternately, you can use the commands in the makefile.\
To build the program, execute the command below: 
``` 
$ make all
```

To run the tests, execute the command: 
``` 
$ make test
```
