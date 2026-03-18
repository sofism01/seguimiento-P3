package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class RellenarLista {
    
    public static void main(String[] args) {
        // Crear una lista con elementos iniciales
        List<String> frutas = new ArrayList<>();
        frutas.add("Manzana");
        frutas.add("Banana");
        frutas.add("Naranja");
        frutas.add("Pera");
        frutas.add("Uva");
        
        // Mostrar la lista original
        System.out.println("Lista original: " + frutas);
        
        // Rellenar todos los elementos con un valor específico
        Collections.fill(frutas, "Fresa");
        
        // Mostrar la lista después de rellenar
        System.out.println("Lista rellenada: " + frutas);
    }
}