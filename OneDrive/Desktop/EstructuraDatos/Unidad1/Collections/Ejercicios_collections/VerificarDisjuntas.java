package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class VerificarDisjuntas {
    
    public static void main(String[] args) {
        // Crear dos colecciones sin elementos en común
        List<String> animales = new ArrayList<>();
        animales.add("Perro");
        animales.add("Gato");
        animales.add("Pez");
        
        List<String> frutas = new ArrayList<>();
        frutas.add("Manzana");
        frutas.add("Banana");
        frutas.add("Naranja");
        
        // Verificar si no tienen elementos en común
        boolean noTienenEnComun = Collections.disjoint(animales, frutas);
        System.out.println("¿No tienen elementos en común? " + noTienenEnComun);
    }
}