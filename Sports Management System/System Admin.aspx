<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="System Admin.aspx.cs" Inherits="Milestone3.System_Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Add A Club:</div>
        Name:
        <asp:TextBox ID="ADDClubName" runat="server" maxlength="20"></asp:TextBox>
        <p>
            Location:
            <asp:TextBox ID="ADDClubLocation" runat="server" maxlength="20"></asp:TextBox>
        </p>
        <asp:Button ID="AddClub" runat="server" Text="Add Club" OnClick="AddClub_Click" />
        <p>
            Delete A Club:</p>
        Name:
        <asp:TextBox ID="DeleteClubName" runat="server" maxlength="20"></asp:TextBox>
        <p>
            <asp:Button ID="DeleteClub" runat="server" Text="Delete Club" OnClick="DeleteClub_Click" />
        </p>
        Add A Stadium:<p>
            Name:
            <asp:TextBox ID="AddStadiumName" runat="server" maxlength="20"></asp:TextBox>
        </p>
        Location:
        <asp:TextBox ID="AddStadiumLocation" runat="server" maxlength="20"></asp:TextBox>
        <p>
            Capacity:
            <asp:TextBox ID="AddStadiumCapacity" runat="server" maxlength="20"></asp:TextBox>
        </p>
        <asp:Button ID="AddStadium" runat="server" Text="Add Stadium" OnClick="AddStadium_Click" />
        <p>
            Delete Stadium:
        </p>
        Name:
        <asp:TextBox ID="DeleteStadiumName" runat="server" maxlength="20"></asp:TextBox>
        <p>
            <asp:Button ID="DeleteStadium" runat="server" Text="Delete Stadium" OnClick="DeleteStadium_Click" />
        </p>
        Block A Fan:
        <p>
            National ID Number:
            <asp:TextBox ID="BlockFanID" runat="server" maxlength="20"></asp:TextBox>
        </p>
        <asp:Button ID="BlockFan" runat="server" Text="Block Fan" OnClick="BlockFan_Click" />
        &nbsp;&nbsp;
        <asp:Button ID="UnblockFam" runat="server" Text="Unblock Fan" OnClick="UnblockFam_Click" />
    </form>
</body>
</html>
