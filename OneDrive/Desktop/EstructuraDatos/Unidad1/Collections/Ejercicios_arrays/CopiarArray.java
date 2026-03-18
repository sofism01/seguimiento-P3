package Collections.Ejercicios_arrays;
import java.util.Arrays;

public class CopiarArray {
    
    public static void main(String[] args) {
        // Declarar array con números del 1 al 10
        int[] numeros = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        
        // Mostrar array original
        System.out.println("Array original: " + Arrays.toString(numeros));
        
        // Copiar los primeros 5 elementos
        int[] primeros5 = Arrays.copyOf(numeros, 5);
        System.out.println("Primeros 5 elementos: " + Arrays.toString(primeros5));
        
        // Copiar elementos del índice 3 al 7 (incluyendo 3, excluyendo 7)
        int[] rango3a7 = Arrays.copyOfRange(numeros, 3, 7);
        System.out.println("Elementos del índice 3 al 7: " + Arrays.toString(rango3a7));
    }
}