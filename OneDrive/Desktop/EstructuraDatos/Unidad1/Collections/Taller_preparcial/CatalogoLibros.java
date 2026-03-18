package Collections.Taller_preparcial;

import java.util.*;

// Clase para representar un libro
class Libro {
    private String titulo;
    private String autor;
    private int año;
    private String ISBN;
    
    public Libro(String titulo, String autor, int año, String ISBN) {
        this.titulo = titulo;
        this.autor = autor;
        this.año = año;
        this.ISBN = ISBN;
    }
    
    // Getters
    public String getTitulo() {
        return titulo;
    }
    
    public String getAutor() {
        return autor;
    }
    
    public int getAño() {
        return año;
    }
    
    public String getISBN() {
        return ISBN;
    }
    
    // Setters
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
    
    public void setAutor(String autor) {
        this.autor = autor;
    }
    
    public void setAño(int año) {
        this.año = año;
    }
    
    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }
    
    @Override
    public String toString() {
        return String.format("Libro{título='%s', autor='%s', año=%d, ISBN='%s'}", 
                           titulo, autor, año, ISBN);
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Libro libro = (Libro) obj;
        return Objects.equals(ISBN, libro.ISBN);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(ISBN);
    }
}

public class CatalogoLibros {
    private ArrayList<Libro> libros;
    
    public CatalogoLibros() {
        this.libros = new ArrayList<>();
    }
    
    /**
     * Agregar un libro al catálogo
     */
    public boolean agregarLibro(String titulo, String autor, int año, String ISBN) {
        // Verificar que no existe un libro con el mismo ISBN
        if (buscarPorISBN(ISBN) != null) {
            System.out.println("Error: Ya existe un libro con ISBN " + ISBN);
            return false;
        }
        
        Libro nuevoLibro = new Libro(titulo, autor, año, ISBN);
        libros.add(nuevoLibro);
        System.out.println("Libro agregado exitosamente: " + nuevoLibro);
        return true;
    }
    
    /**
     * Eliminar un libro por ISBN
     */
    public boolean eliminarPorISBN(String ISBN) {
        Iterator<Libro> iterator = libros.iterator();
        while (iterator.hasNext()) {
            Libro libro = iterator.next();
            if (libro.getISBN().equals(ISBN)) {
                iterator.remove();
                System.out.println("Libro eliminado: " + libro);
                return true;
            }
        }
        System.out.println("No se encontró libro con ISBN: " + ISBN);
        return false;
    }
    
    /**
     * Buscar libro por ISBN
     */
    public Libro buscarPorISBN(String ISBN) {
        for (Libro libro : libros) {
            if (libro.getISBN().equals(ISBN)) {
                return libro;
            }
        }
        return null;
    }
    
    /**
     * Buscar libros por autor
     */
    public List<Libro> buscarPorAutor(String autor) {
        List<Libro> librosDelAutor = new ArrayList<>();
        
        for (Libro libro : libros) {
            if (libro.getAutor().toLowerCase().contains(autor.toLowerCase())) {
                librosDelAutor.add(libro);
            }
        }
        
        return librosDelAutor;
    }
    
    /**
     * Listar libros ordenados por año ascendente
     */
    public List<Libro> listarPorAñoAscendente() {
        List<Libro> librosOrdenados = new ArrayList<>(libros);
        
        // Usar Comparator para ordenar por año
        librosOrdenados.sort(Comparator.comparingInt(Libro::getAño));
        
        return librosOrdenados;
    }
    
    /**
     * Obtener los 5 libros más recientes
     */
    public List<Libro> obtenerCincoMasRecientes() {
        List<Libro> librosOrdenados = new ArrayList<>(libros);
        
        // Ordenar por año descendente usando Comparator
        librosOrdenados.sort(Comparator.comparingInt(Libro::getAño).reversed());
        
        // Tomar los primeros 5 (o menos si hay menos de 5 libros)
        int limite = Math.min(5, librosOrdenados.size());
        return librosOrdenados.subList(0, limite);
    }
    
