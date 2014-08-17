using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
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
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("ProductLine");

            return factory.Query(query);
        }

        public static DataTable GetLabelsByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetByProductLineId(productLineId);

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("ContrastTable");

            return factory.Query(query);
        }

        public static DataTable test()
        {
            string connectionString = "Data Source=DEC-WINSVR12;Initial Catalog=Temp;Integrated Security=SSPI;";
            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("temp");
            return factory.Query(query);
        }
    }
}
