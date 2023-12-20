<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookStoreForm.aspx.cs" Inherits="WebApplication1.BookStoreForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Book Store</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }

        #form1 {
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

        .btn {
            background-color: #6fa4d9;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        #lbl_index {
            color: white;
        }

        #lbl_welcome {
            font-size: 18px;
            margin-top: 10px;
        }

        #GridView2,
        #GridView3 {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        #GridView2 th,
        #GridView2 td,
        #GridView3 th,
        #GridView3 td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .input-label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        .form-input {
            width: 100%;
            box-sizing: border-box;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .checkout-btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 20px;
        }

        #lbl_cartStatus {
            margin-top: 10px;
            color: #ffae00;
        }

        #lbl_Status {
            margin-top: 10px;
            color: #ff0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label8" runat="server" Text="Book Store"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="btn" />
            <asp:Button ID="btn_orderList" runat="server" OnClick="btn_orderList_Click" Text="View Orders" CssClass="btn" />
            <br />
            <asp:Label ID="lbl_index" runat="server"></asp:Label>
            <br />
            <asp:Label ID="lbl_welcome" runat="server">Welcome!</asp:Label>
            <asp:Label ID="lbl_login" runat="server"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                <Columns>
	                <asp:CommandField HeaderText="Select" ShowSelectButton="True" />
	                <asp:BoundField DataField="isbn" HeaderText="ISBN" SortExpression="isbn" />
	                <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
	                <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" />
	                <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
	                <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
	                <asp:BoundField DataField="i_type" HeaderText="Type" SortExpression="i_type" />
	                <asp:BoundField DataField="i_qty" HeaderText="Qty" SortExpression="i_qty" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" SelectCommand="SELECT [isbn], [title], [author], [genre], [price], [i_type], [i_qty] FROM [Items] WHERE ([i_delete] = @i_delete)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="i_delete" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <label for="txt_isbn" class="input-label">ISBN</label>
            <asp:TextBox ID="txt_isbn" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_title" class="input-label">Title</label>
            <asp:TextBox ID="txt_title" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_author" class="input-label">Author</label>
            <asp:TextBox ID="txt_author" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_genre" class="input-label">Genre</label>
            <asp:TextBox ID="txt_genre" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_price" class="input-label">Price</label>
            <asp:TextBox ID="txt_price" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_type" class="input-label">Item Type</label>
            <asp:TextBox ID="txt_type" runat="server" CssClass="form-input" ReadOnly="True"></asp:TextBox>
            <label for="txt_qty" class="input-label">Quantity</label>
            <asp:TextBox ID="txt_qty" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:Button ID="btn_addCart" runat="server" Text="Add to Cart" OnClick="btn_addCart_Click" CssClass="checkout-btn" />
            <asp:Button ID="btn_removeCart" runat="server" Text="Clear Cart" OnClick="btn_removeCart_Click" CssClass="checkout-btn" />
            <br />
            <br />
            <asp:Label ID="lbl_Status" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Label ID="lbl_cartStatus" runat="server"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="GridView3" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="isbn" DataSourceID="SqlDataSource2">
                <Columns>
	                <asp:BoundField DataField="isbn" HeaderText="ISBN" ReadOnly="True" SortExpression="isbn" />
	                <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
	                <asp:BoundField DataField="author" HeaderText="Author" SortExpression="author" />
	                <asp:BoundField DataField="genre" HeaderText="Genre" SortExpression="genre" />
	                <asp:BoundField DataField="i_type" HeaderText="Type" SortExpression="i_type" />
	                <asp:BoundField DataField="qty" HeaderText="Qty" SortExpression="qty" />
	                <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
	                <asp:BoundField DataField="C_id" SortExpression="ID" ShowHeader="False" Visible="False" >
	                </asp:BoundField>
	                <asp:CommandField ButtonType="Button" DeleteText="Remove" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MontecilloDBConnectionString %>" SelectCommand="SELECT * FROM [BookCart] WHERE ([C_id] = @C_id)" DeleteCommand="DELETE FROM [BookCart] WHERE ([isbn] = @isbn AND [C_id] = @C_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lbl_index" Name="C_id" PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="lbl_index" Name="C_id" PropertyName="Text" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <label for="txt_shipping" class="input-label">Enter Shipping Address:</label>
            <asp:TextBox ID="txt_shipping" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:Button ID="btn_order" runat="server" OnClick="btn_order_Click" Text="Checkout" CssClass="checkout-btn" />
        </div>
    </form>
</body>
</html>
