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
    public partial class AdminForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(localdb)\\v11.0;Initial Catalog=MontecilloDB;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void refresh()
        {
            Response.Redirect(Request.RawUrl);
        }

        protected void btn_toItemsForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("ItemsForm.aspx");
        }

        protected void btn_insert_Click(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand("InsertAdmin");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@a_userID", txt_userID.Text.Trim());
            cmd.Parameters.AddWithValue("@a_pass", txt_pass.Text.Trim());
            cmd.Parameters.AddWithValue("@a_secure", txt_secure.Text.Trim());
            cmd.Connection = con;
            cmd.ExecuteNonQuery();
            con.Close();

            //reload();
            refresh();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchBar = txtSearch.Text;
            var existingParameter = MonteDB.SelectParameters["searchName"];

            if (!String.IsNullOrEmpty(txtSearch.Text))
            {
                if (existingParameter != null)
                {
                    MonteDB.SelectParameters.Remove(existingParameter);
                }

                MonteDB.SelectParameters.Add("searchName", "%" + searchBar + "%");

                MonteDB.SelectCommand = "SELECT * FROM [Admin] WHERE ([a_userID] LIKE @searchName)";
            }
            else
            {
                refresh();
            }
        }

        protected void btn_toCustForm_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerForm.aspx");
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

        protected void btn_toAdminOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminOrders.aspx");
        }
    }
}