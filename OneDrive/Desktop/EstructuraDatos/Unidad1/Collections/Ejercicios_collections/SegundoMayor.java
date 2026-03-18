package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class SegundoMayor {
    
    public static void main(String[] args) {
        // Crear una lista de números enteros
        List<Integer> numeros = new ArrayList<>();
        numeros.add(45);
        numeros.add(12);
        numeros.add(78);
        numeros.add(23);
        numeros.add(56);
        
        // Ordenar en orden descendente
        Collections.sort(numeros, Collections.reverseOrder());
        
        // Encontrar el segundo número más grande
        Integer segundoMayor = numeros.get(1);
        
        System.out.println("El segundo número más grande es: " + segundoMayor);
    }
}