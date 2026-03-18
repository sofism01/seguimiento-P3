package Recursividad;
public class Arreglo {
// Tipos de recursión: DIRECTA, LINEAL, DE COLA.
    // Método recursivo para recorrer un arreglo
    public static void recorrer(int[] arr, int i) {
        if (i >= arr.length) return;  // Caso base
        
        System.out.println(arr[i]);   
        recorrer(arr, i + 1);         // Caso recursivo para pasar al siguiente elemento del arreglo
    }
    
    public static void main(String[] args) {
        int[] numeros = {1, 2, 3, 4, 5};
        recorrer(numeros, 0);
    }
}