    /**
     * Obtener todos los libros
     */
    public List<Libro> obtenerTodosLosLibros() {
        return new ArrayList<>(libros);
    }
    
    /**
     * Obtener el número total de libros
     */
    public int getTotalLibros() {
        return libros.size();
    }
    
    /**
     * Mostrar estadísticas del catálogo
     */
    public void mostrarEstadisticas() {
        System.out.println("\n=== ESTADÍSTICAS DEL CATÁLOGO ===");
        System.out.println("Total de libros: " + libros.size());
        
        if (!libros.isEmpty()) {
            // Libro más antiguo y más reciente
            List<Libro> ordenados = listarPorAñoAscendente();
            System.out.println("Libro más antiguo: " + ordenados.get(0));
            System.out.println("Libro más reciente: " + ordenados.get(ordenados.size() - 1));
            
            // Contar libros por década
            Map<String, Integer> librosPorDecada = new HashMap<>();
            for (Libro libro : libros) {
                String decada = (libro.getAño() / 10) * 10 + "s";
                librosPorDecada.put(decada, librosPorDecada.getOrDefault(decada, 0) + 1);
            }
            
            System.out.println("\nLibros por década:");
            librosPorDecada.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .forEach(entry -> System.out.println("  " + entry.getKey() + ": " + entry.getValue() + " libros"));
        }
    }
    
    // Método main para probar la funcionalidad
    public static void main(String[] args) {
        CatalogoLibros catalogo = new CatalogoLibros();
        
        System.out.println("=== PRUEBA DEL CATÁLOGO DE LIBROS ===\n");
        
        // Agregar libros de prueba
        System.out.println("1. Agregando libros al catálogo:");
        catalogo.agregarLibro("Cien años de soledad", "Gabriel García Márquez", 1967, "978-84-376-0494-7");
        catalogo.agregarLibro("1984", "George Orwell", 1949, "978-84-9759-564-5");
        catalogo.agregarLibro("El Quijote", "Miguel de Cervantes", 1605, "978-84-376-0987-4");
        catalogo.agregarLibro("Harry Potter y la Piedra Filosofal", "J.K. Rowling", 1997, "978-84-9838-660-7");
        catalogo.agregarLibro("Fundación", "Isaac Asimov", 1951, "978-84-9838-892-2");
        catalogo.agregarLibro("Dune", "Frank Herbert", 1965, "978-84-9838-955-4");
        catalogo.agregarLibro("El Hobbit", "J.R.R. Tolkien", 1937, "978-84-450-7903-1");
        
        // Intentar agregar un libro con ISBN duplicado
        System.out.println("\n2. Intentando agregar libro con ISBN duplicado:");
        catalogo.agregarLibro("Otra obra", "Otro autor", 2020, "978-84-376-0494-7");
        
        // Buscar por autor
        System.out.println("\n3. Buscar libros de 'Tolkien':");
        List<Libro> librosTolkien = catalogo.buscarPorAutor("Tolkien");
        librosTolkien.forEach(System.out::println);
        
        // Listar por año ascendente
        System.out.println("\n4. Libros ordenados por año (ascendente):");
        List<Libro> librosPorAño = catalogo.listarPorAñoAscendente();
        librosPorAño.forEach(System.out::println);
        
        // Obtener los 5 más recientes
        System.out.println("\n5. Los 5 libros más recientes:");
        List<Libro> cincoRecientes = catalogo.obtenerCincoMasRecientes();
        cincoRecientes.forEach(System.out::println);
        
        // Eliminar un libro
        System.out.println("\n6. Eliminando libro con ISBN '978-84-9759-564-5':");
        catalogo.eliminarPorISBN("978-84-9759-564-5");
        
        // Mostrar estadísticas
        catalogo.mostrarEstadisticas();
        
        System.out.println("\n7. Estado final del catálogo (" + catalogo.getTotalLibros() + " libros):");
        catalogo.obtenerTodosLosLibros().forEach(System.out::println);
    }
}
