test: all clean
	./ALYEK < input.c > output.c

all: flex bison parser.tab.h
	gcc parser.tab.c lex.yy.c -w

flex: lexical.l
	flex -i lexical.l

bison: parser.y
	bison -v -d lexical.y

clean:
	rm lex.yy.c parser.tab.c parser.tab.h parser.output