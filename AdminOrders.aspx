<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="WebApplication1.AdminOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form1 {
            max-width: 1000px;
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

        #txt_index {
            width: 36px;
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

        #GridView1,
        #GridView2 {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        #GridView1 th,
        #GridView1 td,
        #GridView2 th,
        #GridView2 td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #GridView2 {
            margin-top: 10px;
        }

        .edit-delete-buttons {
            text-align: right;
            margin-top: 10px;
        }

        .edit-delete-buttons .btn {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label8" runat="server" Text="Maintenance - Orders"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminsForm" runat="server" OnClick="btn_toAdminsForm_Click" Text="Go to AdminsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toItemsForm" runat="server" OnClick="btn_toItemsForm_Click" Text="Go to ItemsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toCustForm" runat="server" OnClick="btn_toCustForm_Click" Text="Go to CustomerForm" CssClass="btnMenu" />
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Current Customer ID: "></asp:Label>
            <asp:TextBox ID="txt_index" runat="server" />
            <asp:Button ID="btn_ok" runat="server" OnClick="btn_ok_Click" Text="OK" CssClass="btn" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField HeaderText="Select" ShowSelectButton="True" />
                    <asp:BoundField DataField="O_date" HeaderText="Date" SortExpression="O_date" />
                    <asp:BoundField DataField="O_shipAddress" HeaderText="Shipping Address" SortExpression="O_shipAddress" />
                    <asp:BoundField DataField="cart_totalAmt" HeaderText="Total Price" SortExpression="cart_totalAmt" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" 
                SelectCommand="SELECT DISTINCT o.O_date, o.O_shipAddress, sc.cart_totalAmt 
                FROM Customer c
                INNER JOIN ShoppingCart sc ON sc.C_id = c.C_id 
                INNER JOIN Orders o ON c.C_id = o.C_id
                WHERE c.C_id = @index">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txt_index" Name="index" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
            </asp:GridView>
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
