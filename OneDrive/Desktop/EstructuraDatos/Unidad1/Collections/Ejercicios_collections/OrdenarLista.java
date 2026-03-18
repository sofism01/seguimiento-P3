package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class OrdenarLista {
    
    public static void main(String[] args) {
        // Crear una lista de enteros
        List<Integer> numeros = new ArrayList<>();
        numeros.add(45);
        numeros.add(12);
        numeros.add(78);
        numeros.add(23);
        numeros.add(56);
        
        // Ordenar la lista
        Collections.sort(numeros);
        
        // Mostrar la lista ordenada
        System.out.println("Lista ordenada: " + numeros);
    }
}