using SqlServerDataAdapter;
using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public static class ConnectionStringFactory
    {
        public static string GetByProductLineId(int productLineId)
        {
            string catalog = GetCataLogByProductLineId(productLineId);
            string connectionString =
                string.Format(ConfigurationManager.ConnectionStrings["ProcessData"].ConnectionString, catalog);
            return connectionString;
        }

        public static string GetNXJCConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;
        }

        private static string GetCataLogByProductLineId(int productLineId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("ProductLineId", productLineId, CriteriaOperator.Equal);
            DataTable dt = factory.Query(query);

            if (dt.Rows.Count > 0)
                return dt.Rows[0]["DataBaseName"].ToString().Trim();
            else
                throw new ApplicationException("没有此生产线");
        }
    }
}
