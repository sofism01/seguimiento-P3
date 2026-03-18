package Collections.Ejercicios_contextualizacion;
import java.util.HashMap;
import java.util.Map;

public class AgendaLucia {
    private static Map<String, String> agenda = new HashMap<>();
    
    // Método para agregar un contacto
    public static void agregarContacto(String nombre, String telefono) {
        if (agenda.containsKey(nombre)) {
            System.out.println("Contacto actualizado: " + nombre + " -> " + telefono);
        } else {
            System.out.println("Contacto agregado: " + nombre + " -> " + telefono);
        }
        agenda.put(nombre, telefono);
    }
    
    // Método para mostrar todos los contactos
    public static void mostrarContactos() {
        System.out.println("Agenda telefónica (" + agenda.size() + " contactos):");
        for (Map.Entry<String, String> contacto : agenda.entrySet()) {
            System.out.println("- " + contacto.getKey() + ": " + contacto.getValue());
        }
    }
    
    public static void main(String[] args) {
       
        agregarContacto("Ana", "123-456-789");
        agregarContacto("Carlos", "987-654-321");
        agregarContacto("Ana", "111-222-333"); 
        agregarContacto("María", "555-666-777");
        agregarContacto("Carlos", "444-555-666");  
        
        mostrarContactos();
    }
}