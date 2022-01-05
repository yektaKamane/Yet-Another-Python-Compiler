number = 1 2 3 4 5 6 7 8 9 10

test: all
	$(foreach var,$(number),./compiler < ./data/input/input$(var).txt | cat > ./data/output/output$(var).txt;)

all: flex bison parser.tab.h
	gcc -w parser.tab.c lex.yy.c -o compiler

flex: lexical.l
	flex lexical.l

bison: parser.y
	bison -d parser.y

clean:
	rm lex.yy.c parser.tab.c parser.tab.h