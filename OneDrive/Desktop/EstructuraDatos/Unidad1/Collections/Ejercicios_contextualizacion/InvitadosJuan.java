package Collections.Ejercicios_contextualizacion;
import java.util.HashSet;
import java.util.Set;

public class InvitadosJuan {
    private static Set<String> invitados = new HashSet<>();
    
    // Método para agregar un invitado (no permite duplicados)
    public static void agregarInvitado(String nombre) {
        if (invitados.add(nombre)) {
            System.out.println("Invitado agregado: " + nombre);
        } else {
            System.out.println("Ya está registrado: " + nombre);
        }
    }
    
    // Método para mostrar todos los invitados
    public static void mostrarInvitados() {
        System.out.println("Lista de invitados (" + invitados.size() + " personas):");
        for (String invitado : invitados) {
            System.out.println("- " + invitado);
        }
    }
    
    public static void main(String[] args) {
        agregarInvitado("Ana");
        agregarInvitado("Carlos");
        agregarInvitado("Ana");  
        agregarInvitado("María");
        agregarInvitado("Carlos");  
        agregarInvitado("Pedro");
        
        mostrarInvitados();
    }
}