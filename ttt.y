%{
#include<stdio.h>
%}

%token DECL BEG END ENFORCE
%token VOID BOOL
%token SKIP GOTO RETURN
%token IF THEN ELSE FI
%token WHILE DO OD
%token ASSERT
%token ID T F DECIDER
%token NONDETER BOP

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
proc  : type ID '(' id1 ')' BEG enforce decl1 sseq END
      ;
id1   :
      | ID id1
      ;
type  : VOID
      | BOOL
      ;
enforce : ENFORCE expr ';'
        ;
sseq  : lstmt2
      ;
lstmt2: lstmt
      | lstmt lstmt2
      ;
lstmt : stmt
      | ID ':' stmt
      ;
stmt  : SKIP ';'
      | GOTO ID ';'
      | RETURN ID ';'
      | ID ":=" expr ';'
      | IF '(' DECIDER ')' THEN sseq ELSE sseq FI
      | WHILE '(' expr ')' DO sseq OD
      | ASSERT '(' expr ')' ';'
      | ID ":=" ID '(' expr1 ')'
      ;
expr1 :
      | expr expr1
      ;
expr  : expr BOP expr
      | '(' expr ')'
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
