package Recursividad;
public class DivideYVenceras {
    
    // Método divide y vencerás para mostrar elementos de un arreglo
    public static void mostrarElementos(int[] arr, int inicio, int fin) {
        
        // Caso base: si solo hay un elemento, mostrarlo
        if (inicio == fin) {
            System.out.println("Elemento: " + arr[inicio]);
            return;
        }
        
        // DIVIDIR: encontrar el punto medio
        int medio = (inicio + fin) / 2;
        
        // VENCER: procesar recursivamente cada mitad
        System.out.println("Procesando mitad izquierda [" + inicio + " - " + medio + "]");
        mostrarElementos(arr, inicio, medio);
        
        System.out.println("Procesando mitad derecha [" + (medio + 1) + " - " + fin + "]");
        mostrarElementos(arr, medio + 1, fin);
    }
    
    public static void main(String[] args) {
        int[] numeros = {1, 2, 3, 4};
        System.out.println("DIVIDE Y VENCERÁS - MOSTRAR ELEMENTOS");
        mostrarElementos(numeros, 0, numeros.length - 1);
    }
}
