package Generics;


public class Intercambiar {
public static <T> void intercambiar(T[] arreglo, T elemento1, T elemento2) {
        int i1 = -1, i2 = -1;
        
        for (int i = 0; i < arreglo.length; i++) {
            if (arreglo[i].equals(elemento1)) i1 = i;
            if (arreglo[i].equals(elemento2)) i2 = i;
        }
        
        if (i1 != -1 && i2 != -1) {
            T temp = arreglo[i1];
            arreglo[i1] = arreglo[i2];
            arreglo[i2] = temp;
        }
    }
    
    public static void main(String[] args) {
        String[] nombres = {"Ana", "Luis", "Marta", "Pedro"};
        
        System.out.println("Antes: [Ana, Luis, Marta, Pedro]");
        intercambiar(nombres, "Luis", "Pedro");
        System.out.println("Después: [Ana, Pedro, Marta, Luis]");
    }
}