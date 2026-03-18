package Collections.Casos_de_estudio.Turnos_en_banco;

import java.util.LinkedList;
import java.util.Queue;

public class SistemaTurnos {
    private Queue<Cliente> colaClientes;
    private int numeroTurno;
    
    public SistemaTurnos() {
        colaClientes = new LinkedList<>();
        numeroTurno = 1;
    }
    
    // Registrar un nuevo cliente en la fila
    public void registrarCliente(String nombre) {
        String turno = String.format("A%03d", numeroTurno);
        Cliente cliente = new Cliente(nombre, turno);
        colaClientes.offer(cliente);
        System.out.println("Cliente registrado: " + cliente);
        numeroTurno++;
    }
    
    // Atender al siguiente cliente (remover de la cola)
    public Cliente atenderSiguienteCliente() {
        if (filaVacia()) {
            System.out.println("Error: No hay clientes en espera para atender");
            return null;
        }
        Cliente clienteAtendido = colaClientes.poll();
        System.out.println("Atendiendo a: " + clienteAtendido);
        return clienteAtendido;
    }
    
    // Mostrar el próximo cliente sin removerlo
    public Cliente proximoCliente() {
        if (filaVacia()) {
            System.out.println("No hay clientes en espera");
            return null;
        }
        Cliente proximo = colaClientes.peek();
        System.out.println("Próximo cliente: " + proximo);
        return proximo;
    }
    
    // Mostrar cuántos clientes hay en espera
    public int clientesEnEspera() {
        int cantidad = colaClientes.size();
        System.out.println("Clientes en espera: " + cantidad);
        return cantidad;
    }
    
    // Verificar si la fila está vacía
    public boolean filaVacia() {
        boolean vacia = colaClientes.isEmpty();
        if (vacia) {
            System.out.println("La fila está vacía");
        }
        return vacia;
    }
    
    // Método adicional para mostrar todos los clientes en la fila
    public void mostrarFila() {
        if (filaVacia()) {
            return;
        }
        System.out.println("Clientes en la fila:");
        for (Cliente cliente : colaClientes) {
            System.out.println("  " + cliente);
        }
    }
}