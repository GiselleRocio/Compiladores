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
    int RANGO_ENTERO = 65535;
    private Symbol symbol(int type) {
          //System.out.println("[LEX] TOKEN < " + Simbolos.terminalNames[type] + " > : " + yytext());
          return new Symbol(type, yyline, yycolumn, yytext());
    }
    private Symbol symbol(int type, Object value) {
          return new Symbol(type, yyline, yycolumn, value);
    }
%}

DIGITO 	        =	[0-9]
LETRA 	        =	[a-zA-z]
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
OP_AND          =   "&&"
OP_OR           =   "||"
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
INTEGER	        =	"Integer"
FLOAT       	=	"Float"
WHILE       	=	"while"
IF	            =	"if"
ELSE        	=	"Else"


CONST_INT 	    =	 {DIGITO}+
CONST_FLOAT     =	 {DIGITO}+"."{DIGITO}+
CONST_STR 	    =	  \".*\"
CTE_BINARIA     =    "0b"{DIGITO_BINARIO}+
CTE_HEXA        =    "0x"{DIGITO_HEXA}+

ID 		        =	{LETRA}({LETRA}|{DIGITO})*

%%
<YYINITIAL> {
{PUT} 		     {return symbol(Simbolos.PUT);}
{GET} 		     {return symbol(Simbolos.GET);}
{DIM} 	    	 {return symbol(Simbolos.DIM);}
{AS} 		     {return symbol(Simbolos.AS);}
{INTEGER} 		 {return symbol(Simbolos.INTEGER);}
{FLOAT} 		 {return symbol(Simbolos.FLOAT);}
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

{COMA}	    	 {return symbol(Simbolos.COMA);}
{PYC}	         {return symbol(Simbolos.PYC);}
{PA}	    	 {return symbol(Simbolos.PA);}
{PC}	    	 {return symbol(Simbolos.PC);}
{LA}	    	 {return symbol(Simbolos.LA);}
{LC}	    	 {return symbol(Simbolos.LC);}
{CA}	         {return symbol(Simbolos.CA);}
{CC}	         {return symbol(Simbolos.CC);}




{CTE_HEXA}  	      {return symbol(Simbolos.CTE_HEXA);}
{CTE_BINARIA}	      {return symbol(Simbolos.CTE_BINARIA);}
{CONST_INT}				{
                            Integer constInt = Integer.parseInt(yytext());
                            if(constInt >= 0 && constInt <= RANGO_ENTERO){
                                System.o
                                return symbol(Simbolos.CONST_INT);

                            }
                                
                             else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de la cadena string");
                        }
{CONST_STR}             {
                            String constStr = yytext();
                            if(constStr.length() <= 32)
                                return symbol(Simbolos.CONST_STR);
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los enteros");
                        }
{CONST_FLOAT}	        {
                            Double constFloat = Double.parseDouble(yytext());
                            if( constFloat >= 0 && constFloat <= 2147483648L)
                                return symbol(Simbolos.CONST_FLOAT);
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los flotantes");
                        }



{ID}				    {  return symbol(Simbolos.ID); }

.						{   }
}