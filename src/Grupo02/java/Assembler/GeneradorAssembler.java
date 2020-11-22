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
                switch (polaca.get(x)) {
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
                        codigo += gestorBGE();
                    break;
                    case "BGT":
                        codigo += gestorBGT();
                    break;
                    case "BLE":
                         codigo += gestorBLE();
                    break;
                    case "BLT":
                        codigo += gestorBLT();
                    break;
                    case "BEQ":
                        codigo += gestorBEQ();
                    break;
                    case "BNE":
                        codigo += gestorBNE();
                        
                    break;
                    default:
                       codigo += gestorDefault(polaca.get(x), polaca.get(x+1));
                    break;
                }
        }
        return codigo; 
    }

    private String gestorDefault(String variable, String siguiente){
        switch(siguiente){
            case ":":
                return "FSTP " + variable + "\n";
               
            case "GET": // obtener de teclado?
                  return "GetFloat " + variable + "\n";
           
             case "PUT": // mostrar por pantalla
                if(ts.esConstString(variable.replace(" ", "_"))){
                    return "DisplayString " + variable.replace(" ", "_") + "\n";
                } else {
                    return "DisplayFloat " + variable + " , 2 \n"; 
                }
                
            default:
                if (variable.startsWith("_"))
                    return "FLD " + variable + "\n";
                else
                    return "FILD " + variable + "\n";

            
        }

    }

    private String gestorSuma(){

        String cadena = "FADD" + "\n";
        
        return cadena; 
    }
    
    private String gestorResta(){
        String cadena = "FSUB " + "\n";
        return cadena; 
        
    }


    private String gestorMultiplicacion(){

        String cadena = "FMUL " + "\n";
         return cadena; 
        
    }

    private String gestorDivision(){

        String cadena = "FDIV " + "\n";
        return cadena;   
    }

    private String gestorPut(){
        
        return "Display";   
    }

    private String gestorGet(){
        
        return "M"; 
    }

    private String gestorAsig(){
        
        return "FSTP \n";   
    }

    private String gestorCMP(){

        
        return "M";   
    }

    private String gestorBGE(){
;
        
        return "M";   
    }

    private String gestorBGT(){

        
        return "M";   
    }

    private String gestorBLE(){
 
        
        return "M";   
    }

    private String gestorBLT(){

        
        return "M";   
    }

    private String gestorBEQ(){
        
        return "M";   
    }

    private String gestorBNE(){

        return "M";   
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