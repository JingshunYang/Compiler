ttt: ttt.l ttt.y
		bison -d ttt.y
		flex ttt.l
		cc -o $@ ttt.tab.c lex.yy.c -lfl
