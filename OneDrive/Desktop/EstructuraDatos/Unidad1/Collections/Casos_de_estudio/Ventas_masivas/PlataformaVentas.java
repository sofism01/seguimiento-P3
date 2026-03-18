package Collections.Casos_de_estudio.Ventas_masivas;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

public class PlataformaVentas {

    private HashMap<String, Producto> mapaPorCodigo = new HashMap<>();
    private LinkedList<Producto> listaProductos = new LinkedList<>();
    private HashMap<String, List<Producto>> mapaPorCategoria = new HashMap<>();

    public void insertarProducto(Producto p) {
        listaProductos.addFirst(p); 
        mapaPorCodigo.put(p.codigo, p);

        mapaPorCategoria
            .computeIfAbsent(p.categoria, k -> new ArrayList<>())
            .add(p);
    }

     public Producto buscarPorCodigo(String codigo) {
        return mapaPorCodigo.get(codigo); // O(1)
    }

    public List<Producto> filtrarPorCategoria(String categoria) {
        return mapaPorCategoria.getOrDefault(categoria, new ArrayList<>());
    }

    public List<Producto> ordenarPorPrecio() {
        List<Producto> copia = new ArrayList<>(listaProductos);
        copia.sort(Comparator.comparingDouble(p -> p.precio));
        return copia;
    }
}
