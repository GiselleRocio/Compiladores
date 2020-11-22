package Analizadores;
import java_cup.runtime.*;

%%      /* Directivas */
%public
%class AnalizadorLexico
%cupsym Simbolos
%cup
%column
%line
%ignorecase
%unicode

%{
    int RANGO_ENTERO = 65536;
    private Symbol symbol(int type) {
          return new Symbol(type, yyline, yycolumn, yytext());
    }
    private Symbol symbol(int type, Object value) {
          return new Symbol(type, yyline, yycolumn, value);
    }
%}

DIGITO 	        =	[0-9]
LETRA 	        =	[a-zA-Z]
DIGITO_BINARIO  =   [0-1]
DIGITO_HEXA     =   [a-fA-F0-9]

OP_AS 	        =	":"
OP_SUM	        =	"+"
OP_RES          =   "-"
OP_DIV	        =	"/"
OP_MUL      	=	"*"
OP_MEN      	=	"<"
OP_MENIG        =	"<="
OP_MAY      	=	">"
OP_MAYIG        =	">="
OP_DIST     	=	"<>"
OP_COMP         =	"=="
OP_AND          =   "and"
OP_OR           =   "or"
OP_NOT          =   "not"
COMA        	=	","
PYC             =   ";"
PA            	=	"("
PC      	    =	")"
LA      	    =	"{"
LC      	    =	"}"
CA              =   "["
CC              =   "]"

PUT             =   "PUT"
GET             =   "GET"
DIM             =   "DIM"
AS              =   "AS"
CONTAR          =   "contar"
INTEGER	        =	"Integer"
FLOAT       	=	"Float"
STRING          =   "String"
WHILE       	=	"while"
IF	            =	"if"
ELSE        	=	"else"


CONST_INT 	    =	 {DIGITO}+
CONST_FLOAT     =	 {DIGITO}+"."{DIGITO}+
CONST_STR 	    =	  \".*\"



CTE_BIN         =    "0b"{DIGITO_BINARIO}+
CTE_HEXA        =    "0x"{DIGITO_HEXA}+

ID 		        =	{LETRA}({LETRA}|{DIGITO})*
COMENTARIO      =   "*-".*"-*"

%%
<YYINITIAL> {
{PUT} 		     {
                    
                    return symbol(Simbolos.PUT);}
{GET} 		     {return symbol(Simbolos.GET);}
{DIM} 	    	 {return symbol(Simbolos.DIM);}
{AS} 		     {return symbol(Simbolos.AS);}
{CONTAR} 		 {return symbol(Simbolos.CONTAR);}
{INTEGER} 		 {return symbol(Simbolos.INTEGER);}
{FLOAT} 		 {return symbol(Simbolos.FLOAT);}
{STRING} 		 {return symbol(Simbolos.STRING);}
{WHILE} 		 {return symbol(Simbolos.WHILE);}
{ELSE}   		 {return symbol(Simbolos.ELSE);}
{IF}		     {return symbol(Simbolos.IF);}

{OP_AS}			 {return symbol(Simbolos.OP_AS);}
{OP_SUM}		 {return symbol(Simbolos.OP_SUM);}
{OP_RES}		 {return symbol(Simbolos.OP_RES);}
{OP_DIV}		 {return symbol(Simbolos.OP_DIV);}
{OP_MUL}		 {return symbol(Simbolos.OP_MUL);}
{OP_MEN}		 {return symbol(Simbolos.OP_MEN);}
{OP_MENIG}		 {return symbol(Simbolos.OP_MENIG);}
{OP_MAY}		 {return symbol(Simbolos.OP_MAY);}
{OP_MAYIG}		 {return symbol(Simbolos.OP_MAYIG);}
{OP_DIST}		 {return symbol(Simbolos.OP_DIST);}
{OP_COMP}		 {return symbol(Simbolos.OP_COMP);}
{OP_AND}		 {return symbol(Simbolos.OP_AND);}
{OP_OR}		     {return symbol(Simbolos.OP_OR);}
{OP_NOT}		 {return symbol(Simbolos.OP_NOT);}

{COMA}	    	 {return symbol(Simbolos.COMA);}
{PYC}	         {return symbol(Simbolos.PYC);}
{PA}	    	 {return symbol(Simbolos.PA);}
{PC}	    	 {return symbol(Simbolos.PC);}
{LA}	    	 {return symbol(Simbolos.LA);}
{LC}	    	 {return symbol(Simbolos.LC);}
{CA}	         {return symbol(Simbolos.CA);}
{CC}	         {return symbol(Simbolos.CC);}

{COMENTARIO}        {}

{CTE_HEXA}  	      {return symbol(Simbolos.CTE_HEXA);}
{CTE_BIN}	      {return symbol(Simbolos.CTE_BIN);}
{CONST_INT}				{
                            Integer constInt = Integer.parseInt(yytext());
                            if(constInt >= -65536 && constInt <= RANGO_ENTERO ){
                                return symbol(Simbolos.CONST_INT);

                            }
                                
                             else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los enteros");
                        }
{CONST_STR}             {
                            String constStr = yytext();
                            if(constStr.length() <= 32)
                                return symbol(Simbolos.CONST_STR);
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de las cadenas");
                        }
{CONST_FLOAT}	        {
                            Double constFloat = Double.parseDouble(yytext());
                            if(constFloat >= -4294967296L && constFloat <= 4294967296L)
                                return symbol(Simbolos.CONST_FLOAT);
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los flotantes");
                        }



{ID}				    {  return symbol(Simbolos.ID); }

}

//--------> Simbolos Exp Reg
[\ \t\r\n\f]          {/*Espacios en blanco, se ignoran*/}


//--------> Errores Lexicos
.                   {
                        System.out.println("Error Léxico "+ yytext()+" Linea "+yyline+" Columna "+yycolumn);
                        throw new Error("Error lexico");
                    }