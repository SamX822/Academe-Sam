<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemsForm.aspx.cs" Inherits="WebApplication1.ItemsForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Items Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form1 {
            max-width: 1250px;
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

        #GridView2 {
            width: 100%;
            margin-top: 20px;
        }

        #GridView2 th, #GridView2 td {
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

        #Label1, #Label2, #Label3, #Label4, #Label5, #Label6, #Label9 {
            display: block;
            margin-top: 10px;
            text-align: left; /* Align labels to the left */
        }

        #txt_isbn, #txt_title, #txt_author, #txt_genre, #txt_price, #txt_type, #txt_qty {
            width: 100%;
            padding: 1px;
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
            <asp:Label ID="Label8" runat="server" Text="File Maintenance - Items"></asp:Label>
            <br />
            <br />

            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="btnMenu" />
            <asp:Button ID="btn_toCustForm" runat="server" OnClick="btn_toCustForm_Click" Text="Go to CustomerForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminsForm" runat="server" OnClick="btn_toAdminsForm_Click" Text="Go to AdminsForm" CssClass="btnMenu" />
            <asp:Button ID="btn_toAdminForms" runat="server" OnClick="btn_toAdminForms_Click" Text="Go to AdminOrders" CssClass="btnMenu" />

            <br />
            <br />

            <asp:TextBox ID="txtSearch" runat="server" Width="203px"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn" />

        </div>
        <asp:GridView ID="GridView2" runat="server" CssClass="minimalist-table" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="i_id">
            <Columns>
                <asp:BoundField DataField="i_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="i_id" />
                <asp:BoundField DataField="isbn" HeaderText="ISBN" SortExpression="isbn" />
                <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" />
                <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
                <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
                <asp:BoundField DataField="i_type" HeaderText="Type" SortExpression="i_type" />
                <asp:BoundField DataField="i_qty" HeaderText="Qty" SortExpression="i_qty" />
                <asp:CommandField ButtonType="Button" HeaderText="Edit" ShowEditButton="True" />
                <asp:CommandField ButtonType="Button" HeaderText="Delete" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" 
            SelectCommand="SELECT [i_id], [isbn], [title], [author], [genre], [price], [i_type], [i_qty] FROM [Items] WHERE ([i_delete] = @i_delete)"
            UpdateCommand="UPDATE Items SET [isbn]=@isbn, [title]=@title, [author]=@author, [genre]=@genre, [price]=@price, [i_type]=@i_type, [i_qty] = @i_qty WHERE ([i_id]=@i_id)"
            DeleteCommand="UPDATE Items SET i_delete=1 WHERE ([i_id]=@i_id)">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="i_delete" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="isbn" Type="String" />
                <asp:Parameter Name="title" Type="String" />
                <asp:Parameter Name="author" Type="String" />
                <asp:Parameter Name="genre" Type="String" />
                <asp:Parameter Name="price" Type="Decimal" />
                <asp:Parameter Name="i_type" Type="String" />
                <asp:Parameter Name="i_qty" Type="Int32" />
                <asp:ControlParameter ControlID="GridView2" Name="i_id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView2" Name="i_id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <div class="btn-container">
            <asp:Label ID="Label1" runat="server" Text="ISBN"></asp:Label>
            <asp:TextBox ID="txt_isbn" runat="server" />

            <asp:Label ID="Label2" runat="server" Text="Title"></asp:Label>
            <asp:TextBox ID="txt_title" runat="server" />

            <asp:Label ID="Label3" runat="server" Text="Author"></asp:Label>
            <asp:TextBox ID="txt_author" runat="server" />

            <asp:Label ID="Label4" runat="server" Text="Genre"></asp:Label>
            <asp:TextBox ID="txt_genre" runat="server" />

            <asp:Label ID="Label5" runat="server" Text="Price"></asp:Label>
            <asp:TextBox ID="txt_price" runat="server" />

            <asp:Label ID="Label6" runat="server" Text="Item Type"></asp:Label>
            <asp:TextBox ID="txt_type" runat="server" />

            <asp:Label ID="Label9" runat="server" Text="Quantity"></asp:Label>
            <asp:TextBox ID="txt_qty" runat="server" />
            <br />
            <br />
            <div class="edit-delete-buttons">
                <asp:Button ID="btn_insert" runat="server" OnClick="btn_insert_Click" Text="Submit" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
