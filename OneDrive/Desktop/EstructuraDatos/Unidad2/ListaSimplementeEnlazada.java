public class ListaSimplementeEnlazada<T> {
    private Nodo<T> cabeza;

    public ListaSimplementeEnlazada() {
        this.cabeza = null;
    }

    // Agrega un nuevo nodo al final de la lista
    public void agregarAlFinal(T valor) {
        Nodo<T> nuevoNodo = new Nodo<>(valor);
        if (cabeza == null) {
            cabeza = nuevoNodo;
        } else {
            Nodo<T> actual = cabeza;
            while (actual.getSiguiente() != null) {
                actual = actual.getSiguiente();
            }
            actual.setSiguiente(nuevoNodo);
        }
    }

    // Agrega un nuevo nodo al inicio de la lista
    public void agregarAlInicio(T valor) {
        Nodo<T> nuevoNodo = new Nodo<>(valor);
        nuevoNodo.setSiguiente(cabeza);
        cabeza = nuevoNodo;
    }

    // Agrega en una posición específica
    public void agregarEnPosicion(T valor, int posicion) {
        if (posicion < 0) {
            throw new IllegalArgumentException("La posición no puede ser negativa.");
        }
        Nodo<T> nuevoNodo = new Nodo<>(valor);
        if (posicion == 0) {
            nuevoNodo.setSiguiente(cabeza);
            cabeza = nuevoNodo;
            return;
        }
        Nodo<T> actual = cabeza;
        for (int i = 0; i < posicion - 1; i++) {
            if (actual == null) {
                throw new IllegalArgumentException("La posición excede el tamaño de la lista.");
            }
            actual = actual.getSiguiente();
        }
        if (actual == null) {
            throw new IllegalArgumentException("La posición excede el tamaño de la lista.");
        }
        nuevoNodo.setSiguiente(actual.getSiguiente());
        actual.setSiguiente(nuevoNodo);
    }

    // ELimina un nodo al final de la lista
    public void eliminarAlFinal() {
        if (cabeza == null) {
            return; // Lista vacía
        }
        if (cabeza.getSiguiente() == null) {
            cabeza = null; // Solo un nodo en la lista
            return;
        }
        Nodo<T> actual = cabeza;
        while (actual.getSiguiente().getSiguiente() != null) {
            actual = actual.getSiguiente();
        }
        actual.setSiguiente(null); // Elimina el último nodo
    }

    // Imprime el contenido de la lista
    public void imprimir() {
        Nodo<T> actual = cabeza;
        while (actual != null) {
            System.out.print(actual.getValor() + " -> ");
            actual = actual.getSiguiente();
        }
        System.out.println("null");
    }
    
}
