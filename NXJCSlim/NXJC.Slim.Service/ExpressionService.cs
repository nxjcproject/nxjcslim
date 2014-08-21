using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class ExpressionService
    {
        public static string[] ValidateExpression(string expression)
        {
            List<string> result = new List<string>();
            foreach (var exception in ExpressionHelper.Utility.ValidateExpression(expression))
            {
                result.Add(exception.Message);
            }

            return result.ToArray();
        }
    }
}
