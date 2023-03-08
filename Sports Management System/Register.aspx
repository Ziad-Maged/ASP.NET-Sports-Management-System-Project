<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Milestone_3.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <div>
            <asp:Label ID="Label1" runat="server" Text="Register Page"></asp:Label>
            <br />
        </div>
            <br />
            Club Representitve:<br />
        <div>
            Name:<br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
        </div>
            <asp:Label ID="Label2" runat="server" Text="Username:"></asp:Label>
            <br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label>
            <br />
            <asp:TextBox ID="password" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Club Name:<br />
            <asp:TextBox ID="Clubname" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            <br />
            Stadium Manger:<br />
        <div>
            Name:<br />
            <asp:TextBox ID="name0" runat="server"></asp:TextBox>
        </div>
            <asp:Label ID="Label4" runat="server" Text="Username:"></asp:Label>
            <br />
            <asp:TextBox ID="username0" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Password:"></asp:Label>
            <br />
            <asp:TextBox ID="password0" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Stadium Name:<br />
            <asp:TextBox ID="Stadiumname" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            <br />
            Fan:<br />
        <div>
            Name:<br />
            <asp:TextBox ID="name1" runat="server"></asp:TextBox>
        </div>
            <asp:Label ID="Label6" runat="server" Text="Username:"></asp:Label>
            <br />
            <asp:TextBox ID="username1" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label7" runat="server" Text="Password:"></asp:Label>
            <br />
            <asp:TextBox ID="password1" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            National ID Number:<br />
            <asp:TextBox ID="nationalidnumber" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Date of Birth:<br />
            <asp:TextBox ID="dateofbirth" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Adress:<br />
            <asp:TextBox ID="Adress" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            Phone Number:<br />
            <asp:TextBox ID="Phonenumber" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            <br />
            Sport Association Manager:<br />
            <br />
        <div>
            Name:<br />
            <asp:TextBox ID="name2" runat="server"></asp:TextBox>
        </div>
            <asp:Label ID="Label8" runat="server" Text="Username:"></asp:Label>
            <br />
            <asp:TextBox ID="username2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="Label9" runat="server" Text="Password:"></asp:Label>
            <br />
            <asp:TextBox ID="password2" runat="server" OnTextChanged="password_TextChanged"></asp:TextBox>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <asp:Button ID="register1" runat="server" Text="Register" OnClick="register1_Click" />
            <br />
            <br />
            <asp:Button ID="login" runat="server" Text="Login" OnClick="login_Click" />
            <br />
        </div>
    </form>
  
</body>
</html>
