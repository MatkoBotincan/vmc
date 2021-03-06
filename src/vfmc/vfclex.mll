{
open Lexing  
open Vfcparse

(* association list of keywords. to be checked *)
let keyword_al = [
  ( "true", TRUE ); 
  ( "false", FALSE );
  ( "bool", BOOL ); 
  ( "byte", BYTE ); 
  ( "int", INT );
  ( "struct", STRUCT);
  ( "void", VOID );
  ( "requires", REQUIRES );
  ( "ensures", ENSURES );
  ( "skip", SKIP ); 
  ( "if", IF );
  ( "else", ELSE ); 
  ( "while", WHILE ); 
  ( "return", RETURN ); 
  ( "fork", FORK ); 
  ( "join", JOIN ); 
  ( "thread", THREAD ); 
  ( "inv", INV ); 
  ( "abs", ABS ); 
(*
  ( "alloc", ALLOC ); 
  ( "free", FREE );
  ( "get", GET ); 
  ( "put", PUT ); 
  ( "wait", WAIT );
*)
]

}

let all = _

let bool_constant = "true" | "false"

let dec_digit = ['0' - '9']
let integer_constant = dec_digit+

let alpha_char = ['a' - 'z'] | ['A' - 'Z']

let simple_id_char = alpha_char | dec_digit | '_'

let first_id_char = alpha_char | '_'

let blank = (' ' | '\009')+  

let newline = ('\013' | '\010' | "\010\013")

let identifier = first_id_char simple_id_char* 


rule token = parse
  | newline { token lexbuf }
  | blank { token lexbuf }
  | "," { COMMA }
  | "{" { L_BRACE }
  | "}" { R_BRACE }
  | ";" { SEMICOLON }
  | "[" { L_BRACKET }
  | "]" { R_BRACKET }
  | "(" { L_PAREN }
  | ")" { R_PAREN }
  | ":" { COLON}
  | "." { DOT }
  | "'" { QUOTE }
  | "=" { EQUALS }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { STAR }
  | "!" { BANG }
  | "&&" { AND }
  | "||" { OR }
  | "==" { CMPEQ }
  | "!=" { CMPNE }
  | ">" { CMPGT }
  | ">=" { CMPGE }
  | "<" { CMPLT }
  | "<=" { CMPLE }
  | "->" { ARROW }
  | eof { EOF }

  | bool_constant { let s = Lexing.lexeme lexbuf in BOOL_CONSTANT(bool_of_string(s)) }
    
  | integer_constant { let s = Lexing.lexeme lexbuf in INTEGER_CONSTANT(int_of_string(s)) }

  | identifier  { let s = Lexing.lexeme lexbuf in
        try List.assoc s keyword_al
        with Not_found -> IDENTIFIER s}
