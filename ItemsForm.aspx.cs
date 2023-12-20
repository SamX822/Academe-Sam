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
    public partial class ItemsForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                reload();
            }
        }

        void reload()
        {
            con.Open();
            cmd = new SqlCommand("ItemsView");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds, "ItemsView");
            //GridView1.DataSource = ds.Tables[0];
            //GridView1.DataBind();
            con.Close();
        }

        protected void btn_toCustForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerForm.aspx");
        }

        void refresh()
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_insert_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("InsertItems");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@isbn", txt_isbn.Text.Trim());
            cmd.Parameters.AddWithValue("@title", txt_title.Text.Trim());
            cmd.Parameters.AddWithValue("@author", txt_author.Text.Trim());
            cmd.Parameters.AddWithValue("@genre", txt_genre.Text.Trim());
            cmd.Parameters.AddWithValue("@price", txt_price.Text.Trim());
            cmd.Parameters.AddWithValue("@type", txt_type.Text.Trim());
            cmd.Parameters.AddWithValue("@i_qty", txt_qty.Text.Trim());
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();

            //reload();
            refresh();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchBar = txtSearch.Text;

            if (!String.IsNullOrEmpty(txtSearch.Text))
            {
                var existingParameter = SqlDataSource1.SelectParameters["searchTitle"];
                if (existingParameter != null)
                {
                    SqlDataSource1.SelectParameters.Remove(existingParameter);
                }

                SqlDataSource1.SelectParameters.Add("searchTitle", "%" + searchBar + "%");

                SqlDataSource1.SelectCommand = "SELECT [i_id], [isbn], [title], [author], [genre], [price], [i_type], [i_qty] FROM [Items] WHERE ([i_delete] = @i_delete) AND ([title] LIKE @searchTitle)";
            }
            else
            {
                refresh();
            }
        }

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void btn_toAdminsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminForm.aspx");
        }

        protected void btn_toAdminForms_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminOrders.aspx");
        }
    }
}