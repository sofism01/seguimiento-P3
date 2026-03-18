package Collections.Casos_de_estudio.Ventas_diarias;

import java.util.*;

public class VentasTreeMap {
    private TreeMap<String, Producto> ventas;
    
    public VentasTreeMap() {
        ventas = new TreeMap<>();
    }
    
    // Registrar venta usando código como identificador
    public void registrarVenta(String codigo, String nombre, int cantidad, double valorTotal) {
        Producto producto = new Producto(codigo, nombre, cantidad, valorTotal);
        ventas.put(codigo, producto);
        System.out.println("Venta registrada con TreeMap: " + producto);
    }
    
    // Consultar información de un producto por código
    public Producto consultarProducto(String codigo) {
        return ventas.get(codigo);
    }
    
    // Mostrar total ventas registradas
    public void mostrarTotalVentas() {
        System.out.println("TOTAL VENTAS REGISTRADAS (TreeMap)");
        System.out.println("Total de ventas: " + ventas.size());
        double totalValor = 0;
        for (Producto p : ventas.values()) {
            totalValor += p.getValorTotalVenta();
        }
        System.out.println("Valor total de todas las ventas: $" + totalValor);
    }
    
    // Mostrar ventas ordenadas por código de producto
    // TreeMap automáticamente mantiene las claves ordenadas
    public void mostrarVentasOrdenadasPorCodigo() {
        System.out.println("VENTAS ORDENADAS POR CÓDIGO (TreeMap - Automático)");
        for (Producto producto : ventas.values()) {
            System.out.println(producto);
        }
    }
    
    // Mostrar ventas en el orden exacto en que se registraron
    // Nota: TreeMap ordena automáticamente por clave, no mantiene orden de inserción
    public void mostrarVentasOrdenRegistro() {
        System.out.println("VENTAS EN ORDEN DE REGISTRO (TreeMap - No disponible, muestra ordenado)");
        for (Producto producto : ventas.values()) {
            System.out.println(producto);
        }
    }
    
    public void mostrarTodasLasVentas() {
        System.out.println("TODAS LAS VENTAS (TreeMap)");
        for (Producto producto : ventas.values()) {
            System.out.println(producto);
        }
    }
    
    // Métodos adicionales específicos de TreeMap
    public void mostrarPrimerYUltimoProducto() {
        if (!ventas.isEmpty()) {
            System.out.println("Primer producto (por código): " + ventas.firstEntry().getValue());
            System.out.println("Último producto (por código): " + ventas.lastEntry().getValue());
        }
    }
}