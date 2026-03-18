package Collections.Casos_de_estudio.Ventas_masivas;

public class TestPlataforma {

    public static void main(String[] args) {

        int[] tamaños = {100, 1000, 10000, 100000};

        for (int tamaño : tamaños) {

            PlataformaVentas plataforma = new PlataformaVentas();

            long inicioMemoria = memoriaUsada();
            long inicioTiempo = System.nanoTime();

            // Insertar productos
            for (int i = 0; i < tamaño; i++) {
                Producto p = new Producto(
                        "COD" + i,
                        "Producto" + i,
                        Math.random() * 1000,
                        "Categoria" + (i % 10)
                );
                plataforma.insertarProducto(p);
            }

            // Buscar producto
            plataforma.buscarPorCodigo("COD" + (tamaño / 2));

            // Filtrar categoría
            plataforma.filtrarPorCategoria("Categoria5");

            // Ordenar
            plataforma.ordenarPorPrecio();

            long finTiempo = System.nanoTime();
            long finMemoria = memoriaUsada();

            System.out.println("Tamaño: " + tamaño);
            System.out.println("Tiempo ejecución: " + (finTiempo - inicioTiempo) / 1_000_000 + " ms");
            System.out.println("Memoria usada: " + (finMemoria - inicioMemoria) / 1024 + " KB");
            System.out.println("-----------------------------");
        }
    }

    private static long memoriaUsada() {
        Runtime runtime = Runtime.getRuntime();
        runtime.gc(); 
        return runtime.totalMemory() - runtime.freeMemory();
    }
}
