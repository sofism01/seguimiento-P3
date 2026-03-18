package Collections.Ejercicios_arrays;
import java.util.Arrays;

public class OrdenarYBuscar {
    
    public static void main(String[] args) {
        // Array de enteros desordenado
        int[] numeros = {45, 12, 78, 23, 56, 89, 34, 67, 15};
        
        // Ordenar el array
        Arrays.sort(numeros);
        System.out.println("Array ordenado: " + Arrays.toString(numeros));
        
        // Valor a buscar
        int valorBuscado = 56;
        
        // Buscar el valor en el array ordenado
        int posicion = Arrays.binarySearch(numeros, valorBuscado);
        
        // Mostrar resultado de la búsqueda
        if (posicion >= 0) {
            System.out.println("El valor " + valorBuscado + " se encontró en la posición: " + posicion);
        } else {
            System.out.println("El valor " + valorBuscado + " no se encontró en el array");
        }
    }
}