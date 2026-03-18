package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ContarPalabras {
    
    public static void main(String[] args) {
        // Crear una lista de palabras
        List<String> palabras = new ArrayList<>();
        palabras.add("Gato");
        palabras.add("Perro");
        palabras.add("Gato");
        palabras.add("Pez");
        palabras.add("Gato");
        palabras.add("Perro");
        
        // Contar cuántas veces aparece una palabra específica
        String palabraBuscada = "Gato";
        int frecuencia = Collections.frequency(palabras, palabraBuscada);
        
        // Mostrar resultado
        System.out.println("La palabra '" + palabraBuscada + "' aparece " + frecuencia + " veces");
    }
}