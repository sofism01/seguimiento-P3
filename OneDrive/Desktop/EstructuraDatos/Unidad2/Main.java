public class Main {

    public static void main(String[] args) {
        ListaSimplementeEnlazada<String> lista = new ListaSimplementeEnlazada<>();
        lista.agregarAlFinal("Hola");
        lista.agregarAlFinal("Mundo");
        lista.agregarAlFinal("!");

        System.out.println("Contenido de la lista:");
        lista.imprimir();

        System.out.println("Contenido nuevo de la lista:");
        lista.agregarAlInicio("Sofia");
        lista.imprimir(); 

        System.out.println("Contenido nuevo de la lista:");
        lista.agregarEnPosicion("Java", 2);
        lista.imprimir();

        System.out.println("Contenido nuevo de la lista:");
        lista.eliminarAlFinal();
        lista.imprimir();
    }
    
}
