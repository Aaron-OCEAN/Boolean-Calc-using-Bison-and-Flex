%{
#include<stdio.h>
#include<math.h>

int yylex (void);
extern int yyparse();
extern FILE* yyin;

void yyerror (char const *);
%}

%define api.value.type {int} // Change data type to int for logic gates

%token TRUE FALSE
%token NUM
%token NEWLINE
%token AND OR NOT 
%start input

%%

input:
  %empty
| input line
;

line:
  NEWLINE
| exp NEWLINE {printf("%s", $1 ? "TRUE" : "FALSE"); } // if $1 == 1 it will print TRUE
;

exp:
TRUE {$$ = 1;}    // 1 for TRUE and 0 for FALSE
| FALSE {$$ = 0;}   
| exp exp AND {
    if ($1 && $2) {	// AND gate if TRUE 
        $$ = $1 && $2;  
    } else {
        $$ = 0;  // AND gate if FALSE
    }}
| exp exp OR {$$ = $1 || $2;} // OR gate
| exp NOT {$$ = !$1;}	// NOT gate
;
%%

void yyerror (char const *s){
  fprintf(stderr, "ERROR\n");
}

int main(void){
  yyin = stdin;
  do {
    yyparse();
  } while (!feof(yyin));
  return 0;
}


