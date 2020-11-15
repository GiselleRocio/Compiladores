package Tabla;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;
import java.util.Queue;

public class TablaDeSimbolos {

    public static Logger LOGGER = Logger.getLogger(TablaDeSimbolos.class.getName());

    private List<Simbolo> listaDeSimbolos;

    public TablaDeSimbolos() {
        this.listaDeSimbolos = new LinkedList<Simbolo>();
    }

    public void agregarEnTabla(String nombre, String tipo, String valor, Integer longitud) {
        if(!estaEnTabla(nombre)){
            listaDeSimbolos.add(new Simbolo(nombre, tipo, valor, longitud));
        } 
    }

    public Boolean estaEnTabla(String nombre) {
        return listaDeSimbolos.stream().anyMatch(simbolo -> simbolo.getNombre().equals(nombre));
    }

    public void guardarTabla() {

        try (BufferedWriter br = new BufferedWriter(new FileWriter("./src/Grupo02/ts.txt"))) {

            br.write(String.format("%-30s|%-30s|%-30s|%-30s\n", "NOMBRE", "TIPODATO", "VALOR", "LONGITUD"));
            listaDeSimbolos.forEach(simbolo -> {
                try {
                    br.write(simbolo.toString() + "\n");
                } catch (IOException e) {
                    LOGGER.severe("Ocurrio un error al guardar los simbolos");
                    e.printStackTrace();
                }
            });

        } catch (Exception e) {
            LOGGER.severe("Ocurrio un error al guardar el archivo");
            e.printStackTrace();
        }
    }

    public void agregarVariables(Queue<String> colaNombre, Queue<String> colaTipoDato) {
        String nombre;
        String tipoDato;

        if(colaNombre.size() != colaTipoDato.size()) {
            throw new Error("Error de sintaxis: La cantidad de variables declaradas no coincide con la cantidad de tipos de datos declarados."); 
        }
        while(colaNombre.peek() != null ) {
            nombre = colaNombre.poll();
            tipoDato = colaTipoDato.poll();
            if(!estaEnTabla(nombre)) {
                agregarEnTabla("_"+nombre, tipoDato, null, null);
            } else {
                throw new Error("Error de sintaxis: '"+nombre+"' ya esta declarada."); 
            }
        }
    }

    public List<Simbolo> getLista(){

        return listaDeSimbolos;

    }
}