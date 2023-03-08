<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Milestone_3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #TextArea1 {
            height: 18px;
            width: 193px;
        }
        #form1 {
            height: 290px;
            width: 1190px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Username:"></asp:Label>
        </div>
         <div>   
            <asp:TextBox ID="username" runat="server" OnTextChanged="username_TextChanged" maxlength="20"></asp:TextBox>
             <br />
             <br />
            </div>
       
        <div>
            <asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
        </div>
         <div>   
            <asp:TextBox ID="password" runat="server" OnTextChanged="password_TextChanged" maxlength="20"></asp:TextBox>
             <br />
             <br />
            </div>
        
        <div>
            <asp:Button ID="login1" runat="server" Text="Login" OnClick="login" style="height: 29px" />
            <br />
            </div>
        <p>
            <asp:Button ID="Register1" runat="server" Text="Register" OnClick="Register1_Click" />
            </p>
    </form>
</body>
</html>