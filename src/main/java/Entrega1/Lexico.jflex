
%%      /* Directivas */

%class lexico
%standalone
%column
%line

%{
int RANGO_ENTERO = 65535;
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
DECVAR 	        =	"DECVAR"
INTEGER	        =	"Integer"
FLOAT       	=	"Float"
ENDDEC      	=	"ENDDEC"
WRITE       	=	"write"
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

{PUT} 		    |
{GET} 		    |
{DIM} 	    	|
{AS} 		    |
{DECVAR} 		|
{INTEGER} 		|
{FLOAT} 		|
{ENDDEC} 		|
{WHILE} 		|
{WRITE} 		|
{ELSE}   		|
{IF}		    		{ System.out.printf("\n Palabra reservada : [%s] ", yytext()) ; }

{OP_AS}			|
{OP_SUM}		|
{OP_RES}		|
{OP_DIV}		|
{OP_MUL}		|
{OP_MEN}		|
{OP_MENIG}		|
{OP_MAY}		|
{OP_MAYIG}		|
{OP_DIST}		|
{OP_COMP}		        { System.out.printf("\n Operador : [%s] ", yytext()) ; }

{COMA}	    	|
{PYC}	       	|
{PA}	    	|
{PC}	    	|
{LA}	    	|
{LC}	    	|
{CA}	    	|
{CC}	            	{ System.out.printf("\n Simbolo : [%s] ", yytext()) ; }




{CTE_HEXA}  	|
{CTE_BINARIA}	        { System.out.printf("\n Constante  : [%s] ", yytext()); }
{CONST_INT}				{
                            Integer constInt = Integer.parseInt(yytext());
                            if(constInt >= 0 && constInt <= RANGO_ENTERO)
                                System.out.printf("\n Constante entera : [%s] ", yytext());
                             else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de la cadena string");
                        }
{CONST_STR}             {
                            String constStr = yytext();
                            if(constStr.length() <= 32)
                                System.out.printf("\n Constante string : [%s] ", yytext());
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los enteros");
                        }
{CONST_FLOAT}	        {
                            Double constFloat = Double.parseDouble(yytext());
                            if( constFloat >= 0 && constFloat <= 2147483648L)
                                System.out.printf("\n Constante float : [%s] ", yytext());
                            else
                                throw new Error("La constante [" + yytext() + "] esta fuera del limite de los flotantes");
                        }



{ID}				    { System.out.printf("\n ID  : [%s] ", yytext()) ; }

.						{ System.out.printf("\n Simbolo NO reconocido: [%s] ", yytext()) ; }
