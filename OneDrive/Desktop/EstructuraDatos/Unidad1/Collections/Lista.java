package Collections;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Lista {
    public static List<Integer> crearLista() {
        List<Integer> lista = new ArrayList<>();
        
        // Llenar la lista con 5 números aleatorios del 1 al 10
        for (int i = 0; i < 5; i++) {
            lista.add((int) (Math.random() * 10) + 1);
        }
        
        return lista;
    }
    
    public static void main(String[] args) {
        // Crear la lista usando el método crearLista()
        List<Integer> miLista = crearLista();
        
        // Mostrar la lista
        System.out.println("Lista creada: " + miLista);
        // Ordenar la lista
        Collections.sort(miLista);
        System.out.println("Lista ordenada: " + miLista);
        }
    }

