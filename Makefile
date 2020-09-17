mylex: lex.yy.c
	gcc lex.yy.c -o mylex
lex.yy.c: lex.l
	lex lex.l