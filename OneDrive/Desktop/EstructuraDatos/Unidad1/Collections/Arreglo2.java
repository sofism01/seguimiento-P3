package Collections;
import java.util.Arrays;

public class Arreglo2 {
    
    public static int[] llenarArreglo(int n) {
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = (int) (Math.random() * 10);  
        }
        return arr;
    }

    public static void main(String[] args) {
        int[] numeros = llenarArreglo(5);
        
        System.out.print("Arreglo antes de ordenar: ");
        for (int i = 0; i < numeros.length; i++) {
            System.out.print(numeros[i] + " ");
        }
        System.out.println();
        
        Arrays.sort(numeros);
        
        System.out.print("Arreglo después de ordenar: ");
        for (int i = 0; i < numeros.length; i++) {
            System.out.print(numeros[i] + " ");
        }
        System.out.println();

        Arrays.binarySearch(numeros, 3);
        System.out.println("El número 3 se encuentra en el índice: " + Arrays.binarySearch(numeros, 3));
    }
    }

