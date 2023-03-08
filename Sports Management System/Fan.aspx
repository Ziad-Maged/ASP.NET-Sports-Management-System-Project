<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="Milestone3.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            View All Upcoming Matches:</div>
        <asp:GridView ID="Matches" runat="server">
        </asp:GridView>
        Enter DateTime:
        <asp:TextBox ID="Date_Time" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="View_Upcoming_Matches" runat="server" Text="View Upcoming Matches" OnClick="View_Upcoming_Matches_Click" />
        </p>
        Purchase Ticket For Match:<p>
            Enter Host Club Name:
            <asp:TextBox ID="HostClubName" runat="server" maxlength="20"></asp:TextBox>
        </p>
        Enter Guest Club Name:
        <asp:TextBox ID="GuestClubName" runat="server" maxlength="20"></asp:TextBox>
        <p>
            Enter Match Start Time:
            <asp:TextBox ID="MatchStartTime" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Purchase" runat="server" Text="Purchase Ticket" OnClick="Purchase_Click" />
    </form>
</body>
</html>
