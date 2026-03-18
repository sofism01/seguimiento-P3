package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class MezclarYOrdenar {
    
    public static void main(String[] args) {
        // Crear una lista de palabras
        List<String> palabras = new ArrayList<>();
        palabras.add("Casa");
        palabras.add("Árbol");
        palabras.add("Perro");
        palabras.add("Libro");
        palabras.add("Flor");
        
        // Mezclar aleatoriamente los elementos
        Collections.shuffle(palabras);
        
        // Ordenar en orden alfabético
        Collections.sort(palabras);
        
        // Mostrar resultado
        System.out.println("Lista ordenada alfabéticamente: " + palabras);
    }
}