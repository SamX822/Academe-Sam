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
    public partial class AdminOrders : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        string ord;

        protected void Page_Load(object sender, EventArgs e)
        {
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("AdminOrdersItemsView", con); // Specify the connection for the command
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@index", txt_index.Text);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "AdminOrdersItemsView");
            GridView2.DataSource = ds;
            GridView2.DataBind();
            con.Close();

            GridView2.Visible = true;
        }

        protected void btn_toAdminsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminForm.aspx");
        }

        protected void btn_toItemsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("ItemsForm.aspx");
        }

        protected void btn_toCustForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerForm.aspx");
        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {
            // Manually update the parameter value from the txt_index control
            SqlDataSource1.SelectParameters["index"].DefaultValue = txt_index.Text;

            // Rebind the data to GridView1
            GridView1.DataBind();

            GridView2.Visible = false;
        }

    }
}