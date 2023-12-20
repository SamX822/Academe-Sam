<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerForm.aspx.cs" Inherits="WebApplication1.CustomerForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Customer Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form1 {
            max-width: 1100px;
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

        #Label1, #Label2, #Label3, #Label4 {
            display: block;
            margin-top: 10px;
            text-align: left; /* Align labels to the left */
        }

        #txt_name, #txt_email, #txt_address, #txt_pass {
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
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label8" runat="server" Text="File Maintenance - Customer"></asp:Label>
            <br />
            <br />

            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="btnMenu" />
            <asp:Button ID="btn_toItemsForm" runat="server" OnClick="btn_toItemsForm_Click" Text="Go to ItemsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminsForm" runat="server" OnClick="btn_toAdminsForm_Click" Text="Go to AdminsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminOrders" runat="server" OnClick="btn_toAdminOrders_Click" Text="Go to AdminOrders" CssClass="btnMenu" />

            <br />
            <br />

            <asp:TextBox ID="txtSearch" runat="server" Width="203px"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn" />

        </div>
        <asp:GridView ID="GridView1" runat="server" CssClass="minimalist-table" AutoGenerateColumns="False" EmptyDataText="No Entries in Database" DataSourceID="MonteDB" DataKeyNames="C_id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="C_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="C_id" />
                <asp:BoundField DataField="C_name" HeaderText="Name" SortExpression="C_name" />
                <asp:BoundField DataField="C_email" HeaderText="Email" SortExpression="C_email" />
                <asp:BoundField DataField="C_address" HeaderText="Address" SortExpression="C_address" />
                <asp:BoundField DataField="C_pass" HeaderText="Password" SortExpression="C_pass" />
                <asp:CommandField ButtonType="Button" HeaderText="Edit" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" HeaderText="Delete" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="MonteDB" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" 
            SelectCommand="SELECT [C_id], [C_name], [C_email], [C_address], [C_pass] FROM [Customer] WHERE ([C_delete] = @C_delete)"
            UpdateCommand="UPDATE Customer SET C_name=@C_name, C_email=@C_email, C_address=@C_address, C_pass=@C_pass WHERE (C_id=@C_id)"
            DeleteCommand="UPDATE Customer SET C_delete=1 WHERE (C_id=@C_id)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="C_delete" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="GridView1" Name="C_id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView1" Name="C_id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <div class="btn-container">
            <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
            <asp:TextBox ID="txt_name" runat="server" />

            <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
            <asp:TextBox ID="txt_email" runat="server" />

            <asp:Label ID="Label3" runat="server" Text="Address"></asp:Label>
            <asp:TextBox ID="txt_address" runat="server" />

            <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txt_pass" runat="server" />
            <br />
            <br />
            <div class="edit-delete-buttons">
                <asp:Button ID="btn_insert" runat="server" OnClick="btn_insert_Click" Text="Submit" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
