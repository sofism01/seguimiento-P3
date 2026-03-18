package Generics;

public class ClasePar<T> {
    
    private T primero;
    private T segundo;
    
    public ClasePar(T primero, T segundo) {
        this.primero = primero;
        this.segundo = segundo;
    }
    
    public boolean sonIguales() {
        if (primero == null && segundo == null) {
            return true;
        }
        if (primero == null || segundo == null) {
            return false;
        }
        return primero.equals(segundo);
    }
    
    public static void main(String[] args) {
        ClasePar<String> par1 = new ClasePar<>("Hola", "Hola");
        System.out.println("¿Son iguales? " + par1.sonIguales());
        
        ClasePar<Integer> par2 = new ClasePar<>(5, 3);
        System.out.println("¿Son iguales? " + par2.sonIguales());
    }
}
