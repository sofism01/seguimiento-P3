package Collections.Casos_de_estudio.Ventas_diarias;

public class SistemaVentas {
    
    public static void main(String[] args) {        
        // Crear instancias de las tres implementaciones
        VentasHashMap ventasHashMap = new VentasHashMap();
        VentasLinkedHashMap ventasLinkedHashMap = new VentasLinkedHashMap();
        VentasTreeMap ventasTreeMap = new VentasTreeMap();
        
        // Datos de prueba
        System.out.println("SISTEMA DE VENTAS DIARIAS");
        System.out.println();
                
        // Registrar ventas de prueba
        ventasHashMap.registrarVenta("P1", "Papa criolla", 10, 150.0);
        ventasHashMap.registrarVenta("P2", "Aceite", 5, 200.0);
        ventasHashMap.registrarVenta("P3", "Nuggets de pollo", 8, 300.0);
        
        ventasLinkedHashMap.registrarVenta("P1", "Papa criolla", 10, 150.0);
        ventasLinkedHashMap.registrarVenta("P2", "Aceite", 5, 200.0);
        ventasLinkedHashMap.registrarVenta("P3", "Nuggets de pollo", 8, 300.0);
        
        ventasTreeMap.registrarVenta("P1", "Papa criolla", 10, 150.0);
        ventasTreeMap.registrarVenta("P2", "Aceite", 5, 200.0);
        ventasTreeMap.registrarVenta("P3", "Nuggets de pollo", 8, 300.0);
        
        System.out.println("\n--- HashMap ---");
        ventasHashMap.mostrarVentasOrdenRegistro();
        
        System.out.println("\n--- LinkedHashMap ---");
        ventasLinkedHashMap.mostrarVentasOrdenRegistro();
        
        System.out.println("\n--- TreeMap ---");
        ventasTreeMap.mostrarVentasOrdenRegistro();
    }
}