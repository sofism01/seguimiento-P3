package Collections.Ejercicios_arrays;
import java.util.Arrays;

public class RellenarArray {
    
    public static void main(String[] args) {
        // Declarar variables para tamaño N y valor X
        int N = 8;  // Tamaño del array
        int X = 25; // Valor para rellenar
        
        // Declarar array de tamaño N
        int[] numeros = new int[N];
        
        // Llenar el array con el valor X
        Arrays.fill(numeros, X);
        
        // Mostrar el contenido del array
        System.out.println("Array de tamaño " + N + " rellenado con el valor " + X + ":");
        System.out.println(Arrays.toString(numeros));
    }
}