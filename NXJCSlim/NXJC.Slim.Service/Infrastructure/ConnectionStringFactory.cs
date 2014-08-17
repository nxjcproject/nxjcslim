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
        /// <summary>
        /// 以生产线ID为键的过程数据库名字典
        /// </summary>
        public static readonly Dictionary<int, string> ProcessCatalogDictionary = new Dictionary<int, string>();

        static ConnectionStringFactory()
        {
            InitializeProcessCatalogDictionary();
        }

        /// <summary>
        /// 重置过程数据库名字典
        /// </summary>
        public static void ResetProcessCatalogDictionary()
        {
            InitializeProcessCatalogDictionary();
        }

        /// <summary>
        /// 按生产线ID获取数据库连接字符串
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static string GetByProductLineId(int productLineId)
        {
            string catalog = GetCatalogByProductLineId(productLineId);
            string connectionString =
                string.Format(ConfigurationManager.ConnectionStrings["ProcessData"].ConnectionString, catalog);
            return connectionString;
        }

        /// <summary>
        /// 获取管理数据库连接字符串
        /// </summary>
        /// <returns></returns>
        public static string GetNXJCConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;
        }

        /// <summary>
        /// 按生产线ID获取数据库名（优先从缓存中查找）
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        private static string GetCatalogByProductLineId(int productLineId)
        {
            if (ProcessCatalogDictionary.ContainsKey(productLineId))
                return ProcessCatalogDictionary[productLineId];

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("ProductLineId", productLineId, CriteriaOperator.Equal);
            DataTable dt = factory.Query(query);

            if (dt.Rows.Count == 0)
                throw new ApplicationException("没有此生产线");

            ProcessCatalogDictionary.Add(productLineId, dt.Rows[0]["DataBaseName"].ToString().Trim());
            return ProcessCatalogDictionary[productLineId];             
        }

        /// <summary>
        /// 初始化过程数据库名字典
        /// </summary>
        private static void InitializeProcessCatalogDictionary()
        {
            ProcessCatalogDictionary.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            DataTable dt = factory.Query(query);

            if (dt.Rows.Count == 0)
                throw new ApplicationException("没有此生产线");

            foreach(DataRow row in dt.Rows)
                ProcessCatalogDictionary.Add(int.Parse(row["ProductLineId"].ToString()), row["DataBaseName"].ToString().Trim());
        }
    }
}
