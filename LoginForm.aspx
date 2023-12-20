<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="WebApplication1.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form1 {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #lbl_Status {
            color: #ff0000;
            margin-bottom: 10px;
        }

        .btn-container {
            text-align: center;
            position: relative; /* Change to relative */
            margin-top: 20px; /* Adjust this value to control the space between the form content and buttons */
        }

        .btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px; /* Adjust this value to control the space between buttons */
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Label ID="Label8" runat="server" Font-Size="XX-Large" Text="LOGIN"></asp:Label>
        <br />
        <br />

        <asp:Label ID="Label1" runat="server" Text="Email"></asp:Label>

        <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>

        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>

        <asp:TextBox ID="txt_pass" TextMode="Password" runat="server"></asp:TextBox>
   
        <asp:Label ID="Label9" runat="server" Text="Code" Visible="False"></asp:Label>

        <asp:TextBox ID="txt_secure" runat="server" TextMode="Password" Visible="False"></asp:TextBox>
        <br />
        <br />
<asp:Label ID="lbl_Status" runat="server"></asp:Label>
        
        <div class="btn-container">
        <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Login" Font-Size="Medium" style="height: 28px" />
        <br />
        <br />
        <br />

        <asp:Button ID="btn_create" runat="server" OnClick="btn_create_Click" Text="Create New Account" Width="237px" Font-Size="Medium" />
        </div>
    </div>
    </form>
</body>
</html>
