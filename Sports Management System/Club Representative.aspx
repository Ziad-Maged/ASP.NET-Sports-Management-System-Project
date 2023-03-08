<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Club Representative.aspx.cs" Inherits="Milestone_3.Club_Representative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body>
    <div></div>
    

    <div>Check Available Stadiums:
    <hr>
    <form id="Stadiums" runat="server">
        <b>Input a date in "YYYY-MM-DD" format</b>
        <asp:TextBox ID="stadium_date" runat="server">YYYY-MM-DD</asp:TextBox>
        <asp:Button ID="ViewStadiums" runat="server" Text="View" OnClick="ViewStadiums_Click" /> &nbsp;
    <hr>
    <br>
    </div>
        <div>
        <b>Request Host</b><br>
        <asp:TextBox ID="Club_name" maxlength="20" runat="server">Club Name</asp:TextBox> <br>
        <asp:TextBox ID="Stadium_name" maxlength="20" runat="server">Stadium Name</asp:TextBox> <br>
        <asp:TextBox ID="Datetime" maxlength="20" runat="server">YYYY-MM-DD HH:MI:SS</asp:TextBox> <br>
        <asp:Button ID="Button1"  runat="server" Text="Send Host Request" OnClick="SendHostRequest" />
            </div>
        </form>


      </body>
</html>
