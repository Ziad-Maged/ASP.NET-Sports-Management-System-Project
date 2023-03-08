<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sport Association Manager.aspx.cs" Inherits="Milestone_3.Sport_Association_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 787px">
            Sports Association Manager:<br />
            <br />
            Add / Delete Match:<br />
            Host Club Name:<br />
            <asp:TextBox ID="hostclub" runat="server" maxlength="20"></asp:TextBox>
            <br />
            Guest Club Name:<br />
            <asp:TextBox ID="guestclub" runat="server" maxlength="20"></asp:TextBox>
            <br />
            Start Time:<br />
            <asp:TextBox ID="starttime" runat="server" maxlength="20"></asp:TextBox>
            <br />
            End Time:<br />
            <asp:TextBox ID="endtime" runat="server" maxlength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Button1_Click" />
&nbsp;&nbsp;&nbsp;
            <asp:Button ID="delete" runat="server" Text="Delete" OnClick="delete_Click" />
            <br />
            <br />
            <br />
            <div runat="server" id="test" class="someclass"></div>
            <div runat="server" id="Div1" class="someclass">
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="View All upcoming matches" />
            </div>
            <div runat="server" id="Div2" class="someclass"></div>
            <div runat="server" id="Div3" class="someclass">
            <asp:GridView ID="allMatchesView" runat="server">
            </asp:GridView>
            </div>
            <div runat="server" id="Div4" class="someclass">

                <br />

            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="View already played matches" />
            <div runat="server" id="Div8" class="someclass"></div>
            <div runat="server" id="Div5" class="someclass"></div>
            <div runat="server" id="Div6" class="someclass">
                <asp:GridView ID="AlreadyPlayedMatches" runat="server">
                </asp:GridView>
                </div>
            <div runat="server" id="Div7" class="someclass"></div>

            </div>
            
                <br />

            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="View pair of club names who never scheduled to play with each other" />
            
                <br />
            <div runat="server" id="Div9" class="someclass"></div>
            <div runat="server" id="Div10" class="someclass">
                <asp:GridView ID="ClubsNeverMatched" runat="server">
                </asp:GridView>
            </div>
                <br />

            </div>
            
        </div>
    </form>
</body>
</html>
