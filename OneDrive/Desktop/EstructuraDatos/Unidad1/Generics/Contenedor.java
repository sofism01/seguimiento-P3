package Generics;

import java.util.ArrayList;

interface IContenedor<T> {
    void agregar(T item);
    T obtener(int indice);
}

public class Contenedor<T> implements IContenedor<T> {
    private ArrayList<T> lista;
    
    public Contenedor() {
        lista = new ArrayList<>();
    }
    
    public void agregar(T item) {
        lista.add(item);
    }
    
    public T obtener(int indice) {
        return lista.get(indice);
    }
    
    public static void main(String[] args) {
        Contenedor<String> contenedor = new Contenedor<>();
        
        contenedor.agregar("Hola");
        contenedor.agregar("Mundo");
        
        System.out.println(contenedor.obtener(0));
        System.out.println(contenedor.obtener(1));
    }
}
