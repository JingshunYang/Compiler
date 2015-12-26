000
%{
#include "ttt.tab.h"
%}

%%

"decl" 		{printf("DECL\n");return DECL;}
"type" 		{printf("TYPE%d\n",int(TYPE));return TYPE;}
"begin" 	{printf("BEGIN\n");return BEG;}
"end" 		{printf("END\n");return END;}
"void" 		{printf("VOID\n");return VOID;}
"bool" 		{printf("BOOL\n");return BOOL;}
"enforce" 	{printf("ENFORCE\n");return ENFORCE;}
"skip" 		{printf("SKIP\n");return SKIP;}
"goto" 		{printf("GOTO\n");return GOTO;}
"return" 	{printf("RETURN\n");return RETURN;}
"if" 			{printf("IF\n");return IF;}
"then" 		{printf("THEN\n");return THEN;}
"else" 		{printf("ELSE\n");return ELSE;}
"fi" 			{printf("FI\n");return FI;}
"while" 	{printf("WHILE\n");return WHILE;}
"do" 			{printf("DO\n");return DO;}
"od" 			{printf("OD\n");return OD;}
"assert" 	{printf("ASSERT\n");return ASSERT;}

[a-zA-Z_][a-zA-Z0-9_]* { printf("ID%s\n",yytext);return ID;};

"0"				{printf("F\n");return F;}
"1"				{printf("T\n");return T;}
"(" 			{printf("OP\n");return OP;}
")" 			{printf("CP\n");return CP;}

":"				{printf(":\n");	return COLON;}
";"				{printf(";\n");	return TAG;}
"!"				{printf("!\n");	return NOT;}
":="			{printf(":=\n");return EQ;}
"\n"			{printf("newline\n"); return EOL;}

"|"				{printf("OR\n");return OR;}
"&"				{printf("AND\n");return AND;}
"^"				{printf("XOR\n");return XOR;}
"="				{printf("EQUAL\n");return EQUAL;}
"!="			{printf("INEQUAL\n");return INEQUAL;}
"=>"			{printf("IMPLY\n");return IMPLY;}
"*"				{printf("NONDETER\n");return (NONDETER);}

[ \t] 		{}
"//".* 		/*ignore*/
. 				{printf("Mystery character %c\n", *yytext);}
%%
