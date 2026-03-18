package Recursividad;
public class Diagonal {
// Tipos de recursión: DIRECTA, LINEAL, DE COLA.
    // Método recursivo para recorrer la diagonal principal
    public static void recorrerDiagonal(int[][] matriz, int i) {
        if (i >= matriz.length || i >= matriz[0].length) return;  // Caso base
        
        System.out.print(matriz[i][i] + " "); 
        recorrerDiagonal(matriz, i + 1); // Caso recursivo para pasar al siguiente elemento de la diagonal
    }
    
    public static void main(String[] args) {
        int[][] numeros = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };
        recorrerDiagonal(numeros, 0);
    }
}
