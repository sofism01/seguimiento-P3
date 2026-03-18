package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class AñadirMultiplesElementos {
    
    public static void main(String[] args) {
        // Crear una lista inicial
        List<String> colores = new ArrayList<>();
        colores.add("Rojo");
        colores.add("Azul");
        
        System.out.println("Lista inicial: " + colores);
        
        // Añadir múltiples elementos
        Collections.addAll(colores, "Verde", "Amarillo", "Naranja", "Violeta");
        
        System.out.println("Lista final: " + colores);
    }
}