package Generics;

public class ClaseCaja<T> {
    
    private T contenido;
    
    public void guardar(T valor) {
        this.contenido = valor;
    }
    
    public T obtener() {
        return contenido;
    }
    
    public static void main(String[] args) {
        ClaseCaja<String> cajaString = new ClaseCaja<>();
        cajaString.guardar("Hola Mundo");
        System.out.println("Valor1: " + cajaString.obtener());
        
        ClaseCaja<Integer> cajaInteger = new ClaseCaja<>();
        cajaInteger.guardar(42);
        System.out.println("Valor2: " + cajaInteger.obtener());
    }
}
