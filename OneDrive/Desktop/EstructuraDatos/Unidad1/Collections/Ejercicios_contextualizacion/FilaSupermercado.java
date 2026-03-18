package Collections.Ejercicios_contextualizacion;
import java.util.LinkedList;
import java.util.Queue;

public class FilaSupermercado {
    private static Queue<String> fila = new LinkedList<>();
    
    // Método para agregar cliente a la fila
    public static void agregarCliente(String cliente) {
        fila.offer(cliente); // Agrega al final de la fila
        System.out.println("Cliente se formó: " + cliente);
    }
    
    // Método para atender al siguiente cliente
    public static void atenderCliente() {
        if (!fila.isEmpty()) {
            String cliente = fila.poll(); // Elimina y devuelve el primer cliente de la fila
            System.out.println("Atendiendo a: " + cliente);
        } else {
            System.out.println("No hay clientes en la fila");
        }
    }
    
    // Método para mostrar la fila actual
    public static void mostrarFila() {
        if (fila.isEmpty()) {
            System.out.println("La fila está vacía");
        } else {
            System.out.println("Fila actual: " + fila);
            System.out.println("Siguiente en ser atendido: " + fila.peek());
        }
    }
    
    public static void main(String[] args) {
        agregarCliente("Ana");
        agregarCliente("Carlos");
        agregarCliente("María");
        agregarCliente("Pedro");

        mostrarFila();
        
        atenderCliente();  // Ana (primera en llegar)
        atenderCliente();  // Carlos (segundo en llegar)
        
        mostrarFila();
        
        atenderCliente();  // María
        atenderCliente();  // Pedro
        
        mostrarFila();
    }
}