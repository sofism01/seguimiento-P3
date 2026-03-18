package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class CopiarLista {
    
    public static void main(String[] args) {
        // Crear lista fuente con elementos
        List<String> listaFuente = new ArrayList<>();
        listaFuente.add("Java");
        listaFuente.add("Python");
        listaFuente.add("JavaScript");
        listaFuente.add("C++");
        
        // Crear lista destino con el tamaño necesario
        List<String> listaDestino = new ArrayList<>(Collections.nCopies(listaFuente.size(), ""));
        
        // Mostrar listas antes de copiar
        System.out.println("Lista fuente: " + listaFuente);
        System.out.println("Lista destino antes: " + listaDestino);
        
        // Copiar el contenido de la lista fuente a la destino
        Collections.copy(listaDestino, listaFuente);
        
        // Mostrar listas después de copiar
        System.out.println("Lista fuente: " + listaFuente);
        System.out.println("Lista destino después: " + listaDestino);
    }
}