<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationForm.aspx.cs" Inherits="WebApplication1.RegistrationForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>User Registration</title>
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
            position: relative;
            margin-top: 20px;
        }

        .btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label8" runat="server" Font-Size="XX-Large" Text="User Registration"></asp:Label>
            <br />
            <br />

            <asp:Label ID="Label1" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txt_email" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txt_pass" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Label ID="Label5" runat="server" Text="Confirm Password"></asp:Label>
            <asp:TextBox ID="txt_passConfirm" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label>
            <asp:TextBox ID="txt_name" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Label ID="Label4" runat="server" Text="Address"></asp:Label>
            <asp:TextBox ID="txt_address" runat="server"></asp:TextBox>
            <br />
            <br />

            <asp:Label ID="lbl_Status" runat="server"></asp:Label>

            <div class="btn-container">
                <asp:Button ID="btn_register" runat="server" OnClick="btn_register_Click" Text="Register" Font-Size="Medium" />
                <br />
                <br />

                <asp:Button ID="btn_cancel" runat="server" OnClick="btn_cancel_Click" Text="I Already Have An Account" Width="301px" Font-Size="Medium" />
            </div>
        </div>
    </form>
</body>
</html>
