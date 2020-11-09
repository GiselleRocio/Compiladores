package Polaca;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Logger;

public class Polaca {

    public static Logger LOGGER = Logger.getLogger(Polaca.class.getName());

    public Polaca(){
        
    }
    public void guardarPolaca(ArrayList<String> polaca) {

        try (BufferedWriter br = new BufferedWriter(new FileWriter("./src/Grupo02/intermedia.txt"))) {

            for(int x = 0; x < polaca.size(); x++){
                try {
                    br.write("Posición: "+ x + ", Valor: " + polaca.get(x) + "\n");
                } catch (IOException e) {
                    LOGGER.severe("Ocurrio un error al guardar la polaca");
                    e.printStackTrace();
                }
            }

        } catch (Exception e) {
            LOGGER.severe("Ocurrio un error al guardar el archivo");
            e.printStackTrace();
        }
    }

}