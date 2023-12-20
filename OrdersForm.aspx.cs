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
    public partial class OrdersForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string index, ord;

        protected void Page_Load(object sender, EventArgs e)
        {
            index = "SELECT c.C_id FROM [Login] l INNER JOIN Customer c ON l.log_email = c.C_email";
            using (SqlCommand ind = new SqlCommand(index, con))
            {
                con.Open();
                index = Convert.ToString(ind.ExecuteScalar());
                con.Close();

                lbl_index.Text = index;
            }

            ord = "SELECT o.O_id FROM [Orders] o INNER JOIN Customer c ON o.C_id = c.C_id WHERE c.C_id = @index";
            using (SqlCommand ind = new SqlCommand(ord, con))
            {
                ind.Parameters.AddWithValue("@index", lbl_index.Text);
                con.Open();
                SqlDataReader reader = ind.ExecuteReader();

                // Create a list to store multiple O_id values
                List<int> orderIds = new List<int>();

                while (reader.Read())
                {
                    orderIds.Add(Convert.ToInt32(reader["O_id"]));
                }

                // Store the list of O_id values in a ViewState variable
                ViewState["OrderIds"] = orderIds;

                con.Close();
            }
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

        protected void btn_return_Click(object sender, EventArgs e)
        {
            Response.Redirect("BookStoreForm.aspx");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Retrieve the list of O_id values from ViewState
            List<int> orderIds = (List<int>)ViewState["OrderIds"];

            con.Open();

            foreach (int orderId in orderIds)
            {
                cmd = new SqlCommand("OrdersItemsView");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@index", lbl_index.Text);
                cmd.Parameters.AddWithValue("@O_id", orderId);  // Use the current O_id value
                cmd.Connection = con;
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds, "OrdersItemsView");
                GridView2.DataSource = ds;
                GridView2.DataBind();
            }

            con.Close();
        }

    }
}