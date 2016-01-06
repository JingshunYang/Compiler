%{
#include "ttt.tab.h"
%}

wspace  [\t\r\x0C ]
letter  [_a-zA-Z]
dec     [0-9]
id   {letter}+({letter}|{dec})*

%%
\n                          { /* ++yylineno; */ }
{wspace}                    { /* eat up white space */ }

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
decider   {printf("DECIDER "); return DECIDER;}

{id}   { printf("ID %s\n",yytext);return ID;}

"0"				{printf("F ");return F;}
"1"				{printf("T ");return T;}

"|"        {return '|';}
"&"        {return '&';}
"^"        {return '^';}
"="        {return '=';}

"!="			{return UEQ;}
"=>"			{return ARROW;}

"(" 			{return '(';}
")" 			{return ')';}
":"				{return ':';}
";"				{return ';';}
"!"				{return '!';}
":="			{return EQ;}
"*"				{return '*';}

"//".* 		/*ignore*/
. 				{printf("Mystery character %c\n", *yytext);}
%%
