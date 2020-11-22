package Assembler;
import Tabla.*;
import Polaca.*;
import java.util.Stack;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;


public class GeneradorAssembler{

    public static Logger LOGGER = Logger.getLogger(GeneradorAssembler.class.getName());
    List<Simbolo> listaDeSimbolos;
    TablaDeSimbolos ts= new TablaDeSimbolos();
    private Boolean huboSalto = false;

    public GeneradorAssembler(){
    }

       public String generarHeaders(){
        String includes =
                "include number.asm\n" +
                        "include macros2.asm\n\n" +
                        ".MODEL LARGE ;Modelo de Memoria\n" +
                        ".386 ;Tipo de Procesador\n" +
                        ".STACK 200h ;Bytes en el Stack\n\n" ;                        
        String data =
                ".DATA\n" +
                        "%s\n";

        String dataGenerada = generarData();
        return includes + String.format(data, dataGenerada);

    }

    public String generarData() {

        String variablesDeclaradas = listaDeSimbolos.stream()
                .map(this::formatTs)
                .reduce("", (subtotal, linea) -> subtotal + linea);

        return variablesDeclaradas + "\n";

    }

    private String formatTs(Simbolo linea) {
        String valor = ""; 

        if(linea.getValor() != null ) {
            if(linea.getLongitud() != null) {
                valor  = "\"" + linea.getValor() +"\"";
                String nombre = linea.getNombre();
                return String.format("\t%s\tdb\t%s,'$',%d dup(?)\n", nombre, valor, linea.getLongitud());

            } else {
                valor = Double.valueOf(linea.getValor()).toString();
            }
        } else {
            valor = "?";
        }

        String nombre = linea.getNombre();
        return String.format("\t%s\tdd\t%s\n", nombre, valor);

    }

    private String generarCodigo(ArrayList<String> polaca){
 
        String codigo =
                ".CODE\n\n" +
                        "start:\n" +
                        "\tMOV EAX,@DATA\n" +
                        "\tMOV DS,EAX\n" +
                        "\tMOV ES,EAX\n\n";

        for(int x = 0 ; x < polaca.size(); x++){
            String contenido = polaca.get(x);
            if(contenido.startsWith("ET")) {
                codigo += contenido;
                if(!huboSalto) {
                    codigo += ":";
                }
                huboSalto = false;
                codigo+="\n";
            } else {
                switch (contenido) {
                    case "+":
                        codigo += gestorSuma();
                        break;
                    case "-":
                        codigo += gestorResta();
                        break;
                    case "*":
                        codigo += gestorMultiplicacion();
                        break;
                    case "/":
                        codigo += gestorDivision();
                        break;
                    case "PUT":
                    case "GET":
                    case ":":
                        break;
                    case "CMP":
                        codigo += gestorCMP();
                        break;
                    case "BGE":
                        huboSalto = true;
                        codigo += gestorBGE();
                        break;
                    case "BGT":
                        huboSalto = true;
                        codigo += gestorBGT();
                        break;
                    case "BLE":
                        huboSalto = true;
                        codigo += gestorBLE();
                        break;
                    case "BLT":
                        huboSalto = true;
                        codigo += gestorBLT();
                        break;
                    case "BEQ":
                        huboSalto = true;
                        codigo += gestorBEQ();
                        break;
                    case "BNE":
                        huboSalto = true;
                        codigo += gestorBNE();
                        break;
                    case "BI":
                        huboSalto = true;
                        codigo += gestorBI();
                        break;
                    default:
                        String contenidoSiguiente = polaca.get(x + 1);
                        codigo += gestorDefault(contenido, contenidoSiguiente);
                        break;
                }
            }
        }
        return codigo; 
    }

    private String gestorDefault(String variable, String siguiente){
        String cadena;
        switch(siguiente){
            case ":":
                return "\tFSTP " + variable + "\n";
            case "GET": // obtener de teclado
                  return "\tGetFloat " + variable + "\n";
             case "PUT": // mostrar por pantalla
                if(ts.esConstString(variable)){
                    cadena = "\tDisplayString " + variable + "\n";
                } else {
                    cadena = "\tDisplayFloat " + variable + " , 2 \n";
                }
                cadena += "\tnewline 1\n";
                return cadena;
            default:
                return "\tFLD " + variable + "\n";
                //if (variable.startsWith("_"))
                    //return "FLD " + variable + "\n"; 
                //else
                    //return "FILD " + variable + "\n"; // me parece que esto no va asi

            
        }

    }

    private String gestorSuma(){
        String cadena = "\tFADD" + "\n";
        return cadena; 
    }
    
    private String gestorResta(){
        String cadena = "\tFSUB " + "\n";
        return cadena;
    }

    private String gestorMultiplicacion(){
        String cadena = "\tFMUL " + "\n";
         return cadena;
    }

    private String gestorDivision(){
        String cadena = "\tFDIV " + "\n";
        return cadena;   
    }

    private String gestorCMP(){
        String cadena = "\tFXCH\n" +
                "\tFCOMP\n" +
                "\tFSTSW AX\n" +
                "\tSAHF\n" +
                "\tFFREE\n";
        return cadena;
    }

    private String gestorBGE(){
        String cadena = "\tJAE ";
        return cadena;
    }

    private String gestorBGT(){
        String cadena = "\tJA ";
        return cadena;
    }

    private String gestorBLE(){
        String cadena = "\tJBE ";
        return cadena;
    }

    private String gestorBLT(){
        String cadena = "\tJB ";
        return cadena;
    }

    private String gestorBEQ(){
        String cadena = "\tJE ";
        return cadena;
    }

    private String gestorBNE(){
        String cadena = "\tJNE ";
        return cadena;
    }

    private String gestorBI(){
        String cadena = "\tJMP ";
        return cadena;
    }

    public String generarFooter(){
        return "\tMOV EAX, 4C00h\n" +
        "\tINT 21h\n\n" +
        "\tEND start";
    }

    public void generarAssembler(TablaDeSimbolos ts, ArrayList<String> polaca) {
        this.ts= ts; 
        this.listaDeSimbolos = ts.getLista() ;

        try (BufferedWriter br = new BufferedWriter(new FileWriter("./src/Grupo02/Final.asm"))) {
           // br.write(generarHeaders(tablaDeSimbolos));
            String data = generarHeaders();
            data += generarCodigo(polaca);
            data += generarFooter();
            br.write(data);
        } catch (Exception e) {
            LOGGER.severe("Ocurrio un error al guardar el archivo");
            e.printStackTrace();
        }
    }
    

}