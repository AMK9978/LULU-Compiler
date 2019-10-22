grammar test;
operation:  NUMBER ADD NUMBER ;
operation2: ft_dcl;
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
WS:  (' ' | '\t' | '\r' | '\n' | '#'.*? | '#'.*?'#')+  -> skip;
NUMBER: [0-9]+;
ft_dcl: 'declare' '{' (func_dcl | type_dcl | var_def)+? '}';
func_dcl: ('(' args ')' '=')? id '(' (args | args_var)? ')' ';';
args: type ('[' ']')* | args ',' type ('[' ']')*;
args_var: type ('[' ']')* id | args_var ',' type ('[' ']')* id;
type_dcl: type?  ID ';';
var_def: const?  type  var_val (',' var_val)* ';';
var_val: ref ('=' expr)?;
ft_def: (type_def | fun_def);
type_def: type id (':' id)? '{' component+ '}';
component: access_modifier? (var_def | fun_def);
access_modifier: 'private' | 'public' | 'protected';
fun_def: ('(' args_var ')' '=')? id '(' args_var? ')' block;
stmt: assign ';' | func_call ';' | cond_stmt | loop_stmt | break ';' | continue ';' | destruct ('[' ']')* id ';';
assign: (var | '(' var (',' var)* ')') '=' expr;
var: ((this | super)'.')? ref ('.' ref)*;
ref: id ('[' expr ']')*;
expr: expr binary_op expr | '(' expr ')' | unary_op expr | const_val | allocate handle_call | func_call | var | list | nil;
func_call: (var '.')? handle_call | read '(' ')' | write '(' expr ')';
list : '[' (expr | list) (','(expr | list))* ']';
handle_call: id '(' params? ')';
params: expr | expr ',' params;
cond_stmt: if expr (block | stmt) (else (block | stmt))? | switch var '{' switch_body '}' ;
switch_body: (caseof int_const ':' block)+ (default ':' block)?;
loop_stmt: for (type?assign)? ';' expr ';' assign? block | while expr block;
const_val: int_const | real_const | bool_const | string_const;
unary_op: '-' | '!' | '~';
binary_op: arthmetic | relational | bitwise | logical;
arthmetic: '+' | '-' | '*' | '/' | '%';
bitwise: '&' | '|';
logical: '||' | '&&';
relational: '==' | '!=' | '<=' | '>=' | '<' | '>';
id: ID ;
int_const: 'int_const';
real_const: 'real_const';
type: int | bool | float | string | id;
//Datatypes:
Float: [-+]?([0-9]*[.])?[0-9]+;
Int: [xX][0-9a-fA-F]+ | [0-9]+;
String: .+?;
Bool: 'true' | 'false';
Alphabet: [a-zA-Z];
ID : Alphabet+(Alphabet | NUMBER)*;

read: 'read';
write: 'write';
caseof : 'caseof';
default: 'default';
while: 'while';
block: WS* ('{' WS* '}')? WS*;

//Data identifiers:
string_const: 'string_const';
bool_const: 'bool_const';
variable: ID | NUMBER | Float | bool;
int: 'int';
float: 'float';
bool: 'bool';
string: 'string';

nil : 'nil';
destruct: 'destruct';
else: 'else';
allocate: 'allocate';
for: For WS* '(' WS* (type? id '=' id)? WS* ';' WS* (type? id )? WS* ';' WS* (id)? WS* ')' WS* block?;
this : 'this';
super: 'super';
continue: 'continue';
break: 'break';
switch : 'switch';

if : 'if';
const: 'const';
For: 'for';


