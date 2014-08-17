using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public class TreeGridJsonParser
    {
        public static string DataTableToJson(DataTable table, string groupBy, params string[] columnsToParse)
        {
            if (table == null || table.Rows.Count == 0)
                return "[]";

            StringBuilder sb = new StringBuilder();
            sb.Append("[");

            DataTable rootTable = table.DefaultView.ToTable(true, groupBy);

            foreach (DataRow rootRow in rootTable.Rows)
            {
                sb.Append("{");
                sb.Append("\"guid\":\"").Append(Guid.NewGuid()).Append("\",");
                sb.Append("\"").Append(columnsToParse[0]).Append("\":").Append("\"").Append(rootRow[0].ToString().Trim()).Append("\",");
                sb.Append("\"state\":\"closed\",");
                sb.Append("\"children\":[");
                
                string filter = string.Format("{0}='{1}'", groupBy, rootRow[0].ToString());
                DataRow[] children = table.Select(filter);

                if (children.Length > 0)
                {
                    foreach (DataRow child in children)
                    {
                        sb.Append("{");
                        sb.Append("\"guid\":\"").Append(Guid.NewGuid()).Append("\",");
                        foreach (string column in columnsToParse)
                        {
                            sb.Append("\"").Append(column).Append("\":").Append("\"").Append(child[column].ToString().Trim()).Append("\",");
                        }
                        sb.Remove(sb.Length - 1, 1);

                        sb.Append("},");
                    }
                    sb.Remove(sb.Length - 1, 1);
                }

                sb.Append("]");
                sb.Append("},");
            }
            sb.Remove(sb.Length - 1, 1).Append("]");

            return sb.ToString();
        }
    }
}
