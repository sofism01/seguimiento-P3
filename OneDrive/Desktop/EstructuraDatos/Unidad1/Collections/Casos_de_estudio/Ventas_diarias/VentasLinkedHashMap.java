package Collections.Casos_de_estudio.Ventas_diarias;

import java.util.*;

public class VentasLinkedHashMap {
    private LinkedHashMap<String, Producto> ventas;
    
    public VentasLinkedHashMap() {
        ventas = new LinkedHashMap<>();
    }
    
    // Registrar venta usando código como identificador
    public void registrarVenta(String codigo, String nombre, int cantidad, double valorTotal) {
        Producto producto = new Producto(codigo, nombre, cantidad, valorTotal);
        ventas.put(codigo, producto);
        System.out.println("Venta registrada con LinkedHashMap: " + producto);
    }
    
    // Consultar información de un producto por código
    public Producto consultarProducto(String codigo) {
        return ventas.get(codigo);
    }
    
    // Mostrar total ventas registradas
    public void mostrarTotalVentas() {
        System.out.println("TOTAL VENTAS REGISTRADAS (LinkedHashMap)");
        System.out.println("Total de ventas: " + ventas.size());
        double totalValor = 0;
        for (Producto p : ventas.values()) {
            totalValor += p.getValorTotalVenta();
        }
        System.out.println("Valor total de todas las ventas: $" + totalValor);
    }
    
    // Mostrar ventas ordenadas por código de producto
    public void mostrarVentasOrdenadasPorCodigo() {
        System.out.println("VENTAS ORDENADAS POR CÓDIGO (LinkedHashMap)");
        List<String> codigos = new ArrayList<>(ventas.keySet());
        Collections.sort(codigos);
        
        for (String codigo : codigos) {
            System.out.println(ventas.get(codigo));
        }
    }
    
    // Mostrar ventas en el orden exacto en que se registraron
    public void mostrarVentasOrdenRegistro() {
        System.out.println("VENTAS EN ORDEN DE REGISTRO (LinkedHashMap)");
        for (Producto producto : ventas.values()) {
            System.out.println(producto);
        }
    }
    
    public void mostrarTodasLasVentas() {
        System.out.println("TODAS LAS VENTAS (LinkedHashMap)");
        for (Producto producto : ventas.values()) {
            System.out.println(producto);
        }
    }
}