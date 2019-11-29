package com.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dataconnect
	{
		public static Connection conn;
		public static Connection connectDB()
			{
				try
					{
						Class.forName("com.mysql.jdbc.Driver");
					}
				catch(ClassNotFoundException e)
					{
						e.printStackTrace();
					}
				try
					{
						conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ebserp","root","Tiger2580");
					}
				catch(SQLException e)
					{
						e.printStackTrace();
					}
				return conn;
			}
}