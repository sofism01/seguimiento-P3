package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ListasCompletamenteDiferentes {
    
    public static void main(String[] args) {
        // Crear dos listas de números
        List<Integer> lista1 = new ArrayList<>();
        lista1.add(10);
        lista1.add(20);
        lista1.add(30);
        
        List<Integer> lista2 = new ArrayList<>();
        lista2.add(40);
        lista2.add(50);
        lista2.add(60);
        
        // Determinar si son completamente diferentes
        boolean sonCompletamenteDiferentes = Collections.disjoint(lista1, lista2);
        
        // Mostrar resultado
        System.out.println("¿Las listas son completamente diferentes? " + sonCompletamenteDiferentes);
    }
}