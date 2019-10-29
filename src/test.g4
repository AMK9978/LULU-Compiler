grammar test;

program: ft_dcl?ft_def+;
test: Float;

ft_dcl: Declare '{' (func_dcl | type_dcl | var_def)+ '}';
func_dcl: ('(' args ')' '=')? ID '(' (args | args_var)? ')' ';';
args: type ('[' ']')* | args ',' type ('[' ']')*;
args_var: type ('[' ']')* ID | args_var ',' type ('[' ']')* ID;
type_dcl: ID ';';
var_def: Const?  type  var_val (',' var_val)* ';';
var_val: ref ('=' expr)?;
ft_def: (type_def | fun_def);
type_def: Type ID (':' ID)? '{' component+ '}';
component: access_modifier? (var_def | fun_def);
access_modifier: Private | Public | Protected;
fun_def: ('(' args_var ')' '=')? Function ID '(' args_var? ')' block;
block: '{' (var_def|stmt)* '}';
stmt: assign ';' | func_call ';' | cond_stmt | loop_stmt | Break ';' | Continue ';' | Destruct ('[' ']')* ID ';';
assign: (var | '(' var (',' var)* ')') '=' expr;
var: ((This | Super)'.')? ref ('.' ref)*;
ref: ID ('[' expr ']')*;
expr: expr binary_op expr | '(' expr ')' | unary_op expr | const_val | Allocate handle_call | func_call | var | list | Nil;
func_call: (var '.')? handle_call | Read '(' ')' | Write '(' expr ')';
list : '[' (expr | list) (','(expr | list))* ']';
handle_call: ID '(' params? ')';
params: expr | expr ',' params;
cond_stmt: If expr (block | stmt) (Else (block | stmt))? | Switch var '{' switch_body '}' ;
switch_body: (Caseof Int_val ':' block)+ (Default ':' block)?;
loop_stmt: For (type?assign)? ';' expr ';' assign? block | While expr block;
type: Int | Float | Bool | String | ID;
const_val: Int_val  | Float_val |  String_val | Bool_val;
unary_op: '!' | '~' | '-';
binary_op: arthmetic | relational | bitwise | logical;
arthmetic: '+' | '-' | '*' | '/' | '%';
bitwise: '&' | '|';
logical: '||' | '&&';
relational: '==' | '!=' | '<=' | '>=' | '<' | '>';


//skip
Ws: [ \t\r\n]+  -> skip;
Comment:  ('#$'.*?'\n'| '#('.*?')#') -> skip;

//KEY WORDS
Int: 'int';
Float: 'float';
Bool: 'bool';
String: 'string';
Function: 'function';
If : 'if';
Else: 'else';
Switch : 'switch';
Default: 'default';
Break: 'break';
For: 'for';
While: 'while';
Continue: 'continue';
Const: 'const';
Caseof: 'caseof';
This : 'this';
Super: 'super';
Type: 'type';
Declare: 'declare';
Read: 'read';
Write: 'write';
Nil : 'nil';
Destruct: 'destruct';
Allocate: 'allocate';
Public: 'public';
Private: 'private';
Protected: 'protected';

//Data Identifiers:
Int_val: INT_DEC | INT_HEX;
Float_val: ( (Int_val? '.' Int_val) | (Int_val '.') ) EXP?;
String_val: ['](EXC_BS|ESC_CODE)*['];
Bool_val: 'true' | 'false';
ID: ('@'|'_'|LETTER)('@'|'_'|LETTER|DIGIT)*;


fragment EXP: '^'[-+]?Int_val;
fragment ESC_CODE: '\\'('n' | 'r' | '0' | 't' | '\\' | '\'' | [xX][a-fA-F0-9][a-fA-F0-9]) ;
fragment EXC_BS: ~('\\');
fragment INT_DEC: DIGIT+;
fragment INT_HEX:('0x'|'0X')[0-9a-fA-F]+;
fragment DIGIT : [0-9];
fragment LETTER: [a-zA-Z];
