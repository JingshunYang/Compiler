%{
#include<stdio.h>
%}
%token TAG TAG
%token DECL BEG END ENFORCE
%token VOID BOOL
%token SKIP GOTO RETURN
%token IF THEN ELSE FI
%token WHILE DO OD
%token ASSERT
%token ID T F DECIDER
%token NONDETER BOP EQ NOT
%token OP CP

%%
prog  : decl1 proc1
      ;
decl1 :
      | decl decl1
      ;
proc1 :
      | proc proc1
      ;
decl  : DECL id2
      ;
id2   : ID
      | ID id2
      ;
proc  : type ID OP id1 CP BEG enforce decl1 sseq END
      ;
id1   :
      | ID id1
      ;
type  : VOID
      | BOOL
      ;
enforce : ENFORCE expr TAG
        ;
sseq  : lstmt2
      ;
lstmt2: lstmt
      | lstmt lstmt2
      ;
lstmt : stmt
      | ID COLON stmt
      ;
stmt  : SKIP TAG
      | GOTO ID TAG
      | RETURN ID TAG
      | ID EQ expr TAG
      | IF OP DECIDER CP THEN sseq ELSE sseq FI
      | WHILE OP expr CP DO sseq OD
      | ASSERT OP expr CP TAG
      | ID EQ ID OP expr1 CP
      ;
expr1 :
      | expr expr1
      ;
expr  : expr BOP expr
      | OP expr CP
      | '!' expr
      | ID
      | const
      | NONDETER
      ;
const	:	T
			|	F
			;
%%
void main(int argc, char** argv){
  yyparse();
}
yyerror(char *s){
  fprintf(stderr, "error:%s\n", s);
}
