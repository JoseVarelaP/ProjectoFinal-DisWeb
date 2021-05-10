/**
 *
 * @author joseluis
 */
import java.sql.*;
import java.util.Scanner;
import java.util.StringTokenizer;

public class MainBDj{
	public static void main (String []args){
		Scanner sc = new Scanner(System.in);

		System.out.println("Ingresa el nombre de la base de datos a buscar: ");
		Conexion conexion = new Conexion( sc.nextLine() );

		// Cierra el escaneador para evitar un leak.
		sc.close();

		ResultSet result;
		String appaterno,nombre,apmaterno;
		
		System.out.println("buscando");
		DAO administrador = new DAO( conexion.getConnection() );
		result = administrador.Consulta("SELECT * FROM alumnos");

		if( result == null )
		{
			return;
		}

		// Tenemos exito, hora de mostrar el menú.

		try{
			while(result.next()){
				// nss = result.getString("nss");
				nombre = result.getString("nombre");
				appaterno = result.getString("appaterno");
				apmaterno = result.getString("apmaterno");
				if( apmaterno == null )
				{
					apmaterno = "";
				}
				System.out.print("Nombre alumno: ");
				System.out.print( nombre + " " + appaterno + " " + apmaterno );
				// Comienza a dividir lo que contenga el nombre, y manda el resultado.
				/*
				StringTokenizer st = new StringTokenizer( nombre ," ");
				while (st.hasMoreTokens()) {
					System.out.print(st.nextToken());
				}
				*/
				System.out.print("\n");
			}
		}
		catch (SQLException e){
			e.printStackTrace();
		}
	}
}
