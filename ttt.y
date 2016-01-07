%{
#include<stdio.h>
#include<unistd.h>
#include "gramtree_v1.h"
%}

%union{
struct ast* a;
double d;
}

%token <a> '(' ')' ':' ';' '*' '|' '&' '^' '=' '!'
%token <a> DECL BEG END ENFORCE
%token <a> VOID BOOL
%token <a> SKIP GOTO RETURN
%token <a> IF THEN ELSE FI
%token <a> WHILE DO OD
%token <a> ASSERT EQ
%token <a> ID T F DECIDER UEQ ARROW
%type  <a> prog decl1 proc1 decl id2 proc id1 type enforce sseq
lstmt2 lstmt stmt expr1 expr const

%left '='
%left '|'
%left '&'
%right '!'

%%
prog  : |decl1 proc1{$$=newast("Prog",2,$1,$2);printf("打印syntax tree:\n");eval($$,0);printf("syntax tree打印完毕!\n\n");}
      ;
decl1 :{$$=newast("decl*",0,-1);}
      | decl decl1 {$$=newast("decl*",2,$1,$2);}
      ;
proc1 :{$$=newast("proc*",0,-1);}
      | proc proc1 {$$=newast("proc*",2,$1,$2);}
      ;
decl  : DECL id2 {$$=newast("decl",2,$1,$2);}
      ;
id2   : ID {$$=newast("id+",1,$1);}
      | ID id2 {$$=newast("id+",2,$1,$2);}
      ;
proc  : type ID '(' id1 ')' BEG enforce decl1 sseq END {$$=newast("proc",10,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);}
      ;
id1   : {$$=newast("id*",0,-1);}
      | ID id1 {$$=newast("id*",2,$1,$2);}
      ;
type  : VOID {$$=newast("type",1,$1);}
      | BOOL {$$=newast("type",1,$1);}
      ;
enforce : ENFORCE expr ';' {$$=newast("enforce",3,$1,$2,$3);}
        ;
sseq  : lstmt2 {$$=newast("sseq",1,$1);}
      ;
lstmt2: lstmt {$$=newast("lstmt+",1,$1);}
      | lstmt lstmt2 {$$=newast("lstmt+",2,$1,$2);}
      ;
lstmt : stmt {$$=newast("lstmt",1,$1);}
      | ID ':' stmt {$$=newast("lstmt",3,$1,$2,$3);}
      ;
stmt  : SKIP ';' {$$=newast("stmt",2,$1,$2);}
      | GOTO ID ';'  {$$=newast("stmt",3,$1,$2,$3);}
      | RETURN ID ';'  {$$=newast("stmt",3,$1,$2,$3);}
      | ID EQ expr ';'  {$$=newast("stmt",4,$1,$2,$3,$4);}
      | IF '(' DECIDER ')' THEN sseq ELSE sseq FI  {$$=newast("stmt",9,$1,$2,$3,$4,$5,$6,$7,$8,$9);}
      | WHILE '(' expr ')' DO sseq OD  {$$=newast("stmt",7,$1,$2,$3,$4,$5,$6,$7);}
      | ASSERT '(' expr ')' ';'  {$$=newast("stmt",5,$1,$2,$3,$4,$5);}
      | ID EQ ID '(' expr1 ')'  {$$=newast("stmt",6,$1,$2,$3,$4,$5,$6);}
      ;
expr1 : {$$=newast("expr*",0,-1);}
      | expr expr1  {$$=newast("expr*",2,$1,$2);}
      ;
expr  : expr '|' expr {$$=newast("expr",3,$1,$2,$3);}
      | expr '&' expr  {$$=newast("expr",3,$1,$2,$3);}
      | expr '^' expr  {$$=newast("expr",3,$1,$2,$3);}
      | expr '=' expr  {$$=newast("expr",3,$1,$2,$3);}
      | expr UEQ expr  {$$=newast("expr",3,$1,$2,$3);}
      | expr ARROW expr  {$$=newast("expr",3,$1,$2,$3);}
      | '(' expr ')'  {$$=newast("expr",3,$1,$2,$3);}
      | '!' expr  {$$=newast("expr",2,$1,$2);}
      | ID  {$$=newast("expr",1,$1);}
      | const  {$$=newast("expr",1,$1);}
      | '*'  {$$=newast("expr",1,$1);}
      ;
const	:	T {$$=newast("const",1,$1);}
			|	F {$$=newast("const",1,$1);}
			;
%%
