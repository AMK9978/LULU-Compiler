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
cond_stmt: If expr (block | stmt) (Else (block | stmt))? | Switch var '{' switch_body '}' ;
switch_body: (Caseof 'int' ':' block)+ (Default ':' block)?;
loop_stmt: For (type?assign)? ';' expr ';' assign? block | While expr block;
const_val: Int  | Float |  Bool | String;
unary_op: '!' | '~' | '-';
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

//Data Identifiers:
Int: INT_DEC | INT_HEX;
Float: (Int '.' Int EXP?) | ('.'Int EXP?) | (Int '.' EXP?);
String: ['](EXC_BS|ESC_CODE)*['];
Bool: 'true' | 'false';
ID: ('@'|'_'|LETTER)('@'|'_'|LETTER|DIGIT)*;


fragment EXP: '^'[-+]?Int;
fragment ESC_CODE: '\\'('n' | 'r' | '0' | 't' | '\\' | '\'' | [xX][a-fA-F0-9][a-fA-F0-9]) ;
fragment EXC_BS: ~('\\');
fragment INT_DEC: DIGIT+;
fragment INT_HEX:('0x'|'0X')[0-9a-fA-F]+;
fragment DIGIT : [0-9];
fragment LETTER: [a-zA-Z];

//fragment INT_VAL: ('0x'[0-9a-fA-F]+|'0X' [0-9a-fA-F]+) | [0-9]+;
//Float: [-+]?((INT_VAL?)?[.](Int?'^'[-+]?Int | Int) | (INT_VAL)[.](Int?'^'Int | Int?)?);
//variable: ID | Int | Float | Bool;
//for: For '(' (type? ID '=' ID)? ';' (type? ID )? ';' (ID)? ')' block?;
//while: While expr block;
