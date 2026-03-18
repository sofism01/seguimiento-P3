package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class BuscarEnLista {
    
    public static void main(String[] args) {
        // Crear una lista ordenada de enteros
        List<Integer> numeros = new ArrayList<>();
        numeros.add(10);
        numeros.add(25);
        numeros.add(35);
        numeros.add(50);
        numeros.add(70);
        numeros.add(85);
        numeros.add(90);
        
        // Mostrar la lista
        System.out.println("Lista ordenada: " + numeros);
        
        // Buscar un elemento que existe
        int elementoBuscado = 50;
        int indice = Collections.binarySearch(numeros, elementoBuscado);
        
        if (indice >= 0) {
            System.out.println("El elemento " + elementoBuscado + " se encontró en el índice: " + indice);
        } else {
            System.out.println("El elemento " + elementoBuscado + " no se encontró en la lista");
        }
        
        // Buscar un elemento que no existe
        int elementoNoExiste = 40;
        int indiceNoExiste = Collections.binarySearch(numeros, elementoNoExiste);
        
        if (indiceNoExiste >= 0) {
            System.out.println("El elemento " + elementoNoExiste + " se encontró en el índice: " + indiceNoExiste);
        } else {
            System.out.println("El elemento " + elementoNoExiste + " no se encontró en la lista");
        }
    }
}