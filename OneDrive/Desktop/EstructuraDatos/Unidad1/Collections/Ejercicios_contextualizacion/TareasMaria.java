package Collections.Ejercicios_contextualizacion;
import java.util.ArrayList;
import java.util.List;

public class TareasMaria {
    private static List<String> tareas = new ArrayList<>();
    
    // Método para agregar una tarea (permite duplicados)
    public static void agregarTarea(String tarea) {
        tareas.add(tarea);
        System.out.println("Tarea agregada: " + tarea);
    }
    
    // Método para mostrar todas las tareas en orden
    public static void mostrarTareas() {
        System.out.println("Tareas:");
        for (int i = 0; i < tareas.size(); i++) {
            System.out.println((i + 1) + ". " + tareas.get(i));
        }
    }
    
    public static void main(String[] args) {
        agregarTarea("Comprar leche");
        agregarTarea("Enviar correo a Pedro");
        agregarTarea("Comprar leche");  
        agregarTarea("Enviar correo a Pedro");  
        
        mostrarTareas();
    }
}