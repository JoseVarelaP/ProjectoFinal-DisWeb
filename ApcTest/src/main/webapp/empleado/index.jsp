<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*, java.util.ArrayList" %>
<%@ page import="DAO.*, java.sql.*" %>

<!DOCTYPE html>
<html>
	<link href="../css/estilo.css" rel="stylesheet"/>
	<head>
		<meta charset="utf-8">
		<title>Servicio de Autobuses</title>
	</head>
	<% ArrayList<Conductor> conductores = new ArrayList<>(); %>
	<body>
		<div class="header">
			<img src="../img/autobus.png">
			<p>Servicio de Autobuses</p>
		</div>
		<ul>
			<%--Haz el listado de las opciones para agregar o manipular.--%>
			<div>
				<h2 class="Titulo">Listado de conductores</h2>
			</div>
			<%
				Conexion conexion = new Conexion( "joseluis" );
				DAO administrador = new DAO( conexion.getConnection() );
				
				int res = administrador.ConteoConsulta( "conductor" );
				
				/*
					Probablemente tengamos algun conductor por eliminar,
					asi que buscaremos por medio de la URL de la pagina para realizar
					la acción.
				*/
				int primerValor = administrador.PrimerValorConsulta( "num_conductor" ,"conductor" );
				for( int ids : administrador.Identificadores( "num_conductor", "conductor" ) )
				{
					Conductor c = new Conductor( conexion.getConnection() );
					if( c.ObtenerInfo( ids ) )
						conductores.add( c );
				}
			%>

			<%--Hora de agregar los nombres y colocarlos en sus grupos.--%>
			<center>
				<a href="./crear.jsp">Crear Entrada</a>
				<table>
					<tr>
						<th>Nombre de Conductor</th>
						<th>Edad</th>
						<th>Fecha Contratado</th>
						<th>Dirección</th>
						<th>Editar</th>
						<th>Eliminar</th>
					</tr>
					<% for( Conductor c : conductores ) { %>
					<tr>
						<th><% out.print( c.ObtenerNombreCompleto() ); %></th>
						<th><% out.print( c.Edad() ); %></th>
						<th><% out.print( c.FechaContrato() ); %></th>
						<th><% out.print( c.Direccion() ); %></th>
						<th>
							<% int num = c.ObtenerID(); %>
							<% String ubicacion = String.format("./editar.jsp?CID=%s", num); %>
							<a href= <%= ubicacion %> >Editar</a>
						</th>
						<th>
							<% ubicacion = String.format("./eliminar.jsp?CID=%s", num); %>
							<a href= <%= ubicacion %> >Eliminar</a>
						</th>
					</tr>
					<% } %>
				</table>
			</center>
		</ul>
	</body>
</html>