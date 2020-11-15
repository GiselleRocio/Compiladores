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




    private static Integer CANT_AUXILIARES = 0;

    private String assembler = "";

    private Integer NRO_ETIQUETA = 0;

    private Boolean segundaCondicion = true;

Stack<String> pilaEtiquetas = new Stack<>();



    public GeneradorAssembler(){



    }



       public String generarHeaders(List<Simbolo> tablaDeSimbolos){

        String includes =

                "include number.asm\n" +

                        "include macros2.asm\n\n" +

                        ".MODEL LARGE ;Modelo de Memoria\n" +

                        ".386 ;Tipo de Procesador\n" +

                        ".STACK 200h ;Bytes en el Stack\n\n" ; 

                        

        String data =

                ".DATA\n" +

                        "%s\n";

        String dataGenerada = generarData(tablaDeSimbolos);



        return includes + String.format(data, dataGenerada);

    }



    public String generarData(List<Simbolo> listaDeSimbolos) {

        String variablesDeclaradas = listaDeSimbolos.stream()

                .map(this::formatTs)

                .reduce("", (subtotal, linea) -> subtotal + linea);

        String variablesAuxiliares = "";

        /*String variablesAuxiliares = IntStream.range(1, CANT_AUXILIARES + 1)

                .mapToObj(i -> String.format("\t@aux%d\tdd\t?\n", i))

                .reduce("", (subtotal, linea) -> subtotal + linea);*/



        return variablesDeclaradas + "\n" + variablesAuxiliares + "\n";

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

        //String valor = linea.getValor() != null ? Double.valueOf(linea.getValor()).toString() : "?";

        //String nombre = (linea.getNombre().matches("[0-9]+") ? "" : "") + linea.getNombre(); //TODO Ver caso de CONST_STR

        String nombre = linea.getNombre();

        return String.format("\t%s\tdd\t%s\n", nombre, valor);

    }



    public void generarAssembler(List<Simbolo> tablaDeSimbolos, ArrayList<String> polaca) {

        try (BufferedWriter br = new BufferedWriter(new FileWriter("./src/Grupo02/assembler.asm"))) {



            br.write(generarHeaders(tablaDeSimbolos));



        } catch (Exception e) {

            LOGGER.severe("Ocurrio un error al guardar el archivo");

            e.printStackTrace();

        }

    }

    

}