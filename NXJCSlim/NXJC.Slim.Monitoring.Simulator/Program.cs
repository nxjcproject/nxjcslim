using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Monitoring.Simulator
{
    class Program
    {
        private static readonly string CONNECTION_STRING = "Data Source=DEC-WINSVR12;Initial Catalog=Db_01_WastedHeatPower;Integrated Security=True";
        private static readonly Random random = new Random();

        static void Main(string[] args)
        {

            Console.WriteLine("宁夏建材实时监控数据仿真, Ctrl + C 退出");

            IList<string> tablesToSimulate = new List<string>();

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT DISTINCT TableName FROM ContrastTable";

                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        tablesToSimulate.Add(reader[0].ToString().Trim());
                    }
                }

                while (true)
                {
                    foreach (var table in tablesToSimulate)
                    {
                        DataSet ds = GetStructure(table);
                        command.CommandText = GetUpdateCommand(ds, table);
                        command.ExecuteNonQuery();
                    }

                    System.Threading.Thread.Sleep(500);
                    Console.Write(".");
                }
            }
        }

        private static DataSet GetStructure(string table)
        {
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM " + table;

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(ds);
                }
            }

            return ds;
        }

        private static string GetUpdateCommand(DataSet ds, string tableName)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("UPDATE ");
            sb.Append(tableName);
            sb.Append(" SET ");

            foreach (DataColumn column in ds.Tables[0].Columns)
            {
                sb.Append("[").Append(column.ColumnName).Append("]");
                sb.Append(" = ");
                sb.Append(GetRandomValue(column));
                sb.Append(", ");
            }

            sb.Remove(sb.Length - 2, 2);

            return sb.ToString();
        }

        private static string GetRandomValue(DataColumn column)
        {
            if (column.DataType == typeof(DateTime))
            {
                return "'" + DateTime.Now.ToString() + "'";
            }
            if (column.DataType == typeof(Single))
            {
                return Convert.ToSingle(random.NextDouble() * random.Next(500)).ToString("#0.00");
            }
            if (column.DataType == typeof(bool))
            {
                return random.Next(1).ToString();
            }

            return "";
        }
    }
}
