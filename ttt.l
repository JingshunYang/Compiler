%{
#include "ttt.tab.h"
#include "stdio.h"
#include "stdlib.h"
# include "gramtree_v1.h"
%}

%option yylineno
wspace  [\t\r\x0C ]
letter  [_a-zA-Z]
dec     [0-9]
id   {letter}+({letter}|{dec})*

%%
\n                          { /* ++yylineno; */ }
{wspace}                    { /* eat up white space */ }

"decl" 		{yylval.a=newast("DECL",0,yylineno);return DECL;}
"begin" 	{yylval.a=newast("BEGIN",0,yylineno);return BEG;}
"end" 		{yylval.a=newast("END",0,yylineno);return END;}
"void" 		{yylval.a=newast("VOID",0,yylineno);return VOID;}
"bool" 		{yylval.a=newast("BOOL",0,yylineno);return BOOL;}
"enforce" 	{yylval.a=newast("ENFORCE",0,yylineno);return ENFORCE;}
"skip" 		{yylval.a=newast("SKIP",0,yylineno);return SKIP;}
"goto" 		{yylval.a=newast("GOTO",0,yylineno);return GOTO;}
"return" 	{yylval.a=newast("RETURN",0,yylineno);return RETURN;}
"if" 			{yylval.a=newast("IF",0,yylineno);return IF;}
"then" 		{yylval.a=newast("THEN",0,yylineno);return THEN;}
"else" 		{yylval.a=newast("ELSE",0,yylineno);return ELSE;}
"fi" 			{yylval.a=newast("FI",0,yylineno);return FI;}
"while" 	{yylval.a=newast("WHILE",0,yylineno);return WHILE;}
"do" 			{yylval.a=newast("DO",0,yylineno);return DO;}
"od" 			{yylval.a=newast("OD",0,yylineno);return OD;}
"assert" 	{yylval.a=newast("ASSERT",0,yylineno);return ASSERT;}
decider   {yylval.a=newast("DECIDER",0,yylineno);return DECIDER;}

{id}      {yylval.a=newast("ID",0,yylineno);return ID;}

"0"				{yylval.a=newast("FALSE",0,yylineno);return F;}
"1"				{yylval.a=newast("TRUE",0,yylineno);return T;}

"|"        {yylval.a=newast("|",0,yylineno);return '|';}
"&"        {yylval.a=newast("&",0,yylineno);return '&';}
"^"        {yylval.a=newast("^",0,yylineno);return '^';}
"="        {yylval.a=newast("=",0,yylineno);return '=';}

"!="			{yylval.a=newast("UEQ",0,yylineno);return UEQ;}
"=>"			{yylval.a=newast("ARROW",0,yylineno);return ARROW;}

"(" 			{yylval.a=newast("",0,yylineno);return '(';}
")" 			{yylval.a=newast("",0,yylineno);return ')';}
":"				{yylval.a=newast(":",0,yylineno);return ':';}
";"				{yylval.a=newast(";",0,yylineno);return ';';}
"!"				{yylval.a=newast("!",0,yylineno);return '!';}
"*"				{yylval.a=newast("*",0,yylineno);return '*';}
":="			{yylval.a=newast(":=",0,yylineno);return EQ;}

"//".* 		/*ignore*/
. 				{ printf("Error type A at line %d: Mystirious charachter '%s'\n",yylineno,yytext);}
%%
int yywrap()
{
    return 1;
}
