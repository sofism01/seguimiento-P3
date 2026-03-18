package Collections.Ejercicios_contextualizacion;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class VotacionPeliculas {
    private static Set<String> usuariosQueVotaron = new HashSet<>();
    private static Map<String, Integer> votosPorPelicula = new HashMap<>();
    
    // Método para votar por una película
    public static void votar(String usuario, String pelicula) {
        if (usuariosQueVotaron.contains(usuario)) {
            System.out.println(usuario + " ya votó anteriormente");
        } else {
            usuariosQueVotaron.add(usuario);
            votosPorPelicula.put(pelicula, votosPorPelicula.getOrDefault(pelicula, 0) + 1);
            System.out.println(usuario + " votó por: " + pelicula);
        }
    }
    
    // Método para mostrar resultados
    public static void mostrarResultados() {
        System.out.println("Resultados de votación:");
        for (Map.Entry<String, Integer> entrada : votosPorPelicula.entrySet()) {
            System.out.println("- " + entrada.getKey() + ": " + entrada.getValue() + " votos");
        }
        System.out.println("Total de usuarios que votaron: " + usuariosQueVotaron.size());
    }
    
    public static void main(String[] args) {
        votar("Ana", "Avengers");
        votar("Carlos", "Titanic");
        votar("Ana", "Matrix");  
        votar("María", "Avengers");
        votar("Pedro", "Titanic");
        votar("Carlos", "Avengers");  
        votar("Luis", "Matrix");
        
        mostrarResultados();
    }
}