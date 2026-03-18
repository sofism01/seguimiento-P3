package Collections.Casos_de_estudio.Turnos_en_banco;

public class Cliente {
    private String nombre;
    private String turno;
    
    public Cliente(String nombre, String turno) {
        this.nombre = nombre;
        this.turno = turno;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public String getTurno() {
        return turno;
    }
    
    @Override
    public String toString() {
        return "Turno " + turno + " - " + nombre;
    }
}
