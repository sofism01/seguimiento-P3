package Collections.Casos_de_estudio.Ventas_diarias;

public class Producto {
    private String codigo;
    private String nombre;
    private int cantidadVendida;
    private double valorTotalVenta;
    
    public Producto(String codigo, String nombre, int cantidadVendida, double valorTotalVenta) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.cantidadVendida = cantidadVendida;
        this.valorTotalVenta = valorTotalVenta;
    }
    
    // Getters
    public String getCodigo() {
        return codigo;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public int getCantidadVendida() {
        return cantidadVendida;
    }
    
    public double getValorTotalVenta() {
        return valorTotalVenta;
    }
    
    // Setters
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void setCantidadVendida(int cantidadVendida) {
        this.cantidadVendida = cantidadVendida;
    }
    
    public void setValorTotalVenta(double valorTotalVenta) {
        this.valorTotalVenta = valorTotalVenta;
    }
    
    @Override
    public String toString() {
        return "Código: " + codigo + ", Nombre: " + nombre + 
               ", Cantidad: " + cantidadVendida + ", Valor Total: $" + valorTotalVenta;
    }
}
