using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication1
{
    public partial class BookStoreForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        String user, index;
        int total = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            string query = "SELECT c.C_name FROM [Login] l INNER JOIN Customer c ON l.log_email = c.C_email";
            using (SqlCommand log = new SqlCommand(query, con))
            {
                con.Open();
                user = Convert.ToString(log.ExecuteScalar());
                con.Close();

                lbl_login.Text = user;
            }

            index = "SELECT c.C_id FROM [Login] l INNER JOIN Customer c ON l.log_email = c.C_email";
            using (SqlCommand ind = new SqlCommand(index, con))
            {
                con.Open();
                index = Convert.ToString(ind.ExecuteScalar());
                con.Close();

                lbl_index.Text = index;
            }
        }

        void refresh()
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            txt_isbn.Text = GridView2.SelectedRow.Cells[1].Text;
            txt_title.Text = GridView2.SelectedRow.Cells[2].Text;
            txt_author.Text = GridView2.SelectedRow.Cells[3].Text;
            txt_genre.Text = GridView2.SelectedRow.Cells[4].Text;
            txt_price.Text = GridView2.SelectedRow.Cells[5].Text;
            txt_type.Text = GridView2.SelectedRow.Cells[6].Text;
        }

        protected void btn_addCart_Click(object sender, EventArgs e)
        {
            if (!txt_qty.Text.Equals(""))
            {
                int requestedQuantity = Convert.ToInt32(txt_qty.Text);

                // Get the available quantity from GridView2
                int availableQuantity = Convert.ToInt32(GridView2.SelectedRow.Cells[7].Text);

                if (requestedQuantity <= availableQuantity)
                {
                    string query1 = "SELECT COUNT(*) FROM BookCart WHERE isbn = @isbn";

                    using (SqlCommand cemd = new SqlCommand(query1, con))
                    {
                        cemd.Parameters.AddWithValue("@isbn", txt_isbn.Text);

                        con.Open();

                        int cont = (int)cemd.ExecuteScalar();

                        if (cont > 0)
                        {
                            lbl_Status.Text = "This item is already in the cart.";
                            con.Close();
                        }
                        else if (cont < 1)
                        {
                            con.Close();
                            con.Open();
                            cmd = new SqlCommand("InsertBookCart");
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@isbn", txt_isbn.Text.Trim());
                            cmd.Parameters.AddWithValue("@title", txt_title.Text.Trim());
                            cmd.Parameters.AddWithValue("@author", txt_author.Text.Trim());
                            cmd.Parameters.AddWithValue("@genre", txt_genre.Text.Trim());
                            cmd.Parameters.AddWithValue("@type", txt_type.Text.Trim());
                            cmd.Parameters.AddWithValue("@price", txt_price.Text.Trim());
                            cmd.Parameters.AddWithValue("@qty", txt_qty.Text.Trim());
                            cmd.Parameters.AddWithValue("@C_id", lbl_index.Text.Trim());
                            cmd.Connection = con;
                            cmd.ExecuteNonQuery();
                            con.Close();

                            refresh();
                        }
                    }
                }
                else
                {
                    lbl_Status.Text = "Requested quantity exceeds available quantity.";
                }
            }
            else
            {
                lbl_Status.Text = "Please enter a quantity";
            }
        }

        void clearCart()
        {
            con.Open();
            cmd = new SqlCommand("ClearCart");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@C_id", lbl_index.Text.Trim());
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();
            refresh();
        }

        protected void btn_removeCart_Click(object sender, EventArgs e)
        {
            clearCart();
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("ClearLogin");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("LoginForm.aspx");
        }

        protected void btn_order_Click(object sender, EventArgs e)
        {
            if (!(GridView3.Rows.Count == 0))
            {
                if (!txt_shipping.Text.Equals(""))
                {
                    foreach (GridViewRow row in GridView3.Rows)
                    {
                        string isbn = row.Cells[0].Text; // Assuming the ISBN is in the first cell of GridView3
                        double price = Convert.ToDouble(row.Cells[6].Text);
                        int quantity = Convert.ToInt32(row.Cells[5].Text); // Assuming the quantity is in the sixth cell of GridView3

                        //Checks if the item type is a book or not
                        string bookType = row.Cells[4].Text.Trim().ToLower();
                        if (bookType.Trim().Equals("book"))
                        {
                            // Update the quantity in the Items table (GridView2)
                            UpdateItemQuantity(isbn, quantity);
                        }

                        CalculateTotalPrice(price);
                    }//end of foreach

                    string query3 = "INSERT INTO ShoppingCart (C_id, cart_totalAmt) " +
                                   "SELECT c.C_id, @total " +
                                   "FROM [Login] l " +
                                   "INNER JOIN Customer c ON l.log_email = c.C_email " +
                                   "INNER JOIN [BookCart] bc ON bc.C_id = c.C_id " +
                                   "INNER JOIN [Items] i ON i.isbn = bc.isbn " +
                                   "WHERE bc.C_id = c.C_id AND i.isbn = bc.isbn";

                    using (SqlCommand cmd = new SqlCommand(query3, con))
                    {
                        con.Open();
                        cmd.Parameters.AddWithValue("@total", total);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }

                    DateTime dt = DateTime.Today;
                    string query1 = "INSERT INTO Orders (O_date, O_shipAddress, C_id) " +
                                   "SELECT @O_date, @shipAddress, c.C_id " +
                                   "FROM [Login] l " +
                                   "INNER JOIN Customer c ON l.log_email = c.C_email " +
                                   "INNER JOIN [BookCart] bc ON bc.C_id = c.C_id " +
                                   "INNER JOIN [Items] i ON i.isbn = bc.isbn " +
                                   "WHERE bc.C_id = c.C_id AND i.isbn = bc.isbn";

                    // Now, you need to provide the parameter values when executing the query
                    // For example, using SqlCommand in C#:
                    using (SqlCommand cmd = new SqlCommand(query1, con))
                    {
                        con.Open();
                        cmd.Parameters.AddWithValue("@O_date", dt);
                        cmd.Parameters.AddWithValue("@shipAddress", txt_shipping.Text);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }

                    foreach (GridViewRow row in GridView3.Rows)
                    {
                        string isbn = row.Cells[0].Text;
                        int qty = Convert.ToInt32(row.Cells[5].Text);
                        double price = Convert.ToDouble(row.Cells[6].Text);
                        AddOrdDetails(isbn, price, qty);
                    }

                    // After updating quantities, clear the cart
                    clearCart();
                }
                else
                {
                    lbl_cartStatus.Text = "Please enter a shipping address.";
                }
            }
            else
            {
                lbl_cartStatus.Text = "Cart is currently empty.";
            }
        }

        private void AddOrdDetails(string isbn, double price, int qty)
        {
            // Perform the update query here
            string updateQuery = "INSERT INTO OrdDetails (o_id, i_id, total_price, qty) " +
                "SELECT o.O_id, i.i_id, @total_price, @qty FROM [Login] l " +
                "INNER JOIN [Customer] c ON c.C_email = l.log_email " +
                "INNER JOIN [Orders] o ON o.C_id = c.C_id " +
                "INNER JOIN [Items] i ON i.isbn = @isbn " +
                "WHERE c.C_id = @index AND i.isbn = @isbn";

            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
            {
                updateCmd.Parameters.AddWithValue("@isbn", isbn);
                updateCmd.Parameters.AddWithValue("@qty", qty);
                updateCmd.Parameters.AddWithValue("@total_price", price);
                updateCmd.Parameters.AddWithValue("@index", lbl_index.Text);

                con.Open();
                updateCmd.ExecuteNonQuery();
                con.Close();
            }
        }
        
        private void CalculateTotalPrice(double price)
        {
            total = total + (int)price;
        }

        // Helper method to update the quantity in the Items table
        private void UpdateItemQuantity(string isbn, int quantity)
        {
            // Perform the update query here
            string updateQuery = "UPDATE Items SET i_qty = i_qty - @quantity WHERE isbn = @isbn";

            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
            {
                updateCmd.Parameters.AddWithValue("@isbn", isbn);
                updateCmd.Parameters.AddWithValue("@quantity", quantity);

                con.Open();
                updateCmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void btn_orderList_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrdersForm.aspx");
        }
    }
}