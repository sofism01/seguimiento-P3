package Recursividad;
public class Matriz {
// Tipos de recursión: DIRECTA, LINEAL, DE COLA. 
    // Método recursivo para recorrer una matriz
    public static void recorrer(int[][] matriz, int fila, int col) {
        if (fila >= matriz.length) return;  // Caso base
        if (col >= matriz[fila].length) {   
            recorrer(matriz, fila + 1, 0);  // Caso recursivo #1 para pasar a la siguiente fila
            return;
        }
        
        System.out.print(matriz[fila][col] + " ");  
        recorrer(matriz, fila, col + 1); // Caso recursivo #2 para pasar a la siguiente columna
    }
    
    public static void main(String[] args) {
        int[][] numeros = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        recorrer(numeros, 0, 0);
    }
}
