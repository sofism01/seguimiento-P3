package Collections.Ejercicios_arrays;
import java.util.Arrays;

public class ArrayACadena {
    
    public static void main(String[] args) {
        // Declarar un array con algunos nombres
        String[] nombres = {"Ana", "Carlos", "María", "Pedro", "Lucía"};
        
        // Convertir el array a cadena usando Arrays.toString()
        String cadena = Arrays.toString(nombres);
        
        // Mostrar el resultado
        System.out.println("Array original: " + cadena);
        System.out.println("Número de elementos: " + nombres.length);
    }
}