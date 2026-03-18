package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ValorMinimo {
    
    public static void main(String[] args) {
        // Crear una lista con números
        List<Integer> numeros = new ArrayList<>();
        numeros.add(45);
        numeros.add(12);
        numeros.add(78);
        numeros.add(3);
        numeros.add(56);
        numeros.add(23);
        
        // Mostrar la lista
        System.out.println("Lista de números: " + numeros);
        
        // Encontrar el valor mínimo
        Integer valorMinimo = Collections.min(numeros);
        
        // Mostrar el resultado
        System.out.println("El valor mínimo es: " + valorMinimo);
    }
}