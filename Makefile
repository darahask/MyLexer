mylex: lex.yy.c
	gcc lex.yy.c -o mylexer
lex.yy.c: lex.l
	lex lex.l