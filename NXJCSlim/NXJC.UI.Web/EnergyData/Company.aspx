<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="NXJC.UI.Web.EnergyData.Company" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>银川水泥公司能耗</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <div style="position:absolute; top: 5px; left: 487px;"><asp:Label ID="Label1" runat="server" Text="银川水泥公司能耗" Font-Size="XX-Large" ></asp:Label></div>
        <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;width:344px; height:216px; top: 52px; left: 12px;">
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="YFC" runat="server" Text="一分厂能耗" Font-Size="X-Large" ></asp:Label>
            <br /><br />
            &nbsp;总功率<asp:Label ID="YFCZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label40" runat="server" Text="KWh"></asp:Label>
            &nbsp; 总电耗<asp:Label ID="YFCZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label62" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="YFCSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label76" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="YFCSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label83" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="YFCSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label87" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="YFCSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label91" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="YFCSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label93" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="YFCSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label95" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="YFCYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label97" runat="server" Text="MW"></asp:Label>     
       </div>
       <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;width:344px;height:216px; top: 52px; left: 465px;">
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="ND" runat="server" Text="宁东分厂能耗" Font-Size="X-Large" ></asp:Label>
            <br /><br />
            &nbsp;总功率<asp:Label ID="NDZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label3" runat="server" Text="KWh"></asp:Label>
            &nbsp; 总电耗<asp:Label ID="NDZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label5" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="NDSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label13" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="NDSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label15" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="NDSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label17" runat="server" Text="kgce/t"></asp:Label>
       </div>
       <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;width:344px;height:216px; top: 52px; left: 928px;">
            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="LS" runat="server" Text="兰山分厂能耗" Font-Size="X-Large" ></asp:Label>
            <br /><br />
            &nbsp;总功率<asp:Label ID="LSZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label2" runat="server" Text="KWh"></asp:Label>
            &nbsp; 总电耗<asp:Label ID="LSZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label4" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="LSSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label6" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="LSSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label7" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="LSSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label8" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="LSSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label9" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="LSSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label10" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="LSSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label11" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="LSYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label12" runat="server" Text="MW"></asp:Label>     
       </div>
    
    </div>
    </form>
</body>
</html>
