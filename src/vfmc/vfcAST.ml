(* Verified Featherweight C AST *)

type var_id = string
type field_id = string
type struct_id = string
type fun_id = string
type inv_id = string

type vfc_type =
  | Bool
  | Byte
  | Int
  | Struct of struct_id
  | Pointer of vfc_type
  | Void_ptr
  | Thread_ptr
  | Array of vfc_type * int 

and pvar_kind =    
  | Parameter
  | Local
  | Global
	
and pvar = {
  vname: var_id;
  vtype: vfc_type;
  kind: pvar_kind;
}

and op = 
  | Add 
  | Sub 
  | Neg
  | Mult 
  | Cmpeq
  | Cmpne
  | Cmpgt
  | Cmplt
  | Cmpge
  | Cmple
  | And
  | Or 

and const =
(*  | Null_const*)
  | Int_const of int
  | Bool_const of bool
  
and pexp = 
  | Const of const
  | PVar_ref of var_id
  | Prim_op of op * (pexp list) 
  (*| JVar of var*)
 
and field = {
  fname : field_id; 
  ftype : vfc_type; 
  offset : int;
  parent : struct_id;
}

and stmt = 
  | PVar_decl of pvar 
  | Assign of var_id * pexp
  | Cast of var_id * vfc_type * pexp  
  | Heap_read of var_id * pexp * (field_id option)
  | Heap_assn of pexp * (field_id option) * pexp
  | Skip
  | If of pexp * stmt * stmt
  | While of pexp * inv_id option * stmt
  | Return of pexp option
  | Fun_call of (var_id option) * fun_id * pexp list
  | Block of stmt list 
  | Fork of var_id * fun_id * pexp list
  | Join of pexp 
  | Inv of inv_id
  | Abstract
(*
  | Alloc of var_id * pexp
  | Free of pexp 
  | Get of pexp * pexp * pexp * pexp 
  | Put of pexp * pexp * pexp * pexp
  | Wait of pexp   
*)

and fun_def = {
  fun_name : fun_id;
  ret_type : vfc_type option; 
  params : pvar list; 
(*  requires : lexp; 
  ensures : lexp;  *)
  body : stmt
}

and struct_def = {
  sname : struct_id; 
  fields : field list; 
}

type vfc_decl = 
  | Fun_decl of fun_def
  | Struct_decl of struct_def
 
type vfc_prog = vfc_decl list
