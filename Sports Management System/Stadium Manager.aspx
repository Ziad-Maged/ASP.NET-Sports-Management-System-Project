<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Stadium Manager.aspx.cs" Inherits="Milestone3.Stadium_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Managed Stadium:<br />
            <asp:GridView ID="StadiumManagerStadium" runat="server">
            </asp:GridView>
        </div>
        <br />
        All Requests:<br />
        <asp:GridView ID="allRequestsForManager" runat="server">
        </asp:GridView>
        Accept/Reject Requests:<p>
            Host Club Name:
            <asp:TextBox ID="HostClubName" runat="server" maxlength="20"></asp:TextBox>
        </p>
        Guest Club Name:
        <asp:TextBox ID="GuestClubName" runat="server" maxlength="20"></asp:TextBox>
        <p>
            Match Start Time:
            <asp:TextBox ID="MatchStartTime" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Accept" runat="server" Text="Accept Request" OnClick="Accept_Click" />
        &nbsp; &nbsp;
        <asp:Button ID="Reject" runat="server" Text="Reject Request" OnClick="Reject_Click" />
    </form>
</body>
</html>
