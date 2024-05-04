%{
#include <stdio.h>
#include "boolcalc.tab.h"
%}
%option noyywrap

%%

[ \t];
\n				{return NEWLINE;}
([T|t][R|r][U|u][E|e])|1	{yylval = 1; return TRUE;} // case sensititve
([F|f][A|a][L|l][S|s][E|e])|0	{yylval = 0; return FALSE;}
"&"				{return AND;}
"|"				{return OR;}
"!"				{return NOT;}

%%

// Input format 11and 10or 1not etc