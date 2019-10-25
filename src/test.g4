grammar test;

program: ft_dcl?ft_def+;
//test: type;

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
access_modifier: 'private' | 'public' | 'protected';
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
cond_stmt: 'if' expr (block | stmt) (Else (block | stmt))? | Switch var '{' switch_body '}' ;
switch_body: (Caseof 'int' ':' block)+ (Default ':' block)?;
loop_stmt: For (type?assign)? ';' expr ';' assign? block | While expr block;
const_val: Int | Float | Bool | String;
unary_op: '-' | '!' | '~';
binary_op: arthmetic | relational | bitwise | logical;
arthmetic: '+' | '-' | '*' | '/' | '%';
bitwise: '&' | '|';
logical: '||' | '&&';
relational: '==' | '!=' | '<=' | '>=' | '<' | '>';
type: 'int' | 'float' | 'bool' | 'string' | ID;

//skip
WS: [ \t\r\n]+  -> skip;
Comment:  ('#$'.*?'\n'| '#('.*?')#') -> skip;

//KEY WORDS
Function: 'function';
For: 'for';
While: 'while';
Caseof: 'caseof';
Default: 'default';
This : 'this';
Super: 'super';
Continue: 'continue';
Break: 'break';
Switch : 'switch';
Type: 'type';
Declare: 'declare';
Read: 'read';
Write: 'write';
Const: 'const';
Nil : 'nil';
Destruct: 'destruct';
Else: 'else';
Allocate: 'allocate';

//Data Identifiers:
Int_val: ('0x'[0-9a-fA-F]+|'0X' [0-9a-fA-F]+) | [0-9]+;
Int: [-+]?Int_val;
Float: [-+]?((Int_val?)?[.](Int?'^'[-+]?Int | Int) | (Int_val)[.](Int?'^'Int | Int?)?);
String: ['].+?['];
Bool: 'true' | 'false';
ID: ('@'|'_'|ALPHABET)('@'|'_'|ALPHABET|DIGIT)*;

fragment DIGIT : [0-9];
fragment NUMBER: DIGIT+;
fragment ALPHABET: [a-zA-Z];

//variable: ID | Int | Float | Bool;
//for: For '(' (type? ID '=' ID)? ';' (type? ID )? ';' (ID)? ')' block?;
//while: While expr block;
