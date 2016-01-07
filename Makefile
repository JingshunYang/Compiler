ttt: ttt.l ttt.y gramtree_v1.h
		bison -d ttt.y
		flex ttt.l
		gcc ttt.tab.c lex.yy.c gramtree_v1.c 
