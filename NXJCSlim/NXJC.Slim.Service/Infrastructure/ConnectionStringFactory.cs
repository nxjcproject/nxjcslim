using System;
using System.Collections.Generic;
using System.Configuration;
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

        private static string GetCataLogByProductLineId(int productLineId)
        {
            return "Db_01_WastedHeatPower";
        }
    }
}
