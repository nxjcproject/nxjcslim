using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class WorkingSectionService
    {
        /// <summary>
        /// 按生产线ID获取工段
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetWorkingTeamByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("WorkingSection");
            query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }
    }
}
