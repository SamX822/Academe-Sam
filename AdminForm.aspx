<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminForm.aspx.cs" Inherits="WebApplication1.AdminForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form2 {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #Label8 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .btn-container {
            text-align: right;
            margin-top: 20px;
        }

        .btnMenu {
            background-color: #6fa4d9;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        #txtSearch {
            width: 150px;
            margin-right: 10px;
        }

        #GridView1 {
            width: 100%;
            margin-top: 20px;
        }

        #GridView1 th, #GridView1 td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .edit-delete-buttons {
            text-align: right;
        }

        .edit-delete-buttons .btn {
            margin-left: 10px;
        }

        #Label1, #Label2, #Label4 {
            display: block;
            margin-top: 10px;
            text-align: left; /* Align labels to the left */
        }

        #txt_userID, #txt_pass, #txt_secure {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div>
            <asp:Label ID="Label8" runat="server" Text="File Maintenance - Admin"></asp:Label>
            <br />
            <br />

            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="btnMenu" />
            <asp:Button ID="btn_toItemsForm" runat="server" OnClick="btn_toItemsForm_Click" Text="Go to ItemsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toCustForm" runat="server" OnClick="btn_toCustForm_Click" Text="Go to CustomerForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminOrders" runat="server" OnClick="btn_toAdminOrders_Click" Text="Go to AdminOrders" CssClass="btnMenu" />

            <br />
            <br />

            <asp:TextBox ID="txtSearch" runat="server" Width="203px"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn" />

        </div>
        <asp:GridView ID="GridView1" runat="server" CssClass="minimalist-table" AutoGenerateColumns="False" EmptyDataText="No Entries in Database" DataSourceID="MonteDB" DataKeyNames="a_secure">
            <Columns>
                <asp:BoundField DataField="a_userID" HeaderText="User ID" SortExpression="a_userID" />
                <asp:BoundField DataField="a_pass" HeaderText="Password" SortExpression="a_pass" />
                <asp:BoundField DataField="a_secure" HeaderText="Security Code" SortExpression="a_secure" ReadOnly="True" />
                <asp:CommandField ButtonType="Button" HeaderText="Edit" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="MonteDB" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Admin] WHERE a_secure != @master"
            UpdateCommand="UPDATE [Admin] SET a_pass=@a_pass, a_userID = @a_userID WHERE a_secure=@a_secure"
            DeleteCommand="DELETE FROM [Admin] WHERE a_secure=@a_secure">
            <SelectParameters>
                <asp:Parameter DefaultValue="AlphaOmega" Name="master" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="btn-container">
            <asp:Label ID="Label1" runat="server" Text="User ID"></asp:Label>
            <asp:TextBox ID="txt_userID" runat="server" />

            <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txt_pass" runat="server" />

            <asp:Label ID="Label2" runat="server" Text="Security Code"></asp:Label>
            <asp:TextBox ID="txt_secure" runat="server" />
            <br />
            <br />
            <div class="edit-delete-buttons">
                <asp:Button ID="btn_insert" runat="server" OnClick="btn_insert_Click" Text="Submit" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
