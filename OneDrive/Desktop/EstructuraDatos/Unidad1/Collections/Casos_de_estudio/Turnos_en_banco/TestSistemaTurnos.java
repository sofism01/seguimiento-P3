package Collections.Casos_de_estudio.Turnos_en_banco;

public class TestSistemaTurnos {
    
    public static void main(String[] args) {
        
        SistemaTurnos sistema = new SistemaTurnos();
        
        System.out.println("=== SISTEMA DE TURNOS BANCARIOS ===\n");
        
        // Verificar si la fila está vacía inicialmente
        System.out.println("1. Verificando fila vacía:");
        sistema.filaVacia();
        sistema.clientesEnEspera();
        
        System.out.println("\n2. Intentar atender cliente con fila vacía:");
        sistema.atenderSiguienteCliente();
        
        System.out.println("\n3. Registrar nuevos clientes:");
        sistema.registrarCliente("Juan Pérez");
        sistema.registrarCliente("María García");
        sistema.registrarCliente("Carlos López");
        sistema.registrarCliente("Ana Rodríguez");
        
        System.out.println("\n4. Estado actual de la fila:");
        sistema.mostrarFila();
        sistema.clientesEnEspera();
        
        System.out.println("\n5. Ver próximo cliente sin atenderlo:");
        sistema.proximoCliente();
        
        System.out.println("\n6. Atender algunos clientes:");
        sistema.atenderSiguienteCliente();
        sistema.atenderSiguienteCliente();
        
        System.out.println("\n7. Estado después de atender 2 clientes:");
        sistema.mostrarFila();
        sistema.clientesEnEspera();
        
        System.out.println("\n8. Ver próximo cliente:");
        sistema.proximoCliente();
        
        System.out.println("\n9. Registrar un cliente más:");
        sistema.registrarCliente("Pedro Martín");
        
        System.out.println("\n10. Estado final:");
        sistema.mostrarFila();
        sistema.clientesEnEspera();
        
        System.out.println("\n11. Atender todos los clientes restantes:");
        while (!sistema.filaVacia()) {
            sistema.atenderSiguienteCliente();
        }
        
        System.out.println("\n12. Verificar fila vacía al final:");
        sistema.clientesEnEspera();
        sistema.proximoCliente();
    }
}