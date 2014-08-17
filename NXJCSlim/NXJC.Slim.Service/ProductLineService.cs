using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class ProductLineService
    {
        public static DataTable GetProductLines()
        {
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(ConnectionStringFactory.GetByProductLineId(1)))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM ContrastTable";

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(ds);
                }
            }

            return ds.Tables[0];
        }
    }
}
