package Collections.Ejercicios_arrays;
import java.util.Arrays;

public class CompararArrays {
    
    public static void main(String[] args) {
        // Crear dos arrays con el mismo contenido
        int[] array1 = {10, 20, 30, 40, 50};
        int[] array2 = {10, 20, 30, 40, 50};
        
        // Mostrar los arrays
        System.out.println("Array1: " + Arrays.toString(array1));
        System.out.println("Array2: " + Arrays.toString(array2));
        
        // Comparar si son iguales
        boolean sonIguales = Arrays.equals(array1, array2);
        System.out.println("¿Son iguales? " + sonIguales);
        
        // Modificar uno de los arrays
        array2[2] = 99;  // Cambiar el tercer elemento de 30 a 99
        
        // Mostrar los arrays después de la modificación
        System.out.println("\nDespués de modificar array2:");
        System.out.println("Array1: " + Arrays.toString(array1));
        System.out.println("Array2: " + Arrays.toString(array2));
        
        // Volver a comparar
        sonIguales = Arrays.equals(array1, array2);
        System.out.println("¿Son iguales? " + sonIguales);
    }
}