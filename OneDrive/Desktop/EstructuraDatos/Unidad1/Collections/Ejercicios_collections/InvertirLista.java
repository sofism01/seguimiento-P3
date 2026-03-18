package Collections.Ejercicios_collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class InvertirLista {
    
    public static void main(String[] args) {
        // Crear una lista con elementos
        List<String> palabras = new ArrayList<>();
        palabras.add("Primero");
        palabras.add("Segundo");
        palabras.add("Tercero");
        palabras.add("Cuarto");
        palabras.add("Quinto");
        
        // Mostrar la lista original
        System.out.println("Lista original: " + palabras);
        
        // Invertir el orden de los elementos
        Collections.reverse(palabras);
        
        // Mostrar la lista invertida
        System.out.println("Lista invertida: " + palabras);
    }
}