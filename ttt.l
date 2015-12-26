%{
#include "ttt.tab.h"
%}

%%

"decl" 		{printf("DECL ");return DECL;}
"begin" 	{printf("BEGIN ");return BEG;}
"end" 		{printf("END ");return END;}
"void" 		{printf("VOID ");return VOID;}
"bool" 		{printf("BOOL ");return BOOL;}
"enforce" 	{printf("ENFORCE ");return ENFORCE;}
"skip" 		{printf("SKIP ");return SKIP;}
"goto" 		{printf("GOTO ");return GOTO;}
"return" 	{printf("RETURN ");return RETURN;}
"if" 			{printf("IF ");return IF;}
"then" 		{printf("THEN ");return THEN;}
"else" 		{printf("ELSE ");return ELSE;}
"fi" 			{printf("FI ");return FI;}
"while" 	{printf("WHILE ");return WHILE;}
"do" 			{printf("DO ");return DO;}
"od" 			{printf("OD ");return OD;}
"assert" 	{printf("ASSERT ");return ASSERT;}

[a-zA-Z_][a-zA-Z0-9_]* { printf("ID%s\n",yytext);return ID;};

"0"				{printf("F ");return F;}
"1"				{printf("T ");return T;}
[|&^=]		{return BOP;}
"!="			{return BOP;}
"=>"			{return BOP;}
"\n"			{printf("newline ");}

"(" 			{printf("OP\n");return OP;}
")" 			{printf("CP\n");return CP;}
":"				{printf(":\n");	return COLON;}
";"				{printf(";\n");	return TAG;}
"!"				{printf("!\n");	return NOT;}
":="			{printf(":=\n");return EQ;}

"*"				{printf("NONDETER ");return (NONDETER);}

[ \t] 		{}
"//".* 		/*ignore*/
. 				{printf("Mystery character %c\n", *yytext);}
%%
