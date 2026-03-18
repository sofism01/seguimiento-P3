package Generics;

public class MostrarElemento {

    public static <T> void mostrar(T elemento) {
        System.out.println(elemento);
    }
    
    public static void main(String[] args) {
        mostrar("Sofia");
        mostrar(18);
        mostrar(3.14);
        mostrar(true);
    }
}
